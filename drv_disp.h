#ifndef	__DRV_DISP_h					// 避免重覆定義
#define	__DRV_DISP_h



//==============================================//
//				參數定義						//
//==============================================//
#define	dNull	10
#define	dDash	11

#define	dE		14
#define	dP		16
#define	dH		17
#define	dn		18



//==============================================//
//				暫存器定義						//
//==============================================//
extern const U8 tabSeg [];
extern U8 bSeg0;
extern U8 bSeg1;
extern U8 bSeg2;
extern ubyte bLed;
#define	foLED_GW		bLed.bits.b1
#define	foLED_WH		bLed.bits.b0


//==============================================//
//				函式原型宣告					//
//==============================================//
extern void pConDisp (U16 dat,U8 dot);
extern void pScanDisp (void);
extern void pClrDisp (void);


#endif