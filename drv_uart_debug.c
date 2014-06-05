//==============================================
// �ɮצW��: drv_uart_debug.c
// �\��y�z: rs232 ��ƶǰe
//==============================================
#include "system.h"




//==============================================
// �ѼƩw�q&�Ȧs���w�q							
//==============================================


//==============================================
// �禡�쫬�ŧi                       
//==============================================
void pInitUART (void);
void putch(unsigned char byte);
unsigned char getch(void);
unsigned char getche(void);

//==============================================
// Serial initialization						
//==============================================
void pInitUART (void)
{
	RX_PIN = 1;
	TX_PIN = 1;
	SPBRG = DIVIDER;
	RCSTA = (NINE_BITS|0x80);
	TXSTA = (SPEED|NINE_BITS|0x20);
}

//----------------------------------------------
void putch(unsigned char byte) 
{
	/* output one byte */
	while(!TXIF)	/* set when register is empty */
		continue;
	TXREG = byte;
}
//----------------------------------------------
unsigned char getch() 
{
	/* retrieve one byte */
	while(!RCIF)	/* set when register is not empty */
		continue;
	return RCREG;	
}
//----------------------------------------------
unsigned char getche(void)
{
	unsigned char c;
	putch(c = getch());
	return c;
}

