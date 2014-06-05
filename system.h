#ifndef	__SYSTEM_H					// �קK���Щw�q
#define	__STSTEM_H


#define	DEBUG_MODE	0
//==========================================================
// �\��y�z: ��Ʃw�q
// �ޤJ�Ҧ� header ��
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
// �R�O�W�h:
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
// �ѼƩw�q&�Ȧs���w�q (�D�{�����ѵ��䥦�ɮרϥ�)								
//==========================================================
#define		dPulseL		(330/10)	// �C����330��pulse

extern bit fPowerOn;

extern U8 bKeyNum;


//==========================================================
//				�禡�쫬�ŧi								
//==========================================================





#endif

