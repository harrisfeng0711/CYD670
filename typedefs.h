#ifndef __TYPEDEF_H                                
#define __TYPEDEF_H

//==========================================================
// logic define
//==========================================================
//#define on      1
//#define off     0

//#define true    1
//#define false   0

//==========================================================
// typedef
//==========================================================
typedef   signed          char S8;
typedef   signed short     int S16;
//typedef   signed           int S32;
//typedef   signed       __int64 S64;

typedef unsigned          char U8;
typedef unsigned short    int U16;
typedef unsigned		  long U32;
//typedef unsigned       __int64 U64;

/* exact-width signed integer types */
//typedef   signed          char int8_t;
//typedef   signed short     int int16_t;
//typedef   signed           int int32_t;
//typedef   signed       __int64 int64_t;

 /* exact-width unsigned integer types */
//typedef unsigned          char uint8_t;
//typedef unsigned short     int uint16_t;
//typedef unsigned           int uint32_t;
//typedef unsigned       __int64 uint64_t;

//==========================================================
// 結構資料定義
// 使用範例:
// uword wCnt; -->宣告wCnt為uword結構資料
// wCnt.word = 0xffff; --> word 設定
// wCnt.byte[0] = 0xff; --> byte 設定
// wCnt.bits.b0 = 1; --> bit 設定
//==========================================================
typedef union {
        U8 byte;
        struct{
                unsigned b0 :1;
                unsigned b1 :1;
                unsigned b2 :1;
                unsigned b3 :1;
                unsigned b4 :1;
                unsigned b5 :1;
                unsigned b6 :1;
                unsigned b7 :1;
        }bits;
}ubyte;

typedef union {
        U16 word;
        U8 byte[2];
        struct{
                unsigned b0 :1;
                unsigned b1 :1;
                unsigned b2 :1;
                unsigned b3 :1;
                unsigned b4 :1;
                unsigned b5 :1;
                unsigned b6 :1;
                unsigned b7 :1;
                unsigned b8 :1;
                unsigned b9 :1;
                unsigned b10:1;
                unsigned b11:1;
                unsigned b12:1;
                unsigned b13:1;
                unsigned b14:1;
                unsigned b15:1;
        }bits;
}uword;
/*
typedef union {
        U32 lword;
        U16 word[2];
        U8  byte[4];
        struct{
                unsigned b0 :1;
                unsigned b1 :1;
                unsigned b2 :1;
                unsigned b3 :1;
                unsigned b4 :1;
                unsigned b5 :1;
                unsigned b6 :1;
                unsigned b7 :1;
                unsigned b8 :1;
                unsigned b9 :1;
                unsigned b10:1;
                unsigned b11:1;
                unsigned b12:1;
                unsigned b13:1;
                unsigned b14:1;
                unsigned b15:1;
                unsigned b16:1;
                unsigned b17:1;
                unsigned b18:1;
                unsigned b19:1;
                unsigned b20:1;
                unsigned b21:1;
                unsigned b22:1;
                unsigned b23:1;
                unsigned b24:1;
                unsigned b25:1;
                unsigned b26:1;
                unsigned b27:1;
                unsigned b28:1;
                unsigned b29:1;
                unsigned b30:1;
                unsigned b31:1;
        }bits;
}ulword;
*/
//------------------------------------------
typedef union {
	U8	EEBuf[8];
    struct
    {
    	U8  bR1;
       	U8 	bMODE;
       	U16	wMTCnt;
       	U16 wTZCnt;
       	U8	bINIT;
       	S8  bOffSetT;
    }std;
}uEDT;


#endif
