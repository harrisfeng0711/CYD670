#ifndef	__DRV_KEY_h					// �קK���Щw�q
#define	__DRV_KEY_h



//==============================================//
//				�ѼƩw�q						//
//==============================================//
#define dDebKT		15			// 2ms * 15 = 30ms Key Debounce Time

//==============================================//
//				�Ȧs���w�q						//
//==============================================//
extern unsigned char bKeyOld;
extern unsigned char bKeyCnt;

//----------------------------------------------//
extern ubyte bKeyData;						
#define fKeyVIEW	bKeyData.bits.b0
#define fKeyWASH	bKeyData.bits.b1
#define fKeySET		bKeyData.bits.b2


//==============================================//
//				�禡�쫬�ŧi					//
//==============================================//
extern U8 pReadKey (void);
extern void pScanKey (void);

#endif
