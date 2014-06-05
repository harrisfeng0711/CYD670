//==========================================================
//檔案名稱: InitMcu.c
//功能描述: 晶片功能初始化
//==========================================================
#include "system.h"


//==========================================================
//                  PORTOTYPE DECLARE                       
//==========================================================
void pInitMCU(void);			// MCU 初始化

void pInitPORT(void);
void pInitT0(void);
void pInitT1(void);
void pInitT2(void);
void pInitAD(void);
//void pInitCCP1(void);

//==========================================================
// Function: MCU Initial                                    
//==========================================================
void pInitMCU(void)
{
	INTCON=0;						// Disable All Interrupt
	PIE1=0;
	
	OPTION_REG 	= 0b00111111;		//
	OSCCON 		= 0b01100001;		// Internal Clock 4MHz
	while(!HTS);					// Wait Frequency Stable
	
	pInitAD();
	pInitPORT();
	pInitT0();	
	pInitT1();
	pInitT2();
	//InitCCP1();
	
#if DEBUG_MODE == 1
	pInitUART();
#endif
	
	PEIE = 1;						
}


//==============================================
// Function: Initial AD
//==============================================
void pInitAD (void)
{
	// analog pin select
	ANSEL 	= 0b00000000;			// RC0,1,2 --> AN4,5,6 
	ANSELH	= 0b00000000;		
	
	ADCON1 = 0b00000000; 			// Fosc/8
	ADCON0 = 0b00000000;			// Right justified,AN4,GO,ADON
}

//==========================================================
//	Function: Initial PORT                                
//==========================================================
void pInitPORT(void)
{
	// port a init
	PORTA	= 0b00010001;
	TRISA	= 0b00010000;
	
	// port b Init
	IOCB	= 0b00000000;
	PORTB	= 0b11010111;			
	WPUB 	= 0b11101111;	
	TRISB	= 0b00010000;
				
	// port c Init
	PORTC	= 0b11111111;
	TRISC	= 0b00000000;			
}



//==================================================================
// Function: Initial Timer0
//==================================================================
void pInitT0 (void)
{
	//T0CS = 0;						// internal clock
	//PSA = 0; 						// Prescaler is assigned to the Timer0 module
	
	TMR0 = 246;						// 246
	T0IE = 0;						// interrupt on
	T0IF = 0;
}


//==================================================================
// Function: Initial Timer1
//==================================================================
void pInitT1 (void)
{
	T1CON = 0b00000000;				
	//TMR1L = 0x18;					// 2ms 中斷
	//TMR1H = 0xFC;
	//TMR1IE = 1;						// Timer1 Interrupt Enable
}

//==================================================================
// Function: Initial Timer2
//==================================================================
void pInitT2 (void)
{
	PR2 = 126;						// 250 * 16us = 2ms
	T2CON = 0b00000011;				// 
	TMR2IE = 1;						// Timer2 Interrupt Enable
}

//==================================================================
// Function : Initial PWM
// PWM Period = [PR2+1]*4*Tosc*(TMR2 prescale value)
// PR2 = PWM Period / (4*(1/Tosc))*(TMR2 Prescale value)
// PR2 = (1/250Hz) / (4*(1/1MHz)) * 4 = 249
//==================================================================
//void pInitCCP1(void)
//{
//	CCP1CON = 0b00001100;			// CCP1 (PWM OUT)
//	PR2 = 249;						// PWM Period
//	T2CON = 0b00000001;				// TMR2 Prescale 1:4
//	CCPR1L = 0;
//}
	


