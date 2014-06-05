#ifndef	__SYSTEM_H					// 避免重覆定義
#define	__STSTEM_H


#define	DEBUG_MODE	0
//==========================================================
// 功能描述: 資料定義
// 引入所有 header 檔
//==========================================================
#include <pic.h>
#include <stdio.h>
#include "typedefs.h"
#include "InitMcu.h"
#include "drv_key.h"
#include "drv_disp.h"
#include "drv_uart_debug.h"


//==========================================================
// I/O DEFINE
// 命令規則:
// Input  : iPinName
// Output : oPinName
// I/O    : ioPinName
//==========================================================
#define	oS0		RB0
#define	oS1		RB1
#define oS2		RB2
#define	oS3		RA0

#define	oD0		RC0
#define	oD1		RC1
#define	oD2		RC2
#define	oD3		RC3
#define	oD4		RC4
#define	oD5		RC5
#define	oD6		RC6
#define	oD7		RC7


#define	oKey	RB5
#define	iKey	RB5
#define	dirKey	TRISB5

#define	iPDn	RB4

#define	oTest1	RB7
#define	oTest2	RB6


#define	oRelayWash		RA2
#define	oRelayWaIn		RA1
//==========================================================
// 參數定義&暫存器定義 (主程式提供給其它檔案使用)								
//==========================================================
#define		dPulseL		(330/10)	// 每公升330個pulse

extern bit fPowerOn;

extern U8 bKeyNum;


//==========================================================
//				函式原型宣告								
//==========================================================





#endif

