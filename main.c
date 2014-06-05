//==========================================================
// �{���s��: CYD670
// �{���W��: 
// �{�����g: Hj
// IDE ����: MPLAB 8.93
// ��Ķ�u��: Hi-Tech PICC V9.83 PRO
// ��������: PIC16F883							
// �}�l�ɶ�: 2014/05/09						
// �����ɶ�: ?							
// �{������: V1.0
//----------------------------------------------------------
// �����s�� : V1.0
// �o���� : 
// �K�n�O�� : 
//==========================================================

//==========================================================
// Include Header Files			
//==========================================================
#include "system.h"


//==========================================================
// Configuartion Bit Setting
//==========================================================
	//__CONFIG  (HS &WDTEN &PWRTEN &MCLRDIS &PROTECT &BOREN &IESOEN &FCMEN);  // FOR PICC 9.80
	__CONFIG  (FOSC_INTRC_NOCLKOUT & WDTE_OFF & PWRTE_ON & MCLRE_OFF & CP_OFF & BOREN_ON & IESO_OFF & FCMEN_ON & LVP_OFF & DEBUG_OFF);	// FOR PICC 9.83
	__IDLOC   (0000);


//==========================================================
// �ѼƩw�q&�Ȧs���w�q	
//==========================================================
//bit fTestMode=0;
bit f10ms=0;
U8 b10ms=0;
U8 b50ms=0;
U8 b1s=0;
U8 bTBCnt=0;

//U8 bKeyNum=0;


#define	dKeyHT2s	200		// 10ms*200=2s
#define dKeyHT		70		// 10ms*70=0.7s (Hold Key Debounce Time)
#define	dReptT		20		// 10ms*30=0.3s (Repeat Key Time)
#define	dRun1T		255
#define dKeyInit	0xFF
bit fKeyPress = 0;
U8 bKeyHTCnt = 0;


U8 bRunMode=0;			// 0:normal  1:P1  2:P2
U8 bRunStep=0;
U8 bRunCnt=0;

#define		dRunMinT	50	// ���`��w�]�ɶ�
#define		dDefHour	1	// �X�t�w�]�p�ɮɶ�
#define		dDefMin		0
//U8 bSetHour = dDefHour;
//U8 bSetMin = dDefMin;
U32 bSetTmp=0;

U8 bHour = 0;
U8 bMin = 0;
U8 bSec = 0;

#define mResetFlash(ft) {bFlashCnt=ft; fFlash=1;}
bit fFlash=0;
U8 bFlashCnt=0;
//U32 TotalLiter=0;


bit fRunWash=0;
U8 bRunWashStep=0;
U8 bRunWashT=0;


U8 bPulseCnt=0;

bit fCapInit=0;
U8 bTMR1U=30;

bit fCalFlow=0;
U8 bCapT2=0;
U8 bCapT1=0;
U8 bCapT0=0;

U16 wWFlow=0;
bit fFirstLoad = 0;
U16 arrFlow[16];
U8  bFlowIdx = 0;
U16 arrFlow2[8];
U8  bFlowIdx2 = 0;
U32 wSum = 0;

bit fErr=0;

bit fSaveEE=0;
U8  bSaveEECnt=0;

union {
	U8	arrEEData[7];
	struct {
		U32 TOLLITER;
		U8	SETHOUR;
		U8	SETMIN;
		U8	STAT;
	} var;
}EE_DATA;

#define	bEEStat  	EE_DATA.var.STAT
#define	TotalLiter  EE_DATA.var.TOLLITER
#define	bSetHour	EE_DATA.var.SETHOUR
#define	bSetMin		EE_DATA.var.SETMIN


/*
U8 	bEEStat;
U32	TotalLiter;
U8	bSetHour;
U8	bSetMin;
*/

#define	EE_TOL_LITER	01		// 4bytes
#define	EE_SET_HOUR		05		// 1byte
#define	EE_SET_MIN		06		// 1byte
#define	EE_STAT			07		// 1bytes

U8	bTestCnt=0;
U16 wTestPulseCnt=0;
U8 bFilterCnt=0;
//==========================================================
// �禡�쫬�ŧi					
//==========================================================
void pFunTestKey (void);
void pSwitchMode (U8 mod);
void pTuneValue (U8* ptb,S8 rank,U8 max,U8 min);
void pRstFlash (U8 ft);
void pDispProc (void);
void pKeyProc (void);
void pReadEE(void);

void pTuneHour (void);
void pTuneMin (void);

void pRunStep (U8 step);
void pConLiter (U32 dat,U8 part);
void pConStr (U8 s2,U8 s1,U8 s0);

void pWashFlow (void);
void pCalWaterFlow (void);
void pRunWashFlow (void);

void pTimeProc (void);
void pReLoadTime (void);
void pFlashTimeCtl (void);
void pEESaveTimeCtl (void);

void pTestMode(void);
U8 key_press (void);
U16 filter(U16	*ptArr);
//==========================================================
// ���_�Ƶ{�� 
// static void interrupt isr (void) �� Hi-Tech C ���_�Ƶ{��
//==========================================================
static void interrupt isr (void)
{
//----------------------------------------------// Timer0 Read Input Pluse
	if (T0IF)
	{
		T0IF=0;
		TMR0=246;								// 10 Pluse Interrupt

		// Capture Pulse Time
		if (fCapInit)
		{
			TMR1ON=0;
			
			if (!fCalFlow)
			{
				if (TMR1IF)
				{
					TMR1IF=0;
					bTMR1U++;
				}					
				
				bCapT0=TMR1L;
				bCapT1=TMR1H;
				bCapT2=bTMR1U;
				fCalFlow=1;
			}
			bTMR1U=0;
			TMR1=0;
			TMR1ON=1;
		}
		// Iinitial Capture Pulse Time
		else
		{
			TMR1=0;
			bTMR1U=0;
			TMR1IF=0;
			TMR1IE=1;
			TMR1ON=1;
			fCapInit=1;
		}
		
		// �֥[���ɼ�
		++wTestPulseCnt;
		++bPulseCnt;
		if (bPulseCnt >= dPulseL)
		{
			bPulseCnt=0;
			if (TotalLiter < 999999)
				TotalLiter++;
		}
	}
//----------------------------------------------// Timer1 2ms Intrrupt
	if (TMR1IF)
	{
		TMR1IF = 0;
		
		// �C�����y�q1����Pluse�̤j�ɶ���
		// 1/(330/60)= 0.182s
		// 10��Pulse�ɶ���1.82s
		// 1.82*1000000/65536 = 27.74
		// ��ܷ�ɶ��p�� > 30*65536�ɡA�N��L�y��
		
		if (++bTMR1U >= 28)			
		{
			TMR1ON = 0;
			TMR1IE = 0;
			TMR1IF=0;
			bTMR1U=30;
			TMR1=0;			
			fCapInit=0;	
			fFirstLoad=0;
			wWFlow=0;		
		}	

		//#asm
		//	MOVLW	0x18;						// ���t�զX�y��,�ܼƻݥ[ "_"
		//	ADDWF	_TMR1L,F					// "_�ܼƦW��"
		//	MOVLW	0xFC;
		//	ADDWF	_TMR1H,F
		//#endasm	
	}
//----------------------------------------------// Timer1 2ms Intrrupt
	if (TMR2IF)
	{
		TMR2IF=0;
	
		oS0=1;
		oS1=1;
		oS2=1;
		oS3=1;
		
		if (!iPDn)
		{
			if (!fSaveEE)
			{
				//oTest1=0;
				//memcpyee(EE_TOL_LITER,EE_DATA.arrEEData,4);	// compiler ����...
				eeprom_write(EE_TOL_LITER+0,EE_DATA.arrEEData[0]);
				eeprom_write(EE_TOL_LITER+1,EE_DATA.arrEEData[1]);
				eeprom_write(EE_TOL_LITER+2,EE_DATA.arrEEData[2]);
				eeprom_write(EE_TOL_LITER+3,EE_DATA.arrEEData[3]);
				bSaveEECnt=0;
				fSaveEE=1;		// 5�����i���x�s
				//oTest1=1;
			}
		}
		
		pScanKey();		// ���䱽��
		pScanDisp();	// ��ܱ���
		
		if (++b10ms>=5)
		{
			b10ms=0;
			f10ms=1;
		}
	}
}


//==========================================================
// MAIN PROGRAM 					
//==========================================================
void main(void)
{	
	pInitMCU();				// MCU ��l��
	pClrDisp();	
	
	//fPowerOn=0;
	fSaveEE=1;
	pReadEE();

	//TMR1ON = 1;			
	TMR2ON = 1;				// TimeBase
	GIE = 1;
//---- delay 100ms----
	bTBCnt=10;
	do
	{
		if (f10ms)
		{
			f10ms=0;
			T0IF=0;
			TMR0=246;
			bTBCnt--;
		}
	} while(bTBCnt);
	
	// �}���P�ɫ���]�w�P�˵���,�i�J�۴��Ҧ�
	if (!fKeySET && !fKeyVIEW)
		pTestMode();


//-------------------
// �Ұ����000-111-222-....999		
	bRunCnt=0;
	bTestCnt=0;
	
	do
	{
		if (f10ms)
		{	
			f10ms = 0;
			
			bSeg0 = ~tabSeg[bTestCnt];
			bSeg1 = ~tabSeg[bTestCnt];
			bSeg2 = ~tabSeg[bTestCnt];

			if (++bRunCnt>=30)
			{
				bRunCnt=0;
				bTestCnt++;
			}
		}
	}while (bTestCnt!=10);

	//TotalLiter = 999990L;
	//fPowerOn=1;
//---- main loop ----		// �D�{���j��
	while (1)
	{
		if (f10ms)
		{
			f10ms = 0;
			pKeyProc();					// Key Process
				
			//--------------------------
			// 100ms run
			switch (bTBCnt)
			{
				case 0:
					pFlashTimeCtl();	// �{�{����	
					pEESaveTimeCtl();	// EEData�x�s�p��
				break;
			
				case 1:
					pDispProc();		// display process
				break;
				
				case 2:
					pWashFlow();		// wash flow
				break;
				
				case 3:

				break;
				
			} // end switch
			
			if (++bTBCnt >= 10)
			{
				bTBCnt=0;
			}
			
			// 50ms run	
			if (++b50ms >= 5)		// 10ms * 5 = 50ms
			{
				b50ms=0;
				pCalWaterFlow();	// Calculature Water Flow
			}
			
			
			// 1s run
			if (++b1s >= 100)		// 10 for test
			{
				b1s=0;
				pTimeProc();		// �p�ɱ���
			}
			
			
		} // end if (10ms)
	} // end while(1)
} // end main

//---------------------------------------------------------
// �{�{����
void pFlashTimeCtl (void)
{
	if (bFlashCnt==0)	// Flash Control	
	{
		bFlashCnt = 4;
		fFlash = !fFlash;
	}
	else
		bFlashCnt--;	
}


//==========================================================
// �Ƶ{���W�� : ����B�z�{�� (10ms run)
//----------------------------------------------------------
// �禡��� : void pKeyProc (void)
//----------------------------------------------------------
// �\��y�z:
//   ����ɧY�ʧ@�A�B��Hold����γs����\��
//----------------------------------------------------------
// �禡�ϥλ���: 
// �ǤJ�Ѽƻ���: �L
// ��X�Ѽƻ���: �L
// �䥦:
//==========================================================
void pKeyProc (void)
{
	if (fKeyPress)
	{
		// ��}����
		if (bKeyData.byte == dKeyInit)			
		{
			fKeyPress = 0;
		}
//----------------------------------------------// Hold Key Process...
		// Hold����p��
		if (bKeyHTCnt == 0)	
		{
			if (!fKeySET)
			{
				if (bRunMode == 0)
				{
					bSetTmp=bSetHour;		// ���J�ɳ]�w
					pSwitchMode(1);
				}
				bKeyHTCnt=dRun1T;			// run one time
			}
			else if (!fKeyVIEW)
			{


				//goto	_REPT_KEY;
			}
			else if (!fKeyWASH)
			{
				// repeat key...
//_REPT_KEY:
				bKeyHTCnt = dReptT; 	// �s�������ɶ� 0.3s
				goto	_WASH_KEY;
			}
		}
		else if (bKeyHTCnt != dRun1T)
			bKeyHTCnt--;
	}
//----------------------------------------------// Key Down Process...
	else 										
	{
		// �]�w��
		if (!fKeySET)
		{
			// Key Press...
			switch (bRunMode)
			{
				// ���`�Ҧ��U,��2��i�J�]�w�Ҧ�
				case 0:
					bKeyHTCnt = dKeyHT2s;		// 2s
				break;

				// �]�wP1�Ҧ�(�ɶ��]�w)�U,���]�w������
				case 1:
					if (bRunStep==1)
					{
						if (bSetHour!=bSetTmp)
						{
							bSetHour = bSetTmp;		// �x�s�ɳ]�w
							eeprom_write(EE_SET_HOUR,bSetHour);
						}

						pRunStep(2);			// ��ܤp�ɳ]�w2��
					}
					// ���]�w����
					else if (bRunStep==3)
					{
						if (bSetMin!=bSetTmp)
						{
							bSetMin = bSetTmp;		// �x�s���]�w
							eeprom_write(EE_SET_MIN,bSetMin);
						}

						pReLoadTime();			// �����]�w�ɶ�
						pRunStep(6);				// ��ܤ��]�w2��
					}
				break;
				
				// �]�wP2�Ҧ��U(�M�����ɼ�),���]�w������
				case 2:
					if (bSetTmp==0)
						TotalLiter = 0;		// �x�s���ƭ�
					pSwitchMode(0);			// ���^���`�Ҧ�
				break;
			}
			
			goto	_KPRESS2;
		}
		//--------------------------------------
		// �R�~��
		else if (!fKeyWASH)
		{
_WASH_KEY:
			// Key Press...
			switch (bRunMode)
			{
				// ���`�Ҧ��U,����R�~
				//case 0:
				//	pRunWashFlow();
				//break;
				
				// �]�wP1�Ҧ�(�ɶ��]�w)�A���ɶ��վ���
				case 1:
					if (bRunStep==1)
						pTuneHour();	// set hour
					if (bRunStep==3)
						pTuneMin();		// set min
				break;
				
				// �]�wP2�Ҧ�(�M�����ɼ�)�A���M�����ɭp�ƭ���
				case 2:
					if (bRunStep>0)
						bSetTmp=0;		// �M�����ɭp�ƭ�
				break;
				
				// ���`�Ҧ��U,����R�~
				default:
					pRunWashFlow();
				break;
			}
			goto	_KPRESS;
		}
		//--------------------------------------
		// �˵���
		else if (!fKeyVIEW)
		{
			// Key Press...
			switch (bRunMode)
			{
				// ���`�Ҧ��U,��ܶZ���ɶ�
				case 0:	
					pSwitchMode(3);			// ��ܶZ���ɶ��Ҧ�
				break;
				
				// �]�w�Ҧ�P1,�L�ާ@
				case 1:

				break;
				
				// �]�w�Ҧ�P2,�L�ާ@
				case 2:
				
				break;
				
				// ��ܶZ���ɶ�
				case 3:
					if (bRunStep<2)			// ������ܤ��ɼ�
						pRunStep(2);
					else
						pSwitchMode(0);			
				break;
				
			}
			//goto	_KPRESS;
_KPRESS:	if (!fKeyPress)
				bKeyHTCnt = dKeyHT;			// 0.7s
_KPRESS2:	fKeyPress = 1;
		}
	}
}
//----------------------------------------------------------
// �Ҧ�����
void pSwitchMode (U8 mod)
{
	bRunMode=mod;
	bRunStep=0;
	bRunCnt=0;
	mResetFlash(3);
}				
//----------------------------------------------------------
// �վ�ɳ]�w��
void pTuneHour (void)
{
	bSetTmp++;
	if (bSetTmp > 24)
		bSetTmp=0;
		
	mResetFlash(7);		// �վ�ɤ��{�{
	bRunCnt=0;			// ���ާ@�p�ɭ��m
}
//----------------------------------------------------------
// �վ���]�w��
// �Y�ɳ]�m��00,�h���վ�10,20..50,�Y�ɳ]�m��24,�h����00
void pTuneMin (void)
{
	if (bSetHour==24)
		bSetTmp=0;
	else
	{
		bSetTmp+=10;
		
		if (bSetTmp>50)
		{
			if (bSetHour == 0)
				bSetTmp = 10;
			else
				bSetTmp = 0;
		}
	}
	mResetFlash(7);		// �վ�ɤ��{�{
	bRunCnt=0;			// ���ާ@�p�ɭ��m
}

/*
void pTuneValue (U8* ptb,S8 rank,U8 max,U8 min)
{
	S16 val;
	
	val = (S16)*ptb + rank;
	
	//if (val < min)
	//	val = max;
	if (val > max)
		val = min;

	*ptb = (U8)val;
	
	// �վ�ɤ��{�{
	mResetFlash(7);
	
	// ���ާ@�p�ɭ��m
	bRunCnt=0;
}
*/

//----------------------------------------------------------
// ���m�{�{
//void _reset_flash (U8 ft)
//{
//	bFlashCnt = ft;
//	fFlash=1;
//}

//==========================================================
// �Ƶ{���W�� : ��ܳB�z�{�� (100ms run)
//----------------------------------------------------------
// �禡��� : void pDispProc (void)
//----------------------------------------------------------
// �\��y�z:
//   ���P�Ҧ��U��ܾާ@��T
//----------------------------------------------------------
// �禡�ϥλ���: 
// �ǤJ�Ѽƻ���: �L
// ��X�Ѽƻ���: �L
// �䥦:
//==========================================================
void pDispProc (void)
{
	U8 s0,s1,s2;
	
	switch (bRunMode)
	{
		
		//--------------------------
		// ���`�Ҧ���ܬy�q
		case 0:	
			pConDisp(wWFlow,1);
		break;

		//--------------------------
		// P1 �]�w�R�~�ɶ�
		case 1:	
			switch (bRunStep)
			{
				// ���P1�r��
				case 0:	
					s2=dP;
					s1=1;
					s0=dNull;
					
					if (++bRunCnt >= 20)	// ���P1 2��
						pRunStep(1);
				break;
				
				// ���hour
				case 1:	
					s2=dH;
					s1=dNull;
					s0=dNull;
					
					if (fFlash)				// �{�{��ܱ���
					{
						s1=bSetTmp/10;
						s0=bSetTmp%10;
					}
					
					if (++bRunCnt >= 100)	// 10���ާ@�h���^
						pSwitchMode(0);
				break;
				
				// ��ܤp�ɳ]�w2��
				case 2:
					s2=dH;
					s1=bSetHour/10;
					s0=bSetHour%10;

					if (++bRunCnt >= 20)	// 2����ܳ]�w��
					{
						if ((bSetHour==0)&&(bSetMin==0))	// �ˬd&���J���]�w	
							bSetTmp=10;
						else if (bSetHour==24)
							bSetTmp=0;
						else
							bSetTmp=bSetMin;
						pRunStep(3);		// �i�J���]�w
					}
				break;
				
				// ���minute
				case 3: 
					s2=dn;
					s1=dNull;
					s0=dNull;	
					
					if (fFlash)				// �{�{��ܱ���
					{
						s1=bSetTmp/10;
						s0=bSetTmp%10;
					}
					
					if (++bRunCnt >= 100)	// 10���ާ@�h�i��]�w�ˬd
						pRunStep(4);
				break;
				
				// ���ާ@���^,�ˬd�]�w��,�]�w���~���J�w�]��
				case 4:						
					if ((bSetHour==0)&&(bSetMin==0))
						bSetMin = dRunMinT;
					else if ((bSetHour==24)&&(bSetMin!=0))
						bSetMin = 0;
					else
						pSwitchMode(0);

					pRunStep(5);
				break;

				// �]�w���~�A���EEE�r��
				case 5:	
					s2=dE;
					s1=dE;
					s0=dE;
					
					fErr=1;
					
					if (++bRunCnt >= 20)	// ���EEE 2��
						pRunStep(6);		//
				break;
				
				// ��ܳ]�w��2��
				case 6:
					s2=dn;
					s1=bSetMin/10;
					s0=bSetMin%10;
		
					if (++bRunCnt >= 20)	// 2����ܳ]�w��
					{
						if (fErr)
						{
							fErr=0;
							pSwitchMode(0);		// ���^��ܬy�q
						}
						else
						{
							bSetTmp = TotalLiter;	// ���JP2���ɼ�
							pSwitchMode(2);			// �i�JP2���ɼƲM��
						}
					}
				break;
			}

			bSeg2 = ~tabSeg[s2];
			bSeg1 = ~tabSeg[s1];
			bSeg0 = ~tabSeg[s0];	
				
		break;
		
		//--------------------------
		// P2 �]�w�A���ɼƲM��
		case 2:	
			switch (bRunStep)
			{
				// ���P2�r��
				case 0:	
					bSeg2 = ~tabSeg[dP];
					bSeg1 = ~tabSeg[2];
					bSeg0 = ~tabSeg[dNull];	
					
					if (++bRunCnt >= 20)	// ���P1 2��
						pRunStep(1);
				break;
				
				// ��ܤ��ɼƫe3��,ex.123
				case 1:
					pConLiter(bSetTmp,1);
					
					if (++bRunCnt >= 40)	// ���4��
						pRunStep(2);
				break;
					
				// ��ܤ��ɼƫ�3��,ex.456
				case 2:
					pConLiter(bSetTmp,0);
					
					if (++bRunCnt >= 100)	// ���10��
						pSwitchMode(0);	
				break;
			}

		break;	

		//--------------------------
		// ��ܨR�~�Z���ɶ��A���ɼ�
		case 3:	
			switch (bRunStep)
			{
				// ���hour
				case 0:	
					s1=bHour/10;
					s0=bHour%10;
					
					bSeg2 = ~tabSeg[dH];
					bSeg1 = ~tabSeg[s1];
					bSeg0 = ~tabSeg[s0]&0x7F; // �p���I
					
					if (++bRunCnt >= 40)	// ���4��
						pRunStep(1);
				break;

				// ��ܤ�
				case 1:
					s1=bMin/10;
					s0=bMin%10;
					
					bSeg2 = ~tabSeg[dn];
					bSeg1 = ~tabSeg[s1];
					bSeg0 = ~tabSeg[s0];
					
					if (++bRunCnt >= 100)	// 10���ާ@�h���^�y�q���
						pSwitchMode(0);	
				break;
				
				// ��ܤ��ɼƫe3��,ex.123
				case 2:
					pConLiter(TotalLiter,1);
					
					if (++bRunCnt >= 40)	// ���4��
						pRunStep(3);
				break;
					
				// ��ܤ��ɼƫ�3��,ex.456
				case 3:
					pConLiter(TotalLiter,0);
					
					if (++bRunCnt >= 100)	// 10���ާ@�h���^�y�q���
						pSwitchMode(0);	
				break;
					
			}

		break;
	}
	
	
	// LED ��ܱ���
	if (fRunWash)
	{
		foLED_WH = 0;	// �R�~�O�G
		foLED_GW = 1;	// �s���O��
	}
	else
	{
		foLED_WH = 1;	// �R�~�O��
		foLED_GW = 0;	// �s���O�G
	}
}
//----------------------------------------------------------
// ���ܤU�@�B
void pRunStep (U8 step)
{
	bRunCnt=0;
	bRunStep=step;
	mResetFlash(3);
}

//----------------------------------------------------------
// ��ܤ��ɼ�
void pConLiter (U32 dat,U8 part)
{
	U8 s0,s1,s2;
	
	if (part==1)
		dat/=1000;
	
	s0=dat%10;
	dat/=10;
	s1=dat%10;
	dat/=10;
	s2=dat%10;
	
	bSeg0 = ~tabSeg[s0];
	bSeg1 = ~tabSeg[s1];
	bSeg2 = ~tabSeg[s2];

	
	// �p���I�{�{�p�ɱ���
	if (part==0)
	{
		bSeg0 &= 0x7F;
		//if (fFlash)
		//	bSeg0 &= 0x7F;
		//else
		//	bSeg0 |= 0x80;
	}
}

//==========================================================
// �Ƶ{���W�� : �R�~�{�� (10ms run)
//----------------------------------------------------------
// �禡��� : void pWashFlow (void)
//----------------------------------------------------------
// �\��y�z:
//   �M�~�y�{����
//----------------------------------------------------------
// �禡�ϥλ���: 
// �ǤJ�Ѽƻ���: �L
// ��X�Ѽƻ���: �L
// �䥦:
//==========================================================
void pWashFlow (void)
{
	if (fRunWash)
	{
		// ���m�p�ɮɶ�
		pReLoadTime();
		switch (bRunWashStep)
		{
			// �R�~�q�ϻ֥��}�A�J���q�ϻ������A����10��
			case 0:
				oRelayWash=1;
				oRelayWaIn=0;
				
				if (++bRunWashT >= 100)
				{
					bRunWashT=0;
					bRunWashStep++;
				}
			break;
			
			// �R�~�q�ϻ֥��}�A�J���q�ϻ֥��}�A����10��
			case 1:
				oRelayWash=1;
				oRelayWaIn=1;
				
				if (++bRunWashT >= 100)
				{
					bRunWashT=0;
					bRunWashStep=0;
					fRunWash=0;
				}
			break;		
		}
	}
	else
	{
		oRelayWash=0;
		oRelayWaIn=0;
		bRunWashStep=0;	
		bRunWashT=0;
	}
}
//----------------------------------------------------------
void pRunWashFlow (void)
{
	if (!fRunWash)
	{
		fRunWash=1;
		bRunWashStep=0;	
		bRunWashT=0;
	}
}

//==========================================================
// �Ƶ{���W�� : �y�q�p�� (50ms run)
//----------------------------------------------------------
// �禡��� : void pCalWaterFlow (void)
//----------------------------------------------------------
// �\��y�z:
//   �y�q�p��
// 1���� = 330��Pulse
// 10Pulse ���j�ɶ�(us) = bCapT[2-0]
// �C����Pulse�� = 60s*1000000/(CapT[2-0]/10)
// �y�q(��) = �C����Pulse�� / 330
//          = 60s*1000000*10*100/bCapT[2-0]/330	(��j100�����p���I2��)
// 			= 6000000000/bCapT[2-0]/330
//			= 181818182/bCapT[2-0]
// Range of Flow Rate : 2  �V 60 L/min. 
// min Time = 1/(60L*330/60s) = 3.030ms (10pusle = 30.30ms)
// max Time = 1/( 2L*330/60s) = 90.909ms(10pusle = 909.10ms)
// 181818182/30300  = 6000 --> �|�ˤ��J 600
// 181818182/909090 =  20 --> �|�ˤ��J 20
//----------------------------------------------------------
// �禡�ϥλ���: 
// �ǤJ�Ѽƻ���: �L
// ��X�Ѽƻ���: �L
// �䥦:
//==========================================================
void pCalWaterFlow (void)
{
	U8 i;
	U16 diff;
	U32 tmp,val;
	
	if (fCalFlow)
	{
		fCalFlow=1;
		// 10 Pulse Time
		tmp = ((U32)bCapT2<<16)+((U32)bCapT1<<8)+(U32)bCapT0-250;
		fCalFlow=0;
		
		// �̰��y�q�p���2~60����
		if (tmp < 30300)
			tmp = 30300;
		if (tmp >=909090)
			tmp = 909090;
		val = ((U32)181818182L / tmp);

		if (fFirstLoad)
		{			
			arrFlow[bFlowIdx]=val;
			if (++bFlowIdx >= 16)
				bFlowIdx=0;
		}	
		else // �������J
		{
			for (i=0;i<16;i++)
				arrFlow[i]=val;
			val = filter(arrFlow);
			wSum = val<<3;
			val = (val+5)/10;
			
			for (i=0;i<8;i++)
				arrFlow2[i]=val;
			
			bFlowIdx=0;
			bFlowIdx2=0;			
			wWFlow = val;
			bFilterCnt=10;

			fFirstLoad = 1;
		}
		
		//if (bFlowIdx==0)
		//{
			//tmp=0;
			//for (i=0;i<16;i++)
			//	tmp+=arrFlow[i];
			//	val=tmp>>4;
			val = filter(arrFlow);
			wSum = wSum - (wSum >> 3) + val;
			val = wSum >> 3;
			val = (val+5)/10;
			
			if (wWFlow >= val)			
				diff = wWFlow - val;
			else
				diff = val - wWFlow;
			
			if (diff >15)
				fFirstLoad=0;
			if (diff <= 1)
				val = wWFlow;
							
			arrFlow2[bFlowIdx2]=val;
			if (++bFlowIdx2 >= 8)
				bFlowIdx2=0;
			
			//if (bFlowIdx2 ==0)
			//{
				tmp=0;
				for (i=0;i<8;i++)
					tmp+=arrFlow2[i];
				val = (tmp>>3);	


				//if (wWFlow >= val)			
				//	diff = wWFlow - val;
				//else
				//	diff = val - wWFlow;
				
				//if (diff > 1)
				//{
				//	wWFlow = val;
				//	bFilterCnt=0;
				//}
				//else
				//{
					if (val != wWFlow)
					{
						if (++bFilterCnt >= 20)
						{
							wWFlow = val;
							bFilterCnt=10;
						}
					}
					else
					{
						if (bFilterCnt>0)
							bFilterCnt--;
					}
				//}
			//}
			
		//}
	}
	else if (bTMR1U >= 30)
		wWFlow = 0;
	
}


//==============================================
// �q���o�i
//==============================================
U16 filter(U16	*ptArr)
{
    U8 i,j;
    U16 value_buf[16];
    U32 sum,tmp;

	// �ļ�N�Ӹ��
	for (i=0;i<16;i++)
		value_buf[i]=*ptArr++;
	
	// ��N���ļ˭ȫ��p��j�ƦC
    for (i=0;i<15;i++)
    {
        for (j=(i+1);j<16;j++)
        {
            if (value_buf[i] > value_buf[j])
            {
                tmp = value_buf[i];               
                value_buf[i] = value_buf[j];
                value_buf[j] = tmp;
            }
        }
    }

	sum=0;
	for (i=4;i<=11;i++)
		sum+=value_buf[i];
	sum>>=3;

    return sum;
}

//==========================================================
// �Ƶ{���W�� : �p�ɳB�z�{�� (1s run)
//----------------------------------------------------------
// �禡��� : void pTimeProc (void)
//----------------------------------------------------------
// �\��y�z:
//   �p�ɱҰʲM�~�{��
//----------------------------------------------------------
// �禡�ϥλ���: 
// �ǤJ�Ѽƻ���: �L
// ��X�Ѽƻ���: �L
// �䥦:
//==========================================================
void pTimeProc (void)
{
	U16 tmp;
	
	if (++bSec>=60)
	{			
		bSec=0;
		tmp = (U16)bHour*60+(U16)bMin;
		tmp--;
		
		bHour = tmp/60;
		bMin = tmp%60;
			
		if ((bHour==0)&&(bMin==0))
		{
			pReLoadTime();
			pRunWashFlow();
		}
	}

/*
	if (bSec==0)
	{		
		if (bMin==0)
		{
			if (bHour==0)
			{
				pReLoadTime();
				pRunWashFlow();
			}
			else
			{
				bSec=59;
				bMin=59;
				bHour--;
			}
		}
		else
		{
			bSec=59;
			bMin--;
		}
	}
	else
		bSec--;
*/
}

//----------------------------------------------------------
void pReLoadTime (void)
{
	bHour = bSetHour;
	bMin  = bSetMin;	
	bSec  = 0;
	b1s   = 0;
}



//==========================================================
// pReadEE()					
//==========================================================
void pReadEE(void)
{	
	eecpymem(EE_DATA.arrEEData,EE_TOL_LITER,7);
	
	// EE Data Initialize
	if (bEEStat!=0xA5)
	{
		TotalLiter = 0;
		bSetHour=dDefHour;
		bSetMin=dDefMin;
		bEEStat = 0xA5;
		memcpyee(EE_TOL_LITER,EE_DATA.arrEEData,7);
	}
	
	pReLoadTime();
}

//---------------------------------------------------------
// EEDATA �p���x�s (100ms run)
void pEESaveTimeCtl (void)
{
	if (bSaveEECnt >= 50)	// 5��p�ɲM��EEDATA�x�s�X��
		fSaveEE=0;
	else
		bSaveEECnt++;	
}


//==========================================================
// Test �Ҧ�
//==========================================================
void pTestMode(void)
{
	U8 stat;
	
	// ���մ������i��EEPROM�x�s
	fSaveEE=1;
	
	while (1)
	{
		// ���ݩ�}����
		while(key_press());
		
		//----------------------------------
		// ����_�q�O��
		while(1)
		{
			if (f10ms)
				pConLiter(TotalLiter,0);

			if (!fKeyVIEW)
				break;
		}
		
		// ���ݩ�}����
		pClrDisp();
		while(key_press());
		
		//----------------------------------
		// �������
		bRunCnt=0;
		bTestCnt=0;
		bLed.byte = 0x01;
		while(1)
		{
			if (f10ms)
			{	
				f10ms = 0;
				if (bRunCnt==0)
				{
					bRunCnt=40;
					switch (bTestCnt)
					{
						case 10:
							bSeg2 = 0b01111111;		// �p���I
							bSeg1 = 0b01111111;
							bSeg0 = 0b01111111;
						break;
						
						case 11:
							bSeg2 = 0b00000000;		// 8__
							bSeg1 = 0b11111111;
							bSeg0 = 0b11111111;
						break;
						
						case 12:
							bSeg2 = 0b11111111;		// _8_
							bSeg1 = 0b00000000;
							bSeg0 = 0b11111111;
						break;
						
						case 13:
							bSeg2 = 0b11111111;		// __8
							bSeg1 = 0b11111111;
							bSeg0 = 0b00000000;
						break;
						
						default:
							bSeg2 = ~tabSeg[bTestCnt];
							bSeg1 = ~tabSeg[bTestCnt];
							bSeg0 = ~tabSeg[bTestCnt];
						break;
					}	
				
					if (++bTestCnt > 13)
						bTestCnt=0;
						
					// LED ����{�{	
					bLed.byte ^= 0x03;
				}
				else
					bRunCnt--;
				
				if (!fKeyVIEW)
					break;
			} // end if (f10ms)
		}
		
		pClrDisp();
		while(key_press());
		//----------------------------------
		// �������
		stat=0;
		bRunCnt=0;
		bTestCnt=0;
		
		while(1)
		{
			if (f10ms)
			{
				f10ms=0;
				
				if (!fKeySET)
				{
					if (bRunCnt >= 10)// �H������0.1��~�P�w
						bTestCnt=1;
					else
						bRunCnt++;
				}
				else if (!fKeyWASH)
				{
					if (bRunCnt >= 10)
						bTestCnt=2;
					else
						bRunCnt++;
				}
				else if (!fKeyVIEW)
				{
					if (bRunCnt >= 10)
						bTestCnt=3;
					else
						bRunCnt++;
				}
				//else if (!iPDn)		// �_�q��J����
				//{
				//	if (bRunCnt >= 10)
				//		bTestCnt=4;
				//	else
				//		bRunCnt++;
				//}
				else	// ��}
				{
					if (bRunCnt==0)
					{
						if (bTestCnt==1)
							stat|=1;
						else if (bTestCnt==2)
							stat|=2;
						else if (bTestCnt==3)
							stat|=4;	
						//else if (bTestCnt==4)
						//	stat|=8;								
						bTestCnt=0;
					}
					else
						bRunCnt--;
				}
				
				pConDisp(bTestCnt,0);
				
				if (!fKeyVIEW && (stat==0x07))
					break;
			}
		}
		
		pClrDisp();
		while(key_press());
		//----------------------------------
		// Clock �ƴ���
		wTestPulseCnt=0;
		bTestCnt=0;
		TotalLiter=0;
		foLED_GW=0;
		while (1)
		{
			if (f10ms)
			{
				f10ms=0;
			
				if (fKeyPress)
				{
					if (fKeySET && fKeyWASH)
						fKeyPress=0;
				}
				else if (!fKeyWASH)
				{
					if (++bTestCnt >= 3)
						bTestCnt=0;	
					fKeyPress=1;
				}
				else if (!fKeySET)
				{
					wTestPulseCnt=0;
					bTestCnt=0;
					TotalLiter=0;
					fKeyPress=1;
				}
				
				
				if (bTestCnt==0)
					pConDisp(wWFlow,1);
				else if (bTestCnt==1)
					pConDisp(wTestPulseCnt,0);
				else
					pConLiter(TotalLiter,0);
	
				// 50ms run	
				if (++b50ms >= 2)
				{
					b50ms=0;
					pCalWaterFlow();	// Calculature Water Flow
				}
				
				if (!fKeyVIEW)
					break;
			} // end f10ms
		} // end while
		
		pClrDisp();
		while(key_press());
		
		//----------------------------------
		// OUTPUT ����
		bSeg2 = ~0x3F;	// O
		bSeg1 = ~0x2F;	// U
		bSeg0 = ~0x66;	// t
	
		oRelayWash=0;
		oRelayWaIn=1;
	
		while(1)
		{
			if (f10ms)
			{
				f10ms=0;
				
				// 200ms run	
				if (++bRunWashT >= 40)
				{
					bRunWashT=0;
					PORTA ^= 0b00000110;
				}
			}
			
			if (!fKeyVIEW)
				break;
		}
		
		pClrDisp();
		oRelayWash=0;
		oRelayWaIn=0;
		while(key_press());
		//----------------------------------
		// EEPROM Ū�g����
		//bSeg2 = ~0x76;	// E
		//bSeg1 = ~0x76;	// E
		//bSeg0 = ~0x7A;	// P
		
		stat=0;
		bTestCnt=0x55;
		while (1)
		{
			// write data
			for (bRunCnt=0;bRunCnt<8;bRunCnt++)
				eeprom_write(EE_TOL_LITER+bRunCnt,bTestCnt);
				
			// read  data
			for (bRunCnt=0;bRunCnt<8;bRunCnt++)
			{
				if (eeprom_read(EE_TOL_LITER+bRunCnt) != bTestCnt)
					stat=1;
			}
			
			if ((stat==1)||(bTestCnt==0x00))
				break;
			else if (bTestCnt==0x55)
				bTestCnt=0xAA;
			else
				bTestCnt=0;		// �M�����
		}
		
		eecpymem(EE_DATA.arrEEData,EE_TOL_LITER,7);
		
		if (stat==0)
		{
			bSeg2 = ~0x7A;	// P		
			bSeg1 = ~0x75;	// S
			bSeg0 = ~0x00;	// 
		}
		else
		{	
			bSeg2 = ~0x76;	// E
			bSeg1 = ~0x42;	// r
			bSeg0 = ~0x42;	// r
		}

		while (fKeyVIEW);
		
	}// end while(1)	
}

//==========================================================
// Test Display (10ms run)
//==========================================================
U8 key_press (void)
{
	if (bKeyData.byte == dKeyInit)	// release..
		return 0;
	else
	{
		bSeg2 = 0b10111111;		// ---
		bSeg1 = 0b10111111;
		bSeg0 = 0b10111111;
		return 1;
	}
}




/*
//==========================================================
// TestKey					
//==========================================================
void pFunTestKey (void)
{
	if (!fKeyVIEW)
		bKeyNum=1;
	else if (!fKeyWASH)
		bKeyNum=2;
	else if (!fKeySET)
		bKeyNum=3;
	else
		bKeyNum=0;
}
*/





