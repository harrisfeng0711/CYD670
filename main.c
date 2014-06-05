//==========================================================
// 程式編號: CYD670
// 程式名稱: 
// 程式撰寫: Hj
// IDE 版本: MPLAB 8.93
// 組譯工具: Hi-Tech PICC V9.83 PRO
// 晶片型號: PIC16F883							
// 開始時間: 2014/05/09						
// 完成時間: ?							
// 程式版本: V1.0
//----------------------------------------------------------
// 版本編號 : V1.0
// 發行日期 : 
// 摘要記事 : 
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
// 參數定義&暫存器定義	
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

#define		dRunMinT	50	// 異常後預設時間
#define		dDefHour	1	// 出廠預設計時時間
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
// 函式原型宣告					
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
// 中斷副程式 
// static void interrupt isr (void) 為 Hi-Tech C 中斷副程式
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
		
		// 累加公升數
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
		
		// 每分鐘流量1公升Pluse最大時間為
		// 1/(330/60)= 0.182s
		// 10個Pulse時間為1.82s
		// 1.82*1000000/65536 = 27.74
		// 選擇當時間計時 > 30*65536時，代表無流動
		
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
		//	MOVLW	0x18;						// 內含組合語言,變數需加 "_"
		//	ADDWF	_TMR1L,F					// "_變數名稱"
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
				//memcpyee(EE_TOL_LITER,EE_DATA.arrEEData,4);	// compiler 限制...
				eeprom_write(EE_TOL_LITER+0,EE_DATA.arrEEData[0]);
				eeprom_write(EE_TOL_LITER+1,EE_DATA.arrEEData[1]);
				eeprom_write(EE_TOL_LITER+2,EE_DATA.arrEEData[2]);
				eeprom_write(EE_TOL_LITER+3,EE_DATA.arrEEData[3]);
				bSaveEECnt=0;
				fSaveEE=1;		// 5秒內不進行儲存
				//oTest1=1;
			}
		}
		
		pScanKey();		// 按鍵掃瞄
		pScanDisp();	// 顯示掃瞄
		
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
	pInitMCU();				// MCU 初始化
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
	
	// 開機同時按住設定與檢視鍵,進入自測模式
	if (!fKeySET && !fKeyVIEW)
		pTestMode();


//-------------------
// 啟動顯示000-111-222-....999		
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
//---- main loop ----		// 主程式迴圈
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
					pFlashTimeCtl();	// 閃爍控制	
					pEESaveTimeCtl();	// EEData儲存計時
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
				pTimeProc();		// 計時控制
			}
			
			
		} // end if (10ms)
	} // end while(1)
} // end main

//---------------------------------------------------------
// 閃爍控制
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
// 副程式名稱 : 按鍵處理程式 (10ms run)
//----------------------------------------------------------
// 函式原形 : void pKeyProc (void)
//----------------------------------------------------------
// 功能描述:
//   按鍵時即動作，且有Hold按鍵及連續鍵功能
//----------------------------------------------------------
// 函式使用說明: 
// 傳入參數說明: 無
// 輸出參數說明: 無
// 其它:
//==========================================================
void pKeyProc (void)
{
	if (fKeyPress)
	{
		// 放開按鍵
		if (bKeyData.byte == dKeyInit)			
		{
			fKeyPress = 0;
		}
//----------------------------------------------// Hold Key Process...
		// Hold按鍵計時
		if (bKeyHTCnt == 0)	
		{
			if (!fKeySET)
			{
				if (bRunMode == 0)
				{
					bSetTmp=bSetHour;		// 載入時設定
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
				bKeyHTCnt = dReptT; 	// 連續鍵執行時間 0.3s
				goto	_WASH_KEY;
			}
		}
		else if (bKeyHTCnt != dRun1T)
			bKeyHTCnt--;
	}
//----------------------------------------------// Key Down Process...
	else 										
	{
		// 設定鍵
		if (!fKeySET)
		{
			// Key Press...
			switch (bRunMode)
			{
				// 正常模式下,按2秒進入設定模式
				case 0:
					bKeyHTCnt = dKeyHT2s;		// 2s
				break;

				// 設定P1模式(時間設定)下,為設定完成鍵
				case 1:
					if (bRunStep==1)
					{
						if (bSetHour!=bSetTmp)
						{
							bSetHour = bSetTmp;		// 儲存時設定
							eeprom_write(EE_SET_HOUR,bSetHour);
						}

						pRunStep(2);			// 顯示小時設定2秒
					}
					// 分設定完成
					else if (bRunStep==3)
					{
						if (bSetMin!=bSetTmp)
						{
							bSetMin = bSetTmp;		// 儲存分設定
							eeprom_write(EE_SET_MIN,bSetMin);
						}

						pReLoadTime();			// 重載設定時間
						pRunStep(6);				// 顯示分設定2秒
					}
				break;
				
				// 設定P2模式下(清除公升數),為設定完成鍵
				case 2:
					if (bSetTmp==0)
						TotalLiter = 0;		// 儲存更改數值
					pSwitchMode(0);			// 跳回正常模式
				break;
			}
			
			goto	_KPRESS2;
		}
		//--------------------------------------
		// 沖洗鍵
		else if (!fKeyWASH)
		{
_WASH_KEY:
			// Key Press...
			switch (bRunMode)
			{
				// 正常模式下,執行沖洗
				//case 0:
				//	pRunWashFlow();
				//break;
				
				// 設定P1模式(時間設定)，為時間調整鍵
				case 1:
					if (bRunStep==1)
						pTuneHour();	// set hour
					if (bRunStep==3)
						pTuneMin();		// set min
				break;
				
				// 設定P2模式(清除公升數)，為清除公升計數值鍵
				case 2:
					if (bRunStep>0)
						bSetTmp=0;		// 清除公升計數值
				break;
				
				// 正常模式下,執行沖洗
				default:
					pRunWashFlow();
				break;
			}
			goto	_KPRESS;
		}
		//--------------------------------------
		// 檢視鍵
		else if (!fKeyVIEW)
		{
			// Key Press...
			switch (bRunMode)
			{
				// 正常模式下,顯示距離時間
				case 0:	
					pSwitchMode(3);			// 顯示距離時間模式
				break;
				
				// 設定模式P1,無操作
				case 1:

				break;
				
				// 設定模式P2,無操作
				case 2:
				
				break;
				
				// 顯示距離時間
				case 3:
					if (bRunStep<2)			// 切換顯示公升數
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
// 模式切換
void pSwitchMode (U8 mod)
{
	bRunMode=mod;
	bRunStep=0;
	bRunCnt=0;
	mResetFlash(3);
}				
//----------------------------------------------------------
// 調整時設定值
void pTuneHour (void)
{
	bSetTmp++;
	if (bSetTmp > 24)
		bSetTmp=0;
		
	mResetFlash(7);		// 調整時不閃爍
	bRunCnt=0;			// 未操作計時重置
}
//----------------------------------------------------------
// 調整分設定值
// 若時設置為00,則分調整10,20..50,若時設置為24,則分為00
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
	mResetFlash(7);		// 調整時不閃爍
	bRunCnt=0;			// 未操作計時重置
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
	
	// 調整時不閃爍
	mResetFlash(7);
	
	// 未操作計時重置
	bRunCnt=0;
}
*/

//----------------------------------------------------------
// 重置閃爍
//void _reset_flash (U8 ft)
//{
//	bFlashCnt = ft;
//	fFlash=1;
//}

//==========================================================
// 副程式名稱 : 顯示處理程式 (100ms run)
//----------------------------------------------------------
// 函式原形 : void pDispProc (void)
//----------------------------------------------------------
// 功能描述:
//   不同模式下顯示操作資訊
//----------------------------------------------------------
// 函式使用說明: 
// 傳入參數說明: 無
// 輸出參數說明: 無
// 其它:
//==========================================================
void pDispProc (void)
{
	U8 s0,s1,s2;
	
	switch (bRunMode)
	{
		
		//--------------------------
		// 正常模式顯示流量
		case 0:	
			pConDisp(wWFlow,1);
		break;

		//--------------------------
		// P1 設定沖洗時間
		case 1:	
			switch (bRunStep)
			{
				// 顯示P1字串
				case 0:	
					s2=dP;
					s1=1;
					s0=dNull;
					
					if (++bRunCnt >= 20)	// 顯示P1 2秒
						pRunStep(1);
				break;
				
				// 顯示hour
				case 1:	
					s2=dH;
					s1=dNull;
					s0=dNull;
					
					if (fFlash)				// 閃爍顯示控制
					{
						s1=bSetTmp/10;
						s0=bSetTmp%10;
					}
					
					if (++bRunCnt >= 100)	// 10秒未操作則跳回
						pSwitchMode(0);
				break;
				
				// 顯示小時設定2秒
				case 2:
					s2=dH;
					s1=bSetHour/10;
					s0=bSetHour%10;

					if (++bRunCnt >= 20)	// 2秒顯示設定值
					{
						if ((bSetHour==0)&&(bSetMin==0))	// 檢查&載入分設定	
							bSetTmp=10;
						else if (bSetHour==24)
							bSetTmp=0;
						else
							bSetTmp=bSetMin;
						pRunStep(3);		// 進入分設定
					}
				break;
				
				// 顯示minute
				case 3: 
					s2=dn;
					s1=dNull;
					s0=dNull;	
					
					if (fFlash)				// 閃爍顯示控制
					{
						s1=bSetTmp/10;
						s0=bSetTmp%10;
					}
					
					if (++bRunCnt >= 100)	// 10秒未操作則進行設定檢查
						pRunStep(4);
				break;
				
				// 未操作跳回,檢查設定值,設定錯誤載入預設值
				case 4:						
					if ((bSetHour==0)&&(bSetMin==0))
						bSetMin = dRunMinT;
					else if ((bSetHour==24)&&(bSetMin!=0))
						bSetMin = 0;
					else
						pSwitchMode(0);

					pRunStep(5);
				break;

				// 設定錯誤，顯示EEE字串
				case 5:	
					s2=dE;
					s1=dE;
					s0=dE;
					
					fErr=1;
					
					if (++bRunCnt >= 20)	// 顯示EEE 2秒
						pRunStep(6);		//
				break;
				
				// 顯示設定分2秒
				case 6:
					s2=dn;
					s1=bSetMin/10;
					s0=bSetMin%10;
		
					if (++bRunCnt >= 20)	// 2秒顯示設定值
					{
						if (fErr)
						{
							fErr=0;
							pSwitchMode(0);		// 跳回顯示流量
						}
						else
						{
							bSetTmp = TotalLiter;	// 載入P2公升數
							pSwitchMode(2);			// 進入P2公升數清除
						}
					}
				break;
			}

			bSeg2 = ~tabSeg[s2];
			bSeg1 = ~tabSeg[s1];
			bSeg0 = ~tabSeg[s0];	
				
		break;
		
		//--------------------------
		// P2 設定，公升數清除
		case 2:	
			switch (bRunStep)
			{
				// 顯示P2字串
				case 0:	
					bSeg2 = ~tabSeg[dP];
					bSeg1 = ~tabSeg[2];
					bSeg0 = ~tabSeg[dNull];	
					
					if (++bRunCnt >= 20)	// 顯示P1 2秒
						pRunStep(1);
				break;
				
				// 顯示公升數前3位,ex.123
				case 1:
					pConLiter(bSetTmp,1);
					
					if (++bRunCnt >= 40)	// 顯示4秒
						pRunStep(2);
				break;
					
				// 顯示公升數後3位,ex.456
				case 2:
					pConLiter(bSetTmp,0);
					
					if (++bRunCnt >= 100)	// 顯示10秒
						pSwitchMode(0);	
				break;
			}

		break;	

		//--------------------------
		// 顯示沖洗距離時間，公升數
		case 3:	
			switch (bRunStep)
			{
				// 顯示hour
				case 0:	
					s1=bHour/10;
					s0=bHour%10;
					
					bSeg2 = ~tabSeg[dH];
					bSeg1 = ~tabSeg[s1];
					bSeg0 = ~tabSeg[s0]&0x7F; // 小數點
					
					if (++bRunCnt >= 40)	// 顯示4秒
						pRunStep(1);
				break;

				// 顯示分
				case 1:
					s1=bMin/10;
					s0=bMin%10;
					
					bSeg2 = ~tabSeg[dn];
					bSeg1 = ~tabSeg[s1];
					bSeg0 = ~tabSeg[s0];
					
					if (++bRunCnt >= 100)	// 10秒未操作則跳回流量顯示
						pSwitchMode(0);	
				break;
				
				// 顯示公升數前3位,ex.123
				case 2:
					pConLiter(TotalLiter,1);
					
					if (++bRunCnt >= 40)	// 顯示4秒
						pRunStep(3);
				break;
					
				// 顯示公升數後3位,ex.456
				case 3:
					pConLiter(TotalLiter,0);
					
					if (++bRunCnt >= 100)	// 10秒未操作則跳回流量顯示
						pSwitchMode(0);	
				break;
					
			}

		break;
	}
	
	
	// LED 顯示控制
	if (fRunWash)
	{
		foLED_WH = 0;	// 沖洗燈亮
		foLED_GW = 1;	// 製水燈滅
	}
	else
	{
		foLED_WH = 1;	// 沖洗燈滅
		foLED_GW = 0;	// 製水燈亮
	}
}
//----------------------------------------------------------
// 跳至下一步
void pRunStep (U8 step)
{
	bRunCnt=0;
	bRunStep=step;
	mResetFlash(3);
}

//----------------------------------------------------------
// 顯示公升數
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

	
	// 小數點閃爍計時控制
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
// 副程式名稱 : 沖洗程序 (10ms run)
//----------------------------------------------------------
// 函式原形 : void pWashFlow (void)
//----------------------------------------------------------
// 功能描述:
//   清洗流程控制
//----------------------------------------------------------
// 函式使用說明: 
// 傳入參數說明: 無
// 輸出參數說明: 無
// 其它:
//==========================================================
void pWashFlow (void)
{
	if (fRunWash)
	{
		// 重置計時時間
		pReLoadTime();
		switch (bRunWashStep)
		{
			// 沖洗電磁閥打開，入水電磁閥關閉，維持10秒
			case 0:
				oRelayWash=1;
				oRelayWaIn=0;
				
				if (++bRunWashT >= 100)
				{
					bRunWashT=0;
					bRunWashStep++;
				}
			break;
			
			// 沖洗電磁閥打開，入水電磁閥打開，維持10秒
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
// 副程式名稱 : 流量計算 (50ms run)
//----------------------------------------------------------
// 函式原形 : void pCalWaterFlow (void)
//----------------------------------------------------------
// 功能描述:
//   流量計算
// 1公升 = 330個Pulse
// 10Pulse 間隔時間(us) = bCapT[2-0]
// 每分鐘Pulse數 = 60s*1000000/(CapT[2-0]/10)
// 流量(分) = 每分鐘Pulse數 / 330
//          = 60s*1000000*10*100/bCapT[2-0]/330	(放大100倍取小數點2位)
// 			= 6000000000/bCapT[2-0]/330
//			= 181818182/bCapT[2-0]
// Range of Flow Rate : 2  – 60 L/min. 
// min Time = 1/(60L*330/60s) = 3.030ms (10pusle = 30.30ms)
// max Time = 1/( 2L*330/60s) = 90.909ms(10pusle = 909.10ms)
// 181818182/30300  = 6000 --> 四捨五入 600
// 181818182/909090 =  20 --> 四捨五入 20
//----------------------------------------------------------
// 函式使用說明: 
// 傳入參數說明: 無
// 輸出參數說明: 無
// 其它:
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
		
		// 最高流量計算到2~60公升
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
		else // 首次載入
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
// 電壓濾波
//==============================================
U16 filter(U16	*ptArr)
{
    U8 i,j;
    U16 value_buf[16];
    U32 sum,tmp;

	// 採樣N個資料
	for (i=0;i<16;i++)
		value_buf[i]=*ptArr++;
	
	// 把N次採樣值按小到大排列
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
// 副程式名稱 : 計時處理程式 (1s run)
//----------------------------------------------------------
// 函式原形 : void pTimeProc (void)
//----------------------------------------------------------
// 功能描述:
//   計時啟動清洗程序
//----------------------------------------------------------
// 函式使用說明: 
// 傳入參數說明: 無
// 輸出參數說明: 無
// 其它:
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
// EEDATA 計時儲存 (100ms run)
void pEESaveTimeCtl (void)
{
	if (bSaveEECnt >= 50)	// 5秒計時清除EEDATA儲存旗標
		fSaveEE=0;
	else
		bSaveEECnt++;	
}


//==========================================================
// Test 模式
//==========================================================
void pTestMode(void)
{
	U8 stat;
	
	// 測試期間不進行EEPROM儲存
	fSaveEE=1;
	
	while (1)
	{
		// 等待放開按鍵
		while(key_press());
		
		//----------------------------------
		// 顯示斷電記憶
		while(1)
		{
			if (f10ms)
				pConLiter(TotalLiter,0);

			if (!fKeyVIEW)
				break;
		}
		
		// 等待放開按鍵
		pClrDisp();
		while(key_press());
		
		//----------------------------------
		// 測試顯示
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
							bSeg2 = 0b01111111;		// 小數點
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
						
					// LED 交替閃爍	
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
		// 按鍵測試
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
					if (bRunCnt >= 10)// 信號持續0.1秒才判定
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
				//else if (!iPDn)		// 斷電輸入測試
				//{
				//	if (bRunCnt >= 10)
				//		bTestCnt=4;
				//	else
				//		bRunCnt++;
				//}
				else	// 放開
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
		// Clock 數測試
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
		// OUTPUT 測試
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
		// EEPROM 讀寫測試
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
				bTestCnt=0;		// 清除資料
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





