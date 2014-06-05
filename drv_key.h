#ifndef	__DRV_KEY_h					// 避免重覆定義
#define	__DRV_KEY_h



//==============================================//
//				參數定義						//
//==============================================//
#define dDebKT		15			// 2ms * 15 = 30ms Key Debounce Time

//==============================================//
//				暫存器定義						//
//==============================================//
extern unsigned char bKeyOld;
extern unsigned char bKeyCnt;

//----------------------------------------------//
extern ubyte bKeyData;						
#define fKeyVIEW	bKeyData.bits.b0
#define fKeyWASH	bKeyData.bits.b1
#define fKeySET		bKeyData.bits.b2


//==============================================//
//				函式原型宣告					//
//==============================================//
extern U8 pReadKey (void);
extern void pScanKey (void);

#endif
