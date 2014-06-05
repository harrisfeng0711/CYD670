#ifndef _SERIAL_H_
#define _SERIAL_H_

//==============================================
// 參數定義&暫存器定義					
//==============================================

#define BAUD 19200      
#define FOSC 8000000L
#define NINE 0     /* Use 9bit communication? FALSE=8bit */

#define DIVIDER ((int)(FOSC/(16UL * BAUD) -1))
#define HIGH_SPEED 1

#if NINE == 1
#define NINE_BITS 0x40
#else
#define NINE_BITS 0
#endif

#if HIGH_SPEED == 1
#define SPEED 0x4
#else
#define SPEED 0
#endif

#define RX_PIN TRISB5
#define TX_PIN TRISB7

//==============================================
// 函式原型宣告                       
//==============================================
extern void pInitUART (void);
extern void putch(unsigned char);
extern unsigned char getch(void);
extern unsigned char getche(void);

#endif
