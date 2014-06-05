//==============================================//
//			INCLUDE HEAER FILE					//
//==============================================//
#include "system.h"


//==============================================//
//				暫存器定義						//
//==============================================//
unsigned char bKeyOld = 0;
unsigned char bKeyCnt = 0;
//unsigned char bKeyBuf = 0;
//unsigned char bKeyScanCnt=0;
//----------------------------------------------//
ubyte bKeyData = {0xFF};

//==============================================//
//				函式原型宣告					//
//==============================================//
U8 pReadKey (void);
void pScanKey (void);


//==============================================//
//				READ KEY (2ms)					//
// 程式說明:									//
//   讀取按鍵值，dKeyTime時間Debounce後，		//
//   將按鍵狀態存入bKeyData						//
//==============================================//
void pScanKey (void)
{
	U8 bKeyBuf;

	bKeyBuf = pReadKey();

	if (bKeyOld != bKeyBuf)
	{
		bKeyOld = bKeyBuf;
		bKeyCnt = 0;
	}
	else
	{
		if (bKeyCnt == dDebKT)
		{
			bKeyCnt = 0;
			bKeyData.byte = bKeyOld;
		}
		else
			bKeyCnt++;
	}
}

//==============================================
// Get Key Data				
//==============================================
U8 pReadKey (void)
{
	U8 i,tmp,buf;
	// 關閉LED電源	

	oD0=1;		
	oD1=1;
	oD2=1;	
	
	oKey=1;	
	dirKey=1;	// 設為輸入
	
	// delay
	tmp=1;
	while(tmp--);
					
	buf = 0xFF;
	for (i=0;i<=2;i++)
	{
		switch(i)
		{
			case 0:
				oD0=1;						
				oD1=1;			
				oD2=0;
			break;
			
			case 1:
				oD2=1;
				oD1=0;
				oD0=1;
			break;
				
			case 2:
				oD1=1;
				oD0=0;
				oD2=1;
			break;						
		
		} // end swtich
		
		// delay
		tmp=1;
		while(tmp--);
		
		buf<<=1;
		
		if (iKey)
			buf |= 0x01;
		else
			buf &= 0xFE;
	}
	
	oKey=0;		
	dirKey=0;	// 設為輸出

	return buf;
}


