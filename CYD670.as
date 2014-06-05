opt subtitle "HI-TECH Software Omniscient Code Generator (PRO mode) build 10920"

opt pagewidth 120

	opt pm

	processor	16F883
clrc	macro
	bcf	3,0
	endm
clrz	macro
	bcf	3,2
	endm
setc	macro
	bsf	3,0
	endm
setz	macro
	bsf	3,2
	endm
skipc	macro
	btfss	3,0
	endm
skipz	macro
	btfss	3,2
	endm
skipnc	macro
	btfsc	3,0
	endm
skipnz	macro
	btfsc	3,2
	endm
indf	equ	0
indf0	equ	0
pc	equ	2
pcl	equ	2
status	equ	3
fsr	equ	4
fsr0	equ	4
c	equ	1
z	equ	0
pclath	equ	10
# 27 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	psect config,class=CONFIG,delta=2 ;#
# 27 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	dw 0xFFFC & 0xFFF7 & 0xFFEF & 0xFFDF & 0xFFFF & 0xFFFF & 0xFBFF & 0xFFFF & 0xEFFF & 0xFFFF ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	psect idloc,class=IDLOC,delta=2 ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	global	idloc_word ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
idloc_word ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	irpc	__arg,0000 ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	dw 0&__arg&h ;#
# 28 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	endm ;#
	FNCALL	_main,_pInitMCU
	FNCALL	_main,_pReadEE
	FNCALL	_main,_pClrDisp
	FNCALL	_main,_pKeyProc
	FNCALL	_main,_pDispProc
	FNCALL	_main,_pWashFlow
	FNCALL	_pDispProc,_pConLiter
	FNCALL	_pDispProc,_pRunStep
	FNCALL	_pDispProc,___lldiv
	FNCALL	_pDispProc,___llmod
	FNCALL	_pDispProc,_pSwitchMode
	FNCALL	_pConLiter,___lldiv
	FNCALL	_pConLiter,___llmod
	FNCALL	_pKeyProc,_pSwitchMode
	FNCALL	_pKeyProc,_pTuneHour
	FNCALL	_pKeyProc,_pTuneMin
	FNCALL	_pInitMCU,_pInitAD
	FNCALL	_pInitMCU,_pInitPORT
	FNCALL	_pInitMCU,_pInitT0
	FNCALL	_pInitMCU,_pInitT1
	FNCALL	_pInitMCU,_pInitT2
	FNROOT	_main
	FNCALL	_isr,_pScanKey
	FNCALL	_isr,_pScanDisp
	FNCALL	_pScanKey,_pReadKey
	FNCALL	intlevel1,_isr
	global	intlevel1
	FNROOT	intlevel1
	global	_bSetHour
	global	_bKeyData
psect	idataBANK0,class=CODE,space=0,delta=2
global __pidataBANK0
__pidataBANK0:
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	61

;initializer for _bSetHour
	retlw	01h
psect	idataCOMMON,class=CODE,space=0,delta=2
global __pidataCOMMON
__pidataCOMMON:
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
	line	15

;initializer for _bKeyData
	retlw	0FFh
	global	_tabSeg
psect	strings,class=STRING,delta=2
global __pstrings
__pstrings:
;	global	stringdir,stringtab,__stringbase
stringtab:
;	String table - string pointers are 1 byte each
stringcode:stringdir:
movlw high(stringdir)
movwf pclath
movf fsr,w
incf fsr
	addwf pc
__stringbase:
	retlw	0
psect	strings
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_disp.c"
	line	9
_tabSeg:
	retlw	03Fh
	retlw	09h
	retlw	05Eh
	retlw	05Dh
	retlw	069h
	retlw	075h
	retlw	077h
	retlw	019h
	retlw	07Fh
	retlw	07Dh
	retlw	0
	retlw	01h
	retlw	036h
	retlw	04Fh
	retlw	076h
	retlw	072h
	retlw	07Ah
	retlw	06Bh
	retlw	043h
	global	_tabSeg
	global	_TotalLiter
	global	_bSetTmp
	global	_b10ms
	global	_bFlashCnt
	global	_bKeyCnt
	global	_bLed
	global	_bPulseCnt
	global	_bRunCnt
	global	_bRunMode
	global	_bRunStep
	global	_bRunWashStep
	global	_bSeg0
	global	_bSeg1
	global	_bSeg2
	global	_bSetMin
	global	_bTBCnt
	global	_bKeyHTCnt
	global	_bKeyOld
	global	_bRunWashT
	global	_bScanCnt
	global	_f10ms
	global	_fFlash
	global	_fKeyPress
	global	_fRunWash
	global	_ADCON0
_ADCON0	set	31
	global	_INTCON
_INTCON	set	11
	global	_PORTA
_PORTA	set	5
	global	_PORTB
_PORTB	set	6
	global	_PORTC
_PORTC	set	7
	global	_T1CON
_T1CON	set	16
	global	_T2CON
_T2CON	set	18
	global	_TMR0
_TMR0	set	1
	global	_TMR1H
_TMR1H	set	15
	global	_TMR1L
_TMR1L	set	14
	global	_GIE
_GIE	set	95
	global	_PEIE
_PEIE	set	94
	global	_RA0
_RA0	set	40
	global	_RA1
_RA1	set	41
	global	_RA2
_RA2	set	42
	global	_RB0
_RB0	set	48
	global	_RB1
_RB1	set	49
	global	_RB2
_RB2	set	50
	global	_RB5
_RB5	set	53
	global	_RB7
_RB7	set	55
	global	_RC0
_RC0	set	56
	global	_RC1
_RC1	set	57
	global	_RC2
_RC2	set	58
	global	_T0IE
_T0IE	set	93
	global	_T0IF
_T0IF	set	90
	global	_TMR2IF
_TMR2IF	set	97
	global	_TMR2ON
_TMR2ON	set	146
	global	_ADCON1
_ADCON1	set	159
	global	_IOCB
_IOCB	set	150
	global	_OPTION_REG
_OPTION_REG	set	129
	global	_OSCCON
_OSCCON	set	143
	global	_PIE1
_PIE1	set	140
	global	_PR2
_PR2	set	146
	global	_TRISA
_TRISA	set	133
	global	_TRISB
_TRISB	set	134
	global	_TRISC
_TRISC	set	135
	global	_WPUB
_WPUB	set	149
	global	_HTS
_HTS	set	1146
	global	_TMR1IE
_TMR1IE	set	1120
	global	_TMR2IE
_TMR2IE	set	1121
	global	_TRISB5
_TRISB5	set	1077
	global	_ANSEL
_ANSEL	set	392
	global	_ANSELH
_ANSELH	set	393
	file	"CYD670.as"
	line	#
psect cinit,class=CODE,delta=2
global start_initialization
start_initialization:

psect	bitbssCOMMON,class=COMMON,bit,space=1
global __pbitbssCOMMON
__pbitbssCOMMON:
_f10ms:
       ds      1

_fFlash:
       ds      1

_fKeyPress:
       ds      1

_fRunWash:
       ds      1

psect	bssCOMMON,class=COMMON,space=1
global __pbssCOMMON
__pbssCOMMON:
_bKeyHTCnt:
       ds      1

_bKeyOld:
       ds      1

_bRunWashT:
       ds      1

_bScanCnt:
       ds      1

psect	dataCOMMON,class=COMMON,space=1
global __pdataCOMMON
__pdataCOMMON:
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
	line	15
_bKeyData:
       ds      1

psect	bssBANK0,class=BANK0,space=1
global __pbssBANK0
__pbssBANK0:
_TotalLiter:
       ds      4

_bSetTmp:
       ds      4

_b10ms:
       ds      1

_bFlashCnt:
       ds      1

_bKeyCnt:
       ds      1

_bLed:
       ds      1

_bPulseCnt:
       ds      1

_bRunCnt:
       ds      1

_bRunMode:
       ds      1

_bRunStep:
       ds      1

_bRunWashStep:
       ds      1

_bSeg0:
       ds      1

_bSeg1:
       ds      1

_bSeg2:
       ds      1

_bSetMin:
       ds      1

_bTBCnt:
       ds      1

psect	dataBANK0,class=BANK0,space=1
global __pdataBANK0
__pdataBANK0:
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	61
_bSetHour:
       ds      1

psect clrtext,class=CODE,delta=2
global clear_ram
;	Called with FSR containing the base address, and
;	W with the last address+1
clear_ram:
	clrwdt			;clear the watchdog before getting into this loop
clrloop:
	clrf	indf		;clear RAM location pointed to by FSR
	incf	fsr,f		;increment pointer
	xorwf	fsr,w		;XOR with final address
	btfsc	status,2	;have we reached the end yet?
	retlw	0		;all done for this memory range, return
	xorwf	fsr,w		;XOR again to restore value
	goto	clrloop		;do the next byte

; Clear objects allocated to BITCOMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbitbssCOMMON/8)+0)&07Fh
; Clear objects allocated to COMMON
psect cinit,class=CODE,delta=2
	clrf	((__pbssCOMMON)+0)&07Fh
	clrf	((__pbssCOMMON)+1)&07Fh
	clrf	((__pbssCOMMON)+2)&07Fh
	clrf	((__pbssCOMMON)+3)&07Fh
; Clear objects allocated to BANK0
psect cinit,class=CODE,delta=2
	bcf	status, 7	;select IRP bank0
	movlw	low(__pbssBANK0)
	movwf	fsr
	movlw	low((__pbssBANK0)+016h)
	fcall	clear_ram
; Initialize objects allocated to BANK0
	global __pidataBANK0
psect cinit,class=CODE,delta=2
	fcall	__pidataBANK0+0		;fetch initializer
	movwf	__pdataBANK0+0&07fh		
; Initialize objects allocated to COMMON
	global __pidataCOMMON
psect cinit,class=CODE,delta=2
	fcall	__pidataCOMMON+0		;fetch initializer
	movwf	__pdataCOMMON+0&07fh		
psect cinit,class=CODE,delta=2
global end_of_initialization

;End of C runtime variable initialization code

end_of_initialization:
clrf status
ljmp _main	;jump to C main() function
psect	cstackCOMMON,class=COMMON,space=1
global __pcstackCOMMON
__pcstackCOMMON:
	global	??_pReadKey
??_pReadKey:	; 0 bytes @ 0x0
	global	?_pInitAD
?_pInitAD:	; 0 bytes @ 0x0
	global	?_pInitPORT
?_pInitPORT:	; 0 bytes @ 0x0
	global	?_pInitT0
?_pInitT0:	; 0 bytes @ 0x0
	global	?_pInitT1
?_pInitT1:	; 0 bytes @ 0x0
	global	?_pInitT2
?_pInitT2:	; 0 bytes @ 0x0
	global	?_pReadEE
?_pReadEE:	; 0 bytes @ 0x0
	global	?_pKeyProc
?_pKeyProc:	; 0 bytes @ 0x0
	global	?_pDispProc
?_pDispProc:	; 0 bytes @ 0x0
	global	?_pWashFlow
?_pWashFlow:	; 0 bytes @ 0x0
	global	?_pSwitchMode
?_pSwitchMode:	; 0 bytes @ 0x0
	global	?_pTuneHour
?_pTuneHour:	; 0 bytes @ 0x0
	global	?_pTuneMin
?_pTuneMin:	; 0 bytes @ 0x0
	global	?_pRunStep
?_pRunStep:	; 0 bytes @ 0x0
	global	?_pScanDisp
?_pScanDisp:	; 0 bytes @ 0x0
	global	??_pScanDisp
??_pScanDisp:	; 0 bytes @ 0x0
	global	?_pClrDisp
?_pClrDisp:	; 0 bytes @ 0x0
	global	?_pScanKey
?_pScanKey:	; 0 bytes @ 0x0
	global	?_pInitMCU
?_pInitMCU:	; 0 bytes @ 0x0
	global	?_isr
?_isr:	; 0 bytes @ 0x0
	global	?_main
?_main:	; 0 bytes @ 0x0
	global	?_pReadKey
?_pReadKey:	; 1 bytes @ 0x0
	global	pReadKey@buf
pReadKey@buf:	; 1 bytes @ 0x0
	ds	1
	global	pReadKey@tmp
pReadKey@tmp:	; 1 bytes @ 0x1
	ds	1
	global	pReadKey@i
pReadKey@i:	; 1 bytes @ 0x2
	ds	1
	global	??_pScanKey
??_pScanKey:	; 0 bytes @ 0x3
	global	pScanKey@bKeyBuf
pScanKey@bKeyBuf:	; 1 bytes @ 0x3
	ds	1
	global	??_isr
??_isr:	; 0 bytes @ 0x4
	ds	3
psect	cstackBANK0,class=BANK0,space=1
global __pcstackBANK0
__pcstackBANK0:
	global	??_pInitAD
??_pInitAD:	; 0 bytes @ 0x0
	global	??_pInitPORT
??_pInitPORT:	; 0 bytes @ 0x0
	global	??_pInitT0
??_pInitT0:	; 0 bytes @ 0x0
	global	??_pInitT1
??_pInitT1:	; 0 bytes @ 0x0
	global	??_pInitT2
??_pInitT2:	; 0 bytes @ 0x0
	global	??_pReadEE
??_pReadEE:	; 0 bytes @ 0x0
	global	??_pWashFlow
??_pWashFlow:	; 0 bytes @ 0x0
	global	??_pSwitchMode
??_pSwitchMode:	; 0 bytes @ 0x0
	global	??_pTuneHour
??_pTuneHour:	; 0 bytes @ 0x0
	global	??_pTuneMin
??_pTuneMin:	; 0 bytes @ 0x0
	global	??_pRunStep
??_pRunStep:	; 0 bytes @ 0x0
	global	??_pClrDisp
??_pClrDisp:	; 0 bytes @ 0x0
	global	??_pInitMCU
??_pInitMCU:	; 0 bytes @ 0x0
	global	?___llmod
?___llmod:	; 4 bytes @ 0x0
	global	?___lldiv
?___lldiv:	; 4 bytes @ 0x0
	global	pSwitchMode@mod
pSwitchMode@mod:	; 1 bytes @ 0x0
	global	pRunStep@step
pRunStep@step:	; 1 bytes @ 0x0
	global	___llmod@divisor
___llmod@divisor:	; 4 bytes @ 0x0
	global	___lldiv@divisor
___lldiv@divisor:	; 4 bytes @ 0x0
	ds	1
	global	??_pKeyProc
??_pKeyProc:	; 0 bytes @ 0x1
	ds	3
	global	___llmod@dividend
___llmod@dividend:	; 4 bytes @ 0x4
	global	___lldiv@dividend
___lldiv@dividend:	; 4 bytes @ 0x4
	ds	4
	global	??___llmod
??___llmod:	; 0 bytes @ 0x8
	global	??___lldiv
??___lldiv:	; 0 bytes @ 0x8
	global	___llmod@counter
___llmod@counter:	; 1 bytes @ 0x8
	global	___lldiv@quotient
___lldiv@quotient:	; 4 bytes @ 0x8
	ds	4
	global	___lldiv@counter
___lldiv@counter:	; 1 bytes @ 0xC
	ds	1
	global	?_pConLiter
?_pConLiter:	; 0 bytes @ 0xD
	global	pConLiter@dat
pConLiter@dat:	; 4 bytes @ 0xD
	ds	4
	global	pConLiter@part
pConLiter@part:	; 1 bytes @ 0x11
	ds	1
	global	??_pConLiter
??_pConLiter:	; 0 bytes @ 0x12
	global	pConLiter@s0
pConLiter@s0:	; 1 bytes @ 0x12
	ds	1
	global	pConLiter@s1
pConLiter@s1:	; 1 bytes @ 0x13
	ds	1
	global	pConLiter@s2
pConLiter@s2:	; 1 bytes @ 0x14
	ds	1
	global	??_pDispProc
??_pDispProc:	; 0 bytes @ 0x15
	global	pDispProc@s2
pDispProc@s2:	; 1 bytes @ 0x15
	ds	1
	global	pDispProc@s0
pDispProc@s0:	; 1 bytes @ 0x16
	ds	1
	global	pDispProc@s1
pDispProc@s1:	; 1 bytes @ 0x17
	ds	1
	global	??_main
??_main:	; 0 bytes @ 0x18
;;Data sizes: Strings 0, constant 19, data 2, bss 26, persistent 0 stack 0
;;Auto spaces:   Size  Autos    Used
;; COMMON          14      7      13
;; BANK0           80     24      47
;; BANK1           80      0       0
;; BANK2           80      0       0

;;
;; Pointer list with targets:

;; ?___llmod	unsigned long  size(1) Largest target is 0
;;
;; ?___lldiv	unsigned long  size(1) Largest target is 0
;;


;;
;; Critical Paths under _main in COMMON
;;
;;   None.
;;
;; Critical Paths under _isr in COMMON
;;
;;   _isr->_pScanKey
;;   _pScanKey->_pReadKey
;;
;; Critical Paths under _main in BANK0
;;
;;   _main->_pDispProc
;;   _pDispProc->_pConLiter
;;   _pConLiter->___lldiv
;;   _pKeyProc->_pSwitchMode
;;
;; Critical Paths under _isr in BANK0
;;
;;   None.
;;
;; Critical Paths under _main in BANK1
;;
;;   None.
;;
;; Critical Paths under _isr in BANK1
;;
;;   None.
;;
;; Critical Paths under _main in BANK2
;;
;;   None.
;;
;; Critical Paths under _isr in BANK2
;;
;;   None.

;;
;;Main: autosize = 0, tempsize = 0, incstack = 0, save=0
;;

;;
;;Call Graph Tables:
;;
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (0) _main                                                 0     0      0    1038
;;                           _pInitMCU
;;                            _pReadEE
;;                           _pClrDisp
;;                           _pKeyProc
;;                          _pDispProc
;;                          _pWashFlow
;; ---------------------------------------------------------------------------------
;; (1) _pDispProc                                            3     3      0    1016
;;                                             21 BANK0      3     3      0
;;                          _pConLiter
;;                           _pRunStep
;;                            ___lldiv
;;                            ___llmod
;;                        _pSwitchMode
;; ---------------------------------------------------------------------------------
;; (2) _pConLiter                                            8     3      5     569
;;                                             13 BANK0      8     3      5
;;                            ___lldiv
;;                            ___llmod
;; ---------------------------------------------------------------------------------
;; (1) _pKeyProc                                             0     0      0      22
;;                        _pSwitchMode
;;                          _pTuneHour
;;                           _pTuneMin
;; ---------------------------------------------------------------------------------
;; (1) _pInitMCU                                             0     0      0       0
;;                            _pInitAD
;;                          _pInitPORT
;;                            _pInitT0
;;                            _pInitT1
;;                            _pInitT2
;; ---------------------------------------------------------------------------------
;; (2) ___lldiv                                             13     5      8     162
;;                                              0 BANK0     13     5      8
;; ---------------------------------------------------------------------------------
;; (2) ___llmod                                              9     1      8     159
;;                                              0 BANK0      9     1      8
;; ---------------------------------------------------------------------------------
;; (2) _pRunStep                                             1     1      0      22
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (2) _pTuneMin                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pTuneHour                                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pSwitchMode                                          1     1      0      22
;;                                              0 BANK0      1     1      0
;; ---------------------------------------------------------------------------------
;; (1) _pWashFlow                                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _pReadEE                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pInitT2                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pInitT1                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pInitT0                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pInitPORT                                            0     0      0       0
;; ---------------------------------------------------------------------------------
;; (2) _pInitAD                                              0     0      0       0
;; ---------------------------------------------------------------------------------
;; (1) _pClrDisp                                             0     0      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 2
;; ---------------------------------------------------------------------------------
;; (Depth) Function   	        Calls       Base Space   Used Autos Params    Refs
;; ---------------------------------------------------------------------------------
;; (4) _isr                                                  3     3      0     185
;;                                              4 COMMON     3     3      0
;;                           _pScanKey
;;                          _pScanDisp
;; ---------------------------------------------------------------------------------
;; (5) _pScanKey                                             1     1      0     185
;;                                              3 COMMON     1     1      0
;;                           _pReadKey
;; ---------------------------------------------------------------------------------
;; (6) _pReadKey                                             3     3      0     140
;;                                              0 COMMON     3     3      0
;; ---------------------------------------------------------------------------------
;; (5) _pScanDisp                                            1     1      0       0
;; ---------------------------------------------------------------------------------
;; Estimated maximum stack depth 6
;; ---------------------------------------------------------------------------------

;; Call Graph Graphs:

;; _main (ROOT)
;;   _pInitMCU
;;     _pInitAD
;;     _pInitPORT
;;     _pInitT0
;;     _pInitT1
;;     _pInitT2
;;   _pReadEE
;;   _pClrDisp
;;   _pKeyProc
;;     _pSwitchMode
;;     _pTuneHour
;;     _pTuneMin
;;   _pDispProc
;;     _pConLiter
;;       ___lldiv
;;       ___llmod
;;     _pRunStep
;;     ___lldiv
;;     ___llmod
;;     _pSwitchMode
;;   _pWashFlow
;;
;; _isr (ROOT)
;;   _pScanKey
;;     _pReadKey
;;   _pScanDisp
;;

;; Address spaces:

;;Name               Size   Autos  Total    Cost      Usage
;;SFR3                 0      0       0       4        0.0%
;;BITSFR3              0      0       0       4        0.0%
;;BANK2               50      0       0       7        0.0%
;;BITBANK2            50      0       0       6        0.0%
;;SFR2                 0      0       0       5        0.0%
;;BITSFR2              0      0       0       5        0.0%
;;SFR1                 0      0       0       2        0.0%
;;BITSFR1              0      0       0       2        0.0%
;;BANK1               50      0       0       5        0.0%
;;BITBANK1            50      0       0       4        0.0%
;;CODE                 0      0       0       0        0.0%
;;DATA                 0      0      45      10        0.0%
;;ABS                  0      0      3C       8        0.0%
;;NULL                 0      0       0       0        0.0%
;;STACK                0      0       9       2        0.0%
;;BANK0               50     18      2F       3       58.8%
;;BITBANK0            50      0       0       9        0.0%
;;SFR0                 0      0       0       1        0.0%
;;BITSFR0              0      0       0       1        0.0%
;;COMMON               E      7       D       1       92.9%
;;BITCOMMON            E      0       1       0        7.1%
;;EEDATA             100      0       0       0        0.0%

	global	_main
psect	maintext,global,class=CODE,delta=2
global __pmaintext
__pmaintext:

;; *************** function _main *****************
;; Defined at:
;;		line 166 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 60/0
;;		Unchanged: FFE00/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels required when called:    6
;; This function calls:
;;		_pInitMCU
;;		_pReadEE
;;		_pClrDisp
;;		_pKeyProc
;;		_pDispProc
;;		_pWashFlow
;; This function is called by:
;;		Startup code after reset
;; This function uses a non-reentrant model
;;
psect	maintext
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	166
	global	__size_of_main
	__size_of_main	equ	__end_of_main-_main
	
_main:	
	opt	stack 2
; Regs used in _main: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	167
	
l7602:	
;main.c: 167: pInitMCU();
	fcall	_pInitMCU
	line	169
	
l7604:	
;main.c: 169: pReadEE();
	fcall	_pReadEE
	line	170
	
l7606:	
;main.c: 170: pClrDisp();
	fcall	_pClrDisp
	line	173
	
l7608:	
;main.c: 173: TMR2ON = 1;
	bsf	(146/8),(146)&7
	line	174
	
l7610:	
;main.c: 174: GIE = 1;
	bsf	(95/8),(95)&7
	line	176
	
l7612:	
;main.c: 176: bTBCnt = 20;
	movlw	(014h)
	movwf	(_bTBCnt)
	line	179
	
l7614:	
;main.c: 178: {
;main.c: 179: if (f10ms)
	btfss	(_f10ms/8),(_f10ms)&7
	goto	u1321
	goto	u1320
u1321:
	goto	l5031
u1320:
	line	181
	
l7616:	
# 181 "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
clrwdt ;#
psect	maintext
	line	182
;main.c: 182: f10ms = 0;
	bcf	(_f10ms/8),(_f10ms)&7
	line	183
	
l7618:	
;main.c: 183: bTBCnt--;
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	decf	(_bTBCnt),f
	line	184
	
l5031:	
	line	185
;main.c: 184: }
;main.c: 185: }while (bTBCnt);
	movf	(_bTBCnt),f
	skipz
	goto	u1331
	goto	u1330
u1331:
	goto	l7614
u1330:
	line	189
;main.c: 189: while (1)
	
l5033:	
	line	191
;main.c: 190: {
;main.c: 191: if (f10ms)
	btfss	(_f10ms/8),(_f10ms)&7
	goto	u1341
	goto	u1340
u1341:
	goto	l5033
u1340:
	line	195
	
l7620:	
;main.c: 192: {
;main.c: 195: f10ms = 0;
	bcf	(_f10ms/8),(_f10ms)&7
	line	196
	
l7622:	
;main.c: 196: pKeyProc();
	fcall	_pKeyProc
	line	200
;main.c: 200: switch (bTBCnt)
	goto	l7636
	line	203
	
l7624:	
;main.c: 203: if (bFlashCnt==0)
	movf	(_bFlashCnt),f
	skipz
	goto	u1351
	goto	u1350
u1351:
	goto	l7628
u1350:
	line	205
	
l7626:	
;main.c: 204: {
;main.c: 205: bFlashCnt = 4;
	movlw	(04h)
	movwf	(_bFlashCnt)
	line	206
;main.c: 206: fFlash = !fFlash;
	movlw	1<<((_fFlash)&7)
	xorwf	((_fFlash)/8),f
	line	207
;main.c: 207: }
	goto	l7638
	line	209
	
l7628:	
;main.c: 208: else
;main.c: 209: bFlashCnt--;
	decf	(_bFlashCnt),f
	goto	l7638
	line	214
	
l7630:	
;main.c: 214: pDispProc();
	fcall	_pDispProc
	line	215
;main.c: 215: break;
	goto	l7638
	line	218
	
l7632:	
;main.c: 218: pWashFlow();
	fcall	_pWashFlow
	line	219
;main.c: 219: break;
	goto	l7638
	line	200
	
l7636:	
	movf	(_bTBCnt),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l7624
	xorlw	1^0	; case 1
	skipnz
	goto	l7630
	xorlw	2^1	; case 2
	skipnz
	goto	l7632
	goto	l7638
	opt asmopt_on

	line	223
	
l7638:	
;main.c: 223: if (++bTBCnt >= 10)
	movlw	(0Ah)
	incf	(_bTBCnt),f
	subwf	((_bTBCnt)),w
	skipc
	goto	u1361
	goto	u1360
u1361:
	goto	l5033
u1360:
	line	224
	
l7640:	
;main.c: 224: bTBCnt=0;
	clrf	(_bTBCnt)
	goto	l5033
	global	start
	ljmp	start
	opt stack 0
psect	maintext
	line	229
GLOBAL	__end_of_main
	__end_of_main:
;; =============== function _main ends ============

	signat	_main,88
	global	_pDispProc
psect	text443,local,class=CODE,delta=2
global __ptext443
__ptext443:

;; *************** function _pDispProc *****************
;; Defined at:
;;		line 473 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  s1              1   23[BANK0 ] unsigned char 
;;  s0              1   22[BANK0 ] unsigned char 
;;  s2              1   21[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       3       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       3       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    5
;; This function calls:
;;		_pConLiter
;;		_pRunStep
;;		___lldiv
;;		___llmod
;;		_pSwitchMode
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text443
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	473
	global	__size_of_pDispProc
	__size_of_pDispProc	equ	__end_of_pDispProc-_pDispProc
	
_pDispProc:	
	opt	stack 2
; Regs used in _pDispProc: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	476
	
l7518:	
;main.c: 474: U8 s0,s1,s2;
;main.c: 476: switch (bRunMode)
	goto	l7600
	line	480
	
l7520:	
;main.c: 480: pConLiter(TotalLiter,0);
	movf	(_TotalLiter+3),w
	movwf	(?_pConLiter+3)
	movf	(_TotalLiter+2),w
	movwf	(?_pConLiter+2)
	movf	(_TotalLiter+1),w
	movwf	(?_pConLiter+1)
	movf	(_TotalLiter),w
	movwf	(?_pConLiter)

	clrf	0+(?_pConLiter)+04h
	fcall	_pConLiter
	line	481
;main.c: 481: break;
	goto	l5141
	line	489
	
l7522:	
;main.c: 489: s2=16;
	movlw	(010h)
	movwf	(pDispProc@s2)
	line	490
	
l7524:	
;main.c: 490: s1=1;
	clrf	(pDispProc@s1)
	incf	(pDispProc@s1),f
	line	491
;main.c: 491: s0=10;
	movlw	(0Ah)
	movwf	(pDispProc@s0)
	line	493
	
l7526:	
;main.c: 493: if (++bRunCnt >= 20)
	movlw	(014h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1191
	goto	u1190
u1191:
	goto	l7574
u1190:
	line	494
	
l7528:	
;main.c: 494: pRunStep(1);
	movlw	(01h)
	fcall	_pRunStep
	goto	l7574
	line	499
	
l7530:	
;main.c: 499: s2=17;
	movlw	(011h)
	movwf	(pDispProc@s2)
	line	500
;main.c: 500: s1=10;
	movlw	(0Ah)
	movwf	(pDispProc@s1)
	line	501
;main.c: 501: s0=10;
	movlw	(0Ah)
	movwf	(pDispProc@s0)
	line	503
	
l7532:	
;main.c: 503: if (fFlash)
	btfss	(_fFlash/8),(_fFlash)&7
	goto	u1201
	goto	u1200
u1201:
	goto	l7536
u1200:
	line	505
	
l7534:	
;main.c: 504: {
;main.c: 505: s1=bSetTmp/10;
	movlw	0Ah
	movwf	(?___lldiv)
	clrf	(?___lldiv+1)
	clrf	(?___lldiv+2)
	clrf	(?___lldiv+3)

	movf	(_bSetTmp+3),w
	movwf	3+(?___lldiv)+04h
	movf	(_bSetTmp+2),w
	movwf	2+(?___lldiv)+04h
	movf	(_bSetTmp+1),w
	movwf	1+(?___lldiv)+04h
	movf	(_bSetTmp),w
	movwf	0+(?___lldiv)+04h

	fcall	___lldiv
	movf	0+(((0+(?___lldiv)))),w
	movwf	(pDispProc@s1)
	line	506
;main.c: 506: s0=bSetTmp%10;
	movlw	0Ah
	movwf	(?___llmod)
	clrf	(?___llmod+1)
	clrf	(?___llmod+2)
	clrf	(?___llmod+3)

	movf	(_bSetTmp+3),w
	movwf	3+(?___llmod)+04h
	movf	(_bSetTmp+2),w
	movwf	2+(?___llmod)+04h
	movf	(_bSetTmp+1),w
	movwf	1+(?___llmod)+04h
	movf	(_bSetTmp),w
	movwf	0+(?___llmod)+04h

	fcall	___llmod
	movf	0+(((0+(?___llmod)))),w
	movwf	(pDispProc@s0)
	line	509
	
l7536:	
;main.c: 507: }
;main.c: 509: if (++bRunCnt >= 100)
	movlw	(064h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1211
	goto	u1210
u1211:
	goto	l7574
u1210:
	line	510
	
l7538:	
;main.c: 510: pSwitchMode(0);
	movlw	(0)
	fcall	_pSwitchMode
	goto	l7574
	line	515
	
l7540:	
;main.c: 515: s2=18;
	movlw	(012h)
	movwf	(pDispProc@s2)
	line	516
;main.c: 516: s1=10;
	movlw	(0Ah)
	movwf	(pDispProc@s1)
	line	517
;main.c: 517: s0=10;
	movlw	(0Ah)
	movwf	(pDispProc@s0)
	line	519
	
l7542:	
;main.c: 519: if (fFlash)
	btfss	(_fFlash/8),(_fFlash)&7
	goto	u1221
	goto	u1220
u1221:
	goto	l7546
u1220:
	line	521
	
l7544:	
;main.c: 520: {
;main.c: 521: s1=bSetTmp/10;
	movlw	0Ah
	movwf	(?___lldiv)
	clrf	(?___lldiv+1)
	clrf	(?___lldiv+2)
	clrf	(?___lldiv+3)

	movf	(_bSetTmp+3),w
	movwf	3+(?___lldiv)+04h
	movf	(_bSetTmp+2),w
	movwf	2+(?___lldiv)+04h
	movf	(_bSetTmp+1),w
	movwf	1+(?___lldiv)+04h
	movf	(_bSetTmp),w
	movwf	0+(?___lldiv)+04h

	fcall	___lldiv
	movf	0+(((0+(?___lldiv)))),w
	movwf	(pDispProc@s1)
	line	522
;main.c: 522: s0=bSetTmp%10;
	movlw	0Ah
	movwf	(?___llmod)
	clrf	(?___llmod+1)
	clrf	(?___llmod+2)
	clrf	(?___llmod+3)

	movf	(_bSetTmp+3),w
	movwf	3+(?___llmod)+04h
	movf	(_bSetTmp+2),w
	movwf	2+(?___llmod)+04h
	movf	(_bSetTmp+1),w
	movwf	1+(?___llmod)+04h
	movf	(_bSetTmp),w
	movwf	0+(?___llmod)+04h

	fcall	___llmod
	movf	0+(((0+(?___llmod)))),w
	movwf	(pDispProc@s0)
	line	525
	
l7546:	
;main.c: 523: }
;main.c: 525: if (++bRunCnt >= 100)
	movlw	(064h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1231
	goto	u1230
u1231:
	goto	l7574
u1230:
	line	526
	
l7548:	
;main.c: 526: pRunStep(3);
	movlw	(03h)
	fcall	_pRunStep
	goto	l7574
	line	531
	
l7550:	
;main.c: 531: if ((bSetHour==0)&&(bSetMin==0))
	movf	(_bSetHour),f
	skipz
	goto	u1241
	goto	u1240
u1241:
	goto	l7556
u1240:
	
l7552:	
	movf	(_bSetMin),f
	skipz
	goto	u1251
	goto	u1250
u1251:
	goto	l7556
u1250:
	line	532
	
l7554:	
;main.c: 532: bSetMin = 50;
	movlw	(032h)
	movwf	(_bSetMin)
	goto	l5127
	line	533
	
l7556:	
;main.c: 533: else if ((bSetHour==24)&&(bSetMin!=0))
	movf	(_bSetHour),w
	xorlw	018h
	skipz
	goto	u1261
	goto	u1260
u1261:
	goto	l7562
u1260:
	
l7558:	
	movf	(_bSetMin),w
	skipz
	goto	u1270
	goto	l7562
u1270:
	line	534
	
l7560:	
;main.c: 534: bSetMin = 0;
	clrf	(_bSetMin)
	goto	l5127
	line	536
	
l7562:	
;main.c: 535: else
;main.c: 536: pSwitchMode(0);
	movlw	(0)
	fcall	_pSwitchMode
	
l5127:	
	line	538
;main.c: 538: pRunStep(4);
	movlw	(04h)
	fcall	_pRunStep
	line	539
;main.c: 539: break;
	goto	l7574
	line	543
	
l7564:	
;main.c: 543: s2=14;
	movlw	(0Eh)
	movwf	(pDispProc@s2)
	line	544
;main.c: 544: s1=14;
	movlw	(0Eh)
	movwf	(pDispProc@s1)
	line	545
;main.c: 545: s0=14;
	movlw	(0Eh)
	movwf	(pDispProc@s0)
	line	547
	
l7566:	
;main.c: 547: if (++bRunCnt >= 20)
	movlw	(014h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1281
	goto	u1280
u1281:
	goto	l7574
u1280:
	line	548
	
l7568:	
;main.c: 548: pSwitchMode(0);
	movlw	(0)
	fcall	_pSwitchMode
	goto	l7574
	line	485
	
l7572:	
	movf	(_bRunStep),w
	; Switch size 1, requested type "space"
; Number of cases is 5, Range of values is 0 to 4
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           16     9 (average)
; direct_byte           17     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             9     6 (fixed)
; spacedrange           16     9 (fixed)
; locatedrange           5     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l7522
	xorlw	1^0	; case 1
	skipnz
	goto	l7530
	xorlw	2^1	; case 2
	skipnz
	goto	l7540
	xorlw	3^2	; case 3
	skipnz
	goto	l7550
	xorlw	4^3	; case 4
	skipnz
	goto	l7564
	goto	l7574
	opt asmopt_on

	line	552
	
l7574:	
;main.c: 552: bSeg2 = ~tabSeg[s2];
	movf	(pDispProc@s2),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg2)
	line	553
;main.c: 553: bSeg1 = ~tabSeg[s1];
	movf	(pDispProc@s1),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg1)
	line	554
;main.c: 554: bSeg0 = ~tabSeg[s0];
	movf	(pDispProc@s0),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg0)
	line	556
;main.c: 556: break;
	goto	l5141
	line	564
	
l7576:	
;main.c: 564: bSeg2 = ~tabSeg[16];
	movlw	(_tabSeg-__stringbase)+010h
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg2)
	line	565
;main.c: 565: bSeg1 = ~tabSeg[2];
	movlw	(_tabSeg-__stringbase)+02h
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg1)
	line	566
;main.c: 566: bSeg0 = ~tabSeg[10];
	movlw	(_tabSeg-__stringbase)+0Ah
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg0)
	line	568
	
l7578:	
;main.c: 568: if (++bRunCnt >= 20)
	movlw	(014h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1291
	goto	u1290
u1291:
	goto	l5141
u1290:
	line	569
	
l7580:	
;main.c: 569: pRunStep(1);
	movlw	(01h)
	fcall	_pRunStep
	goto	l5141
	line	575
	
l7582:	
;main.c: 575: pConLiter(bSetTmp,1);
	movf	(_bSetTmp+3),w
	movwf	(?_pConLiter+3)
	movf	(_bSetTmp+2),w
	movwf	(?_pConLiter+2)
	movf	(_bSetTmp+1),w
	movwf	(?_pConLiter+1)
	movf	(_bSetTmp),w
	movwf	(?_pConLiter)

	clrf	0+(?_pConLiter)+04h
	incf	0+(?_pConLiter)+04h,f
	fcall	_pConLiter
	line	577
	
l7584:	
;main.c: 577: if (++bRunCnt >= 40)
	movlw	(028h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1301
	goto	u1300
u1301:
	goto	l5141
u1300:
	line	578
	
l7586:	
;main.c: 578: pRunStep(2);
	movlw	(02h)
	fcall	_pRunStep
	goto	l5141
	line	583
	
l7588:	
;main.c: 583: pConLiter(bSetTmp,0);
	movf	(_bSetTmp+3),w
	movwf	(?_pConLiter+3)
	movf	(_bSetTmp+2),w
	movwf	(?_pConLiter+2)
	movf	(_bSetTmp+1),w
	movwf	(?_pConLiter+1)
	movf	(_bSetTmp),w
	movwf	(?_pConLiter)

	clrf	0+(?_pConLiter)+04h
	fcall	_pConLiter
	line	585
	
l7590:	
;main.c: 585: if (++bRunCnt >= 100)
	movlw	(064h)
	incf	(_bRunCnt),f
	subwf	((_bRunCnt)),w
	skipc
	goto	u1311
	goto	u1310
u1311:
	goto	l5141
u1310:
	line	586
	
l7592:	
;main.c: 586: pSwitchMode(0);
	movlw	(0)
	fcall	_pSwitchMode
	goto	l5141
	line	560
	
l7596:	
	movf	(_bRunStep),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l7576
	xorlw	1^0	; case 1
	skipnz
	goto	l7582
	xorlw	2^1	; case 2
	skipnz
	goto	l7588
	goto	l5141
	opt asmopt_on

	line	476
	
l7600:	
	movf	(_bRunMode),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l7520
	xorlw	1^0	; case 1
	skipnz
	goto	l7572
	xorlw	2^1	; case 2
	skipnz
	goto	l7596
	goto	l5141
	opt asmopt_on

	line	592
	
l5141:	
	return
	opt stack 0
GLOBAL	__end_of_pDispProc
	__end_of_pDispProc:
;; =============== function _pDispProc ends ============

	signat	_pDispProc,88
	global	_pConLiter
psect	text444,local,class=CODE,delta=2
global __ptext444
__ptext444:

;; *************** function _pConLiter *****************
;; Defined at:
;;		line 605 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;  dat             4   13[BANK0 ] unsigned long 
;;  part            1   17[BANK0 ] unsigned char 
;; Auto vars:     Size  Location     Type
;;  s2              1   20[BANK0 ] unsigned char 
;;  s1              1   19[BANK0 ] unsigned char 
;;  s0              1   18[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       5       0       0
;;      Locals:         0       3       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       8       0       0
;;Total ram usage:        8 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		___lldiv
;;		___llmod
;; This function is called by:
;;		_pDispProc
;; This function uses a non-reentrant model
;;
psect	text444
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	605
	global	__size_of_pConLiter
	__size_of_pConLiter	equ	__end_of_pConLiter-_pConLiter
	
_pConLiter:	
	opt	stack 2
; Regs used in _pConLiter: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	608
	
l7502:	
;main.c: 606: U8 s0,s1,s2;
;main.c: 608: if (part==1)
	decf	(pConLiter@part),w
	skipz
	goto	u1161
	goto	u1160
u1161:
	goto	l5147
u1160:
	line	609
	
l7504:	
;main.c: 609: dat/=1000;
	movlw	0
	movwf	(?___lldiv+3)
	movlw	0
	movwf	(?___lldiv+2)
	movlw	03h
	movwf	(?___lldiv+1)
	movlw	0E8h
	movwf	(?___lldiv)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___lldiv)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___lldiv)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___lldiv)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___lldiv)+04h

	fcall	___lldiv
	movf	(3+(?___lldiv)),w
	movwf	(pConLiter@dat+3)
	movf	(2+(?___lldiv)),w
	movwf	(pConLiter@dat+2)
	movf	(1+(?___lldiv)),w
	movwf	(pConLiter@dat+1)
	movf	(0+(?___lldiv)),w
	movwf	(pConLiter@dat)

	
l5147:	
	line	611
;main.c: 611: s0=dat%10;
	movlw	0Ah
	movwf	(?___llmod)
	clrf	(?___llmod+1)
	clrf	(?___llmod+2)
	clrf	(?___llmod+3)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___llmod)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___llmod)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___llmod)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___llmod)+04h

	fcall	___llmod
	movf	0+(((0+(?___llmod)))),w
	movwf	(pConLiter@s0)
	line	612
;main.c: 612: dat/=10;
	movlw	0Ah
	movwf	(?___lldiv)
	clrf	(?___lldiv+1)
	clrf	(?___lldiv+2)
	clrf	(?___lldiv+3)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___lldiv)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___lldiv)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___lldiv)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___lldiv)+04h

	fcall	___lldiv
	movf	(3+(?___lldiv)),w
	movwf	(pConLiter@dat+3)
	movf	(2+(?___lldiv)),w
	movwf	(pConLiter@dat+2)
	movf	(1+(?___lldiv)),w
	movwf	(pConLiter@dat+1)
	movf	(0+(?___lldiv)),w
	movwf	(pConLiter@dat)

	line	613
;main.c: 613: s1=dat%10;
	movlw	0Ah
	movwf	(?___llmod)
	clrf	(?___llmod+1)
	clrf	(?___llmod+2)
	clrf	(?___llmod+3)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___llmod)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___llmod)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___llmod)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___llmod)+04h

	fcall	___llmod
	movf	0+(((0+(?___llmod)))),w
	movwf	(pConLiter@s1)
	line	614
;main.c: 614: dat/=10;
	movlw	0Ah
	movwf	(?___lldiv)
	clrf	(?___lldiv+1)
	clrf	(?___lldiv+2)
	clrf	(?___lldiv+3)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___lldiv)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___lldiv)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___lldiv)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___lldiv)+04h

	fcall	___lldiv
	movf	(3+(?___lldiv)),w
	movwf	(pConLiter@dat+3)
	movf	(2+(?___lldiv)),w
	movwf	(pConLiter@dat+2)
	movf	(1+(?___lldiv)),w
	movwf	(pConLiter@dat+1)
	movf	(0+(?___lldiv)),w
	movwf	(pConLiter@dat)

	line	615
;main.c: 615: s2=dat%10;
	movlw	0Ah
	movwf	(?___llmod)
	clrf	(?___llmod+1)
	clrf	(?___llmod+2)
	clrf	(?___llmod+3)

	movf	(pConLiter@dat+3),w
	movwf	3+(?___llmod)+04h
	movf	(pConLiter@dat+2),w
	movwf	2+(?___llmod)+04h
	movf	(pConLiter@dat+1),w
	movwf	1+(?___llmod)+04h
	movf	(pConLiter@dat),w
	movwf	0+(?___llmod)+04h

	fcall	___llmod
	movf	0+(((0+(?___llmod)))),w
	movwf	(pConLiter@s2)
	line	617
	
l7506:	
;main.c: 617: bSeg0 = ~tabSeg[s0];
	movf	(pConLiter@s0),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg0)
	line	618
	
l7508:	
;main.c: 618: bSeg1 = ~tabSeg[s1];
	movf	(pConLiter@s1),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg1)
	line	619
	
l7510:	
;main.c: 619: bSeg2 = ~tabSeg[s2];
	movf	(pConLiter@s2),w
	addlw	low((_tabSeg-__stringbase))
	movwf	fsr0
	fcall	stringdir
	xorlw	0ffh
	movwf	(_bSeg2)
	line	622
	
l7512:	
;main.c: 622: if (part==0)
	movf	(pConLiter@part),f
	skipz
	goto	u1171
	goto	u1170
u1171:
	goto	l5151
u1170:
	line	624
	
l7514:	
;main.c: 623: {
;main.c: 624: if (fFlash)
	btfss	(_fFlash/8),(_fFlash)&7
	goto	u1181
	goto	u1180
u1181:
	goto	l5149
u1180:
	line	625
	
l7516:	
;main.c: 625: bSeg0 &= 0x7F;
	bcf	(_bSeg0)+(7/8),(7)&7
	goto	l5151
	line	626
	
l5149:	
	line	627
;main.c: 626: else
;main.c: 627: bSeg0 |= 0x80;
	bsf	(_bSeg0)+(7/8),(7)&7
	line	629
	
l5151:	
	return
	opt stack 0
GLOBAL	__end_of_pConLiter
	__end_of_pConLiter:
;; =============== function _pConLiter ends ============

	signat	_pConLiter,8312
	global	_pKeyProc
psect	text445,local,class=CODE,delta=2
global __ptext445
__ptext445:

;; *************** function _pKeyProc *****************
;; Defined at:
;;		line 247 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_pSwitchMode
;;		_pTuneHour
;;		_pTuneMin
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text445
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	247
	global	__size_of_pKeyProc
	__size_of_pKeyProc	equ	__end_of_pKeyProc-_pKeyProc
	
_pKeyProc:	
	opt	stack 3
; Regs used in _pKeyProc: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	248
	
l7410:	
;main.c: 248: if (fKeyPress)
	btfss	(_fKeyPress/8),(_fKeyPress)&7
	goto	u961
	goto	u960
u961:
	goto	l5048
u960:
	line	251
	
l7412:	
;main.c: 249: {
;main.c: 251: if (bKeyData.byte == 0xFF)
	movf	(_bKeyData),w
	xorlw	0FFh
	skipz
	goto	u971
	goto	u970
u971:
	goto	l7416
u970:
	line	253
	
l7414:	
;main.c: 252: {
;main.c: 253: fKeyPress = 0;
	bcf	(_fKeyPress/8),(_fKeyPress)&7
	line	257
	
l7416:	
;main.c: 254: }
;main.c: 257: if (bKeyHTCnt == 0)
	movf	(_bKeyHTCnt),f
	skipz
	goto	u981
	goto	u980
u981:
	goto	l7432
u980:
	line	259
	
l7418:	
;main.c: 258: {
;main.c: 259: if (!bKeyData.bits.b2)
	btfsc	(_bKeyData),2
	goto	u991
	goto	u990
u991:
	goto	l5051
u990:
	line	261
	
l7420:	
;main.c: 260: {
;main.c: 261: if (bRunMode == 0)
	movf	(_bRunMode),f
	skipz
	goto	u1001
	goto	u1000
u1001:
	goto	l7426
u1000:
	line	263
	
l7422:	
;main.c: 262: {
;main.c: 263: bSetTmp=bSetHour;
	movf	(_bSetHour),w
	movwf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)

	line	264
	
l7424:	
;main.c: 264: pSwitchMode(1);
	movlw	(01h)
	fcall	_pSwitchMode
	line	266
	
l7426:	
;main.c: 265: }
;main.c: 266: bKeyHTCnt=255;
	movlw	(0FFh)
	movwf	(_bKeyHTCnt)
	line	267
;main.c: 267: }
	goto	l5093
	line	268
	
l5051:	
;main.c: 268: else if (!bKeyData.bits.b0)
	btfsc	(_bKeyData),0
	goto	u1011
	goto	u1010
u1011:
	goto	l5054
u1010:
	goto	l5093
	line	274
	
l5054:	
;main.c: 274: else if (!bKeyData.bits.b1)
	btfsc	(_bKeyData),1
	goto	u1021
	goto	u1020
u1021:
	goto	l5058
u1020:
	line	278
	
l7430:	
;main.c: 275: {
;main.c: 278: bKeyHTCnt = 20;
	movlw	(014h)
	movwf	(_bKeyHTCnt)
	line	279
;main.c: 279: goto _WASH_KEY;
	goto	l7488
	line	282
	
l7432:	
;main.c: 282: else if (bKeyHTCnt != 255)
	movf	(_bKeyHTCnt),w
	xorlw	0FFh
	skipnz
	goto	u1031
	goto	u1030
u1031:
	goto	l5093
u1030:
	line	283
	
l7434:	
;main.c: 283: bKeyHTCnt--;
	decf	(_bKeyHTCnt),f
	goto	l5093
	line	284
	
l5058:	
;main.c: 284: }
	goto	l5093
	line	286
	
l5048:	
	line	289
;main.c: 286: else
;main.c: 287: {
;main.c: 289: if (!bKeyData.bits.b2)
	btfsc	(_bKeyData),2
	goto	u1041
	goto	u1040
u1041:
	goto	l5061
u1040:
	goto	l7470
	line	295
	
l7438:	
;main.c: 295: bKeyHTCnt = 200;
	movlw	(0C8h)
	movwf	(_bKeyHTCnt)
	line	296
;main.c: 296: break;
	goto	l7500
	line	300
	
l7440:	
;main.c: 300: if (bRunStep==1)
	decf	(_bRunStep),w
	skipz
	goto	u1051
	goto	u1050
u1051:
	goto	l7456
u1050:
	line	302
	
l7442:	
;main.c: 301: {
;main.c: 302: bSetHour = bSetTmp;
	movf	(_bSetTmp),w
	movwf	(_bSetHour)
	line	304
	
l7444:	
;main.c: 304: if ((bSetHour==0)&&(bSetMin==0))
	movf	(_bSetHour),f
	skipz
	goto	u1061
	goto	u1060
u1061:
	goto	l7450
u1060:
	
l7446:	
	movf	(_bSetMin),f
	skipz
	goto	u1071
	goto	u1070
u1071:
	goto	l7450
u1070:
	line	305
	
l7448:	
;main.c: 305: bSetTmp=10;
	movlw	0Ah
	movwf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)

	goto	l7452
	line	307
	
l7450:	
;main.c: 306: else
;main.c: 307: bSetTmp=bSetMin;
	movf	(_bSetMin),w
	movwf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)

	line	309
	
l7452:	
;main.c: 309: bRunStep++;
	incf	(_bRunStep),f
	line	310
	
l7454:	
;main.c: 310: bRunCnt=0;
	clrf	(_bRunCnt)
	line	311
;main.c: 311: }
	goto	l7500
	line	313
	
l7456:	
;main.c: 313: else if (bRunStep == 2)
	movf	(_bRunStep),w
	xorlw	02h
	skipz
	goto	u1081
	goto	u1080
u1081:
	goto	l5064
u1080:
	line	315
	
l7458:	
;main.c: 314: {
;main.c: 315: bSetMin = bSetTmp;
	movf	(_bSetTmp),w
	movwf	(_bSetMin)
	line	317
;main.c: 317: bSetTmp = TotalLiter;
	movf	(_TotalLiter+3),w
	movwf	(_bSetTmp+3)
	movf	(_TotalLiter+2),w
	movwf	(_bSetTmp+2)
	movf	(_TotalLiter+1),w
	movwf	(_bSetTmp+1)
	movf	(_TotalLiter),w
	movwf	(_bSetTmp)

	line	318
	
l7460:	
;main.c: 318: pSwitchMode(2);
	movlw	(02h)
	fcall	_pSwitchMode
	goto	l7500
	line	323
	
l7462:	
;main.c: 323: if (bRunStep > 0)
	movf	(_bRunStep),w
	skipz
	goto	u1090
	goto	l7500
u1090:
	line	325
	
l7464:	
;main.c: 324: {
;main.c: 325: TotalLiter = bSetTmp;
	movf	(_bSetTmp+3),w
	movwf	(_TotalLiter+3)
	movf	(_bSetTmp+2),w
	movwf	(_TotalLiter+2)
	movf	(_bSetTmp+1),w
	movwf	(_TotalLiter+1)
	movf	(_bSetTmp),w
	movwf	(_TotalLiter)

	line	326
	
l7466:	
;main.c: 326: pSwitchMode(0);
	movlw	(0)
	fcall	_pSwitchMode
	goto	l7500
	line	292
	
l7470:	
	movf	(_bRunMode),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l7438
	xorlw	1^0	; case 1
	skipnz
	goto	l7440
	xorlw	2^1	; case 2
	skipnz
	goto	l7462
	goto	l7500
	opt asmopt_on

	line	329
	
l5064:	
	line	331
;main.c: 331: goto _KPRESS2;
	goto	l7500
	line	334
	
l5061:	
;main.c: 334: else if (!bKeyData.bits.b1)
	btfsc	(_bKeyData),1
	goto	u1101
	goto	u1100
u1101:
	goto	l5075
u1100:
	goto	l7488
	line	341
;main.c: 339: {
;main.c: 341: case 0:
	
l5077:	
	line	342
;main.c: 342: fRunWash=1;
	bsf	(_fRunWash/8),(_fRunWash)&7
	line	343
;main.c: 343: break;
	goto	l5084
	line	347
	
l7474:	
;main.c: 347: if (bRunStep==1)
	decf	(_bRunStep),w
	skipz
	goto	u1111
	goto	u1110
u1111:
	goto	l7478
u1110:
	line	348
	
l7476:	
;main.c: 348: pTuneHour();
	fcall	_pTuneHour
	line	349
	
l7478:	
;main.c: 349: if (bRunStep==2)
	movf	(_bRunStep),w
	xorlw	02h
	skipz
	goto	u1121
	goto	u1120
u1121:
	goto	l5084
u1120:
	line	350
	
l7480:	
;main.c: 350: pTuneMin();
	fcall	_pTuneMin
	goto	l5084
	line	355
	
l7482:	
;main.c: 355: if (bRunStep==1)
	decf	(_bRunStep),w
	skipz
	goto	u1131
	goto	u1130
u1131:
	goto	l5084
u1130:
	line	356
	
l7484:	
;main.c: 356: bSetTmp=0;
	clrf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)
	goto	l5084
	line	338
	
l7488:	
	movf	(_bRunMode),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l5077
	xorlw	1^0	; case 1
	skipnz
	goto	l7474
	xorlw	2^1	; case 2
	skipnz
	goto	l7482
	goto	l5084
	opt asmopt_on

	line	362
	
l5075:	
;main.c: 362: else if (!bKeyData.bits.b0)
	btfsc	(_bKeyData),0
	goto	u1141
	goto	u1140
u1141:
	goto	l5093
u1140:
	line	365
	
l7496:	
	movf	(_bRunMode),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l5084
	xorlw	1^0	; case 1
	skipnz
	goto	l5084
	xorlw	2^1	; case 2
	skipnz
	goto	l5084
	goto	l5084
	opt asmopt_on

	line	380
;main.c: 380: _KPRESS: if (!fKeyPress)
	
l5084:	
	btfsc	(_fKeyPress/8),(_fKeyPress)&7
	goto	u1151
	goto	u1150
u1151:
	goto	l7500
u1150:
	line	381
	
l7498:	
;main.c: 381: bKeyHTCnt = 70;
	movlw	(046h)
	movwf	(_bKeyHTCnt)
	line	382
	
l7500:	
	bsf	(_fKeyPress/8),(_fKeyPress)&7
	line	385
	
l5093:	
	return
	opt stack 0
GLOBAL	__end_of_pKeyProc
	__end_of_pKeyProc:
;; =============== function _pKeyProc ends ============

	signat	_pKeyProc,88
	global	_pInitMCU
psect	text446,local,class=CODE,delta=2
global __ptext446
__ptext446:

;; *************** function _pInitMCU *****************
;; Defined at:
;;		line 24 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    4
;; This function calls:
;;		_pInitAD
;;		_pInitPORT
;;		_pInitT0
;;		_pInitT1
;;		_pInitT2
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text446
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	24
	global	__size_of_pInitMCU
	__size_of_pInitMCU	equ	__end_of_pInitMCU-_pInitMCU
	
_pInitMCU:	
	opt	stack 3
; Regs used in _pInitMCU: [wreg+status,2+status,0+pclath+cstack]
	line	25
	
l7392:	
;InitMcu.c: 25: INTCON=0;
	clrf	(11)	;volatile
	line	26
;InitMcu.c: 26: PIE1=0;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(140)^080h	;volatile
	line	28
	
l7394:	
;InitMcu.c: 28: OPTION_REG = 0b00111111;
	movlw	(03Fh)
	movwf	(129)^080h	;volatile
	line	29
	
l7396:	
;InitMcu.c: 29: OSCCON = 0b01100001;
	movlw	(061h)
	movwf	(143)^080h	;volatile
	line	30
;InitMcu.c: 30: while(!HTS);
	
l3950:	
	btfss	(1146/8)^080h,(1146)&7
	goto	u951
	goto	u950
u951:
	goto	l3950
u950:
	line	32
	
l7398:	
;InitMcu.c: 32: pInitAD();
	fcall	_pInitAD
	line	33
	
l7400:	
;InitMcu.c: 33: pInitPORT();
	fcall	_pInitPORT
	line	34
	
l7402:	
;InitMcu.c: 34: pInitT0();
	fcall	_pInitT0
	line	35
	
l7404:	
;InitMcu.c: 35: pInitT1();
	fcall	_pInitT1
	line	36
	
l7406:	
;InitMcu.c: 36: pInitT2();
	fcall	_pInitT2
	line	43
	
l7408:	
;InitMcu.c: 43: PEIE = 1;
	bsf	(94/8),(94)&7
	line	44
	
l3953:	
	return
	opt stack 0
GLOBAL	__end_of_pInitMCU
	__end_of_pInitMCU:
;; =============== function _pInitMCU ends ============

	signat	_pInitMCU,88
	global	___lldiv
psect	text447,local,class=CODE,delta=2
global __ptext447
__ptext447:

;; *************** function ___lldiv *****************
;; Defined at:
;;		line 5 in file "C:\Program Files\HI-TECH Software\PICC\9.83\sources\lldiv.c"
;; Parameters:    Size  Location     Type
;;  divisor         4    0[BANK0 ] unsigned long 
;;  dividend        4    4[BANK0 ] unsigned long 
;; Auto vars:     Size  Location     Type
;;  quotient        4    8[BANK0 ] unsigned long 
;;  counter         1   12[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  4    0[BANK0 ] unsigned long 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       8       0       0
;;      Locals:         0       5       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0      13       0       0
;;Total ram usage:       13 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pDispProc
;;		_pConLiter
;; This function uses a non-reentrant model
;;
psect	text447
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\lldiv.c"
	line	5
	global	__size_of___lldiv
	__size_of___lldiv	equ	__end_of___lldiv-___lldiv
	
___lldiv:	
	opt	stack 3
; Regs used in ___lldiv: [wreg+status,2+status,0]
	line	9
	
l7366:	
	clrf	(___lldiv@quotient)
	clrf	(___lldiv@quotient+1)
	clrf	(___lldiv@quotient+2)
	clrf	(___lldiv@quotient+3)
	line	10
	
l7368:	
	movf	(___lldiv@divisor+3),w
	iorwf	(___lldiv@divisor+2),w
	iorwf	(___lldiv@divisor+1),w
	iorwf	(___lldiv@divisor),w
	skipnz
	goto	u911
	goto	u910
u911:
	goto	l7388
u910:
	line	11
	
l7370:	
	clrf	(___lldiv@counter)
	incf	(___lldiv@counter),f
	line	12
	goto	l7374
	line	13
	
l7372:	
	clrc
	rlf	(___lldiv@divisor),f
	rlf	(___lldiv@divisor+1),f
	rlf	(___lldiv@divisor+2),f
	rlf	(___lldiv@divisor+3),f
	line	14
	incf	(___lldiv@counter),f
	line	12
	
l7374:	
	btfss	(___lldiv@divisor+3),(31)&7
	goto	u921
	goto	u920
u921:
	goto	l7372
u920:
	line	17
	
l7376:	
	clrc
	rlf	(___lldiv@quotient),f
	rlf	(___lldiv@quotient+1),f
	rlf	(___lldiv@quotient+2),f
	rlf	(___lldiv@quotient+3),f
	line	18
	
l7378:	
	movf	(___lldiv@divisor+3),w
	subwf	(___lldiv@dividend+3),w
	skipz
	goto	u935
	movf	(___lldiv@divisor+2),w
	subwf	(___lldiv@dividend+2),w
	skipz
	goto	u935
	movf	(___lldiv@divisor+1),w
	subwf	(___lldiv@dividend+1),w
	skipz
	goto	u935
	movf	(___lldiv@divisor),w
	subwf	(___lldiv@dividend),w
u935:
	skipc
	goto	u931
	goto	u930
u931:
	goto	l7384
u930:
	line	19
	
l7380:	
	movf	(___lldiv@divisor),w
	subwf	(___lldiv@dividend),f
	movf	(___lldiv@divisor+1),w
	skipc
	incfsz	(___lldiv@divisor+1),w
	subwf	(___lldiv@dividend+1),f
	movf	(___lldiv@divisor+2),w
	skipc
	incfsz	(___lldiv@divisor+2),w
	subwf	(___lldiv@dividend+2),f
	movf	(___lldiv@divisor+3),w
	skipc
	incfsz	(___lldiv@divisor+3),w
	subwf	(___lldiv@dividend+3),f
	line	20
	
l7382:	
	bsf	(___lldiv@quotient)+(0/8),(0)&7
	line	22
	
l7384:	
	clrc
	rrf	(___lldiv@divisor+3),f
	rrf	(___lldiv@divisor+2),f
	rrf	(___lldiv@divisor+1),f
	rrf	(___lldiv@divisor),f
	line	23
	
l7386:	
	decfsz	(___lldiv@counter),f
	goto	u941
	goto	u940
u941:
	goto	l7376
u940:
	line	25
	
l7388:	
	movf	(___lldiv@quotient+3),w
	movwf	(?___lldiv+3)
	movf	(___lldiv@quotient+2),w
	movwf	(?___lldiv+2)
	movf	(___lldiv@quotient+1),w
	movwf	(?___lldiv+1)
	movf	(___lldiv@quotient),w
	movwf	(?___lldiv)

	line	26
	
l6279:	
	return
	opt stack 0
GLOBAL	__end_of___lldiv
	__end_of___lldiv:
;; =============== function ___lldiv ends ============

	signat	___lldiv,8316
	global	___llmod
psect	text448,local,class=CODE,delta=2
global __ptext448
__ptext448:

;; *************** function ___llmod *****************
;; Defined at:
;;		line 5 in file "C:\Program Files\HI-TECH Software\PICC\9.83\sources\llmod.c"
;; Parameters:    Size  Location     Type
;;  divisor         4    0[BANK0 ] unsigned long 
;;  dividend        4    4[BANK0 ] unsigned long 
;; Auto vars:     Size  Location     Type
;;  counter         1    8[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;                  4    0[BANK0 ] unsigned long 
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       8       0       0
;;      Locals:         0       1       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       9       0       0
;;Total ram usage:        9 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pDispProc
;;		_pConLiter
;; This function uses a non-reentrant model
;;
psect	text448
	file	"C:\Program Files\HI-TECH Software\PICC\9.83\sources\llmod.c"
	line	5
	global	__size_of___llmod
	__size_of___llmod	equ	__end_of___llmod-___llmod
	
___llmod:	
	opt	stack 3
; Regs used in ___llmod: [wreg+status,2+status,0]
	line	8
	
l7346:	
	movf	(___llmod@divisor+3),w
	iorwf	(___llmod@divisor+2),w
	iorwf	(___llmod@divisor+1),w
	iorwf	(___llmod@divisor),w
	skipnz
	goto	u871
	goto	u870
u871:
	goto	l7362
u870:
	line	9
	
l7348:	
	clrf	(___llmod@counter)
	incf	(___llmod@counter),f
	line	10
	goto	l7352
	line	11
	
l7350:	
	clrc
	rlf	(___llmod@divisor),f
	rlf	(___llmod@divisor+1),f
	rlf	(___llmod@divisor+2),f
	rlf	(___llmod@divisor+3),f
	line	12
	incf	(___llmod@counter),f
	line	10
	
l7352:	
	btfss	(___llmod@divisor+3),(31)&7
	goto	u881
	goto	u880
u881:
	goto	l7350
u880:
	line	15
	
l7354:	
	movf	(___llmod@divisor+3),w
	subwf	(___llmod@dividend+3),w
	skipz
	goto	u895
	movf	(___llmod@divisor+2),w
	subwf	(___llmod@dividend+2),w
	skipz
	goto	u895
	movf	(___llmod@divisor+1),w
	subwf	(___llmod@dividend+1),w
	skipz
	goto	u895
	movf	(___llmod@divisor),w
	subwf	(___llmod@dividend),w
u895:
	skipc
	goto	u891
	goto	u890
u891:
	goto	l7358
u890:
	line	16
	
l7356:	
	movf	(___llmod@divisor),w
	subwf	(___llmod@dividend),f
	movf	(___llmod@divisor+1),w
	skipc
	incfsz	(___llmod@divisor+1),w
	subwf	(___llmod@dividend+1),f
	movf	(___llmod@divisor+2),w
	skipc
	incfsz	(___llmod@divisor+2),w
	subwf	(___llmod@dividend+2),f
	movf	(___llmod@divisor+3),w
	skipc
	incfsz	(___llmod@divisor+3),w
	subwf	(___llmod@dividend+3),f
	line	17
	
l7358:	
	clrc
	rrf	(___llmod@divisor+3),f
	rrf	(___llmod@divisor+2),f
	rrf	(___llmod@divisor+1),f
	rrf	(___llmod@divisor),f
	line	18
	
l7360:	
	decfsz	(___llmod@counter),f
	goto	u901
	goto	u900
u901:
	goto	l7354
u900:
	line	20
	
l7362:	
	movf	(___llmod@dividend+3),w
	movwf	(?___llmod+3)
	movf	(___llmod@dividend+2),w
	movwf	(?___llmod+2)
	movf	(___llmod@dividend+1),w
	movwf	(?___llmod+1)
	movf	(___llmod@dividend),w
	movwf	(?___llmod)

	line	21
	
l6260:	
	return
	opt stack 0
GLOBAL	__end_of___llmod
	__end_of___llmod:
;; =============== function ___llmod ends ============

	signat	___llmod,8316
	global	_pRunStep
psect	text449,local,class=CODE,delta=2
global __ptext449
__ptext449:

;; *************** function _pRunStep *****************
;; Defined at:
;;		line 596 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;  step            1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  step            1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       1       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       1       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pDispProc
;; This function uses a non-reentrant model
;;
psect	text449
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	596
	global	__size_of_pRunStep
	__size_of_pRunStep	equ	__end_of_pRunStep-_pRunStep
	
_pRunStep:	
	opt	stack 3
; Regs used in _pRunStep: [wreg+status,2]
;pRunStep@step stored from wreg
	movwf	(pRunStep@step)
	line	597
	
l7338:	
;main.c: 597: bRunCnt=0;
	clrf	(_bRunCnt)
	line	598
	
l7340:	
;main.c: 598: bRunStep=step;
	movf	(pRunStep@step),w
	movwf	(_bRunStep)
	line	599
	
l7342:	
;main.c: 599: {bFlashCnt=3; fFlash=1;};
	movlw	(03h)
	movwf	(_bFlashCnt)
	
l7344:	
	bsf	(_fFlash/8),(_fFlash)&7
	line	600
	
l5144:	
	return
	opt stack 0
GLOBAL	__end_of_pRunStep
	__end_of_pRunStep:
;; =============== function _pRunStep ends ============

	signat	_pRunStep,4216
	global	_pTuneMin
psect	text450,local,class=CODE,delta=2
global __ptext450
__ptext450:

;; *************** function _pTuneMin *****************
;; Defined at:
;;		line 410 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pKeyProc
;; This function uses a non-reentrant model
;;
psect	text450
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	410
	global	__size_of_pTuneMin
	__size_of_pTuneMin	equ	__end_of_pTuneMin-_pTuneMin
	
_pTuneMin:	
	opt	stack 3
; Regs used in _pTuneMin: [wreg+status,2+status,0]
	line	411
	
l7322:	
;main.c: 411: if (bSetHour==24)
	movf	(_bSetHour),w
	xorlw	018h
	skipz
	goto	u841
	goto	u840
u841:
	goto	l7326
u840:
	line	412
	
l7324:	
;main.c: 412: bSetTmp=0;
	clrf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)
	goto	l7332
	line	415
	
l7326:	
;main.c: 413: else
;main.c: 414: {
;main.c: 415: bSetTmp+=10;
	movlw	0Ah
	addwf	(_bSetTmp),f
	movlw	1
	skipnc
	addwf	(_bSetTmp+1),f
	skipnc
	addwf	(_bSetTmp+2),f
	skipnc
	addwf	(_bSetTmp+3),f
	line	417
;main.c: 417: if (bSetTmp>50)
	movlw	0
	subwf	(_bSetTmp+3),w
	skipz
	goto	u855
	movlw	0
	subwf	(_bSetTmp+2),w
	skipz
	goto	u855
	movlw	0
	subwf	(_bSetTmp+1),w
	skipz
	goto	u855
	movlw	033h
	subwf	(_bSetTmp),w
u855:
	skipc
	goto	u851
	goto	u850
u851:
	goto	l7332
u850:
	line	419
	
l7328:	
;main.c: 418: {
;main.c: 419: if (bSetHour == 0)
	movf	(_bSetHour),f
	skipz
	goto	u861
	goto	u860
u861:
	goto	l7324
u860:
	line	420
	
l7330:	
;main.c: 420: bSetTmp = 10;
	movlw	0Ah
	movwf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)

	line	425
	
l7332:	
;main.c: 423: }
;main.c: 424: }
;main.c: 425: {bFlashCnt=7; fFlash=1;};
	movlw	(07h)
	movwf	(_bFlashCnt)
	
l7334:	
	bsf	(_fFlash/8),(_fFlash)&7
	line	426
	
l7336:	
;main.c: 426: bRunCnt=0;
	clrf	(_bRunCnt)
	line	427
	
l5108:	
	return
	opt stack 0
GLOBAL	__end_of_pTuneMin
	__end_of_pTuneMin:
;; =============== function _pTuneMin ends ============

	signat	_pTuneMin,88
	global	_pTuneHour
psect	text451,local,class=CODE,delta=2
global __ptext451
__ptext451:

;; *************** function _pTuneHour *****************
;; Defined at:
;;		line 398 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pKeyProc
;; This function uses a non-reentrant model
;;
psect	text451
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	398
	global	__size_of_pTuneHour
	__size_of_pTuneHour	equ	__end_of_pTuneHour-_pTuneHour
	
_pTuneHour:	
	opt	stack 3
; Regs used in _pTuneHour: [wreg+status,2+status,0]
	line	399
	
l7310:	
;main.c: 399: bSetTmp++;
	incf	(_bSetTmp),f
	skipnz
	incf	(_bSetTmp+1),f
	skipnz
	incf	(_bSetTmp+2),f
	skipnz
	incf	(_bSetTmp+3),f
	line	400
	
l7312:	
;main.c: 400: if (bSetTmp > 24)
	movlw	0
	subwf	(_bSetTmp+3),w
	skipz
	goto	u835
	movlw	0
	subwf	(_bSetTmp+2),w
	skipz
	goto	u835
	movlw	0
	subwf	(_bSetTmp+1),w
	skipz
	goto	u835
	movlw	019h
	subwf	(_bSetTmp),w
u835:
	skipc
	goto	u831
	goto	u830
u831:
	goto	l7316
u830:
	line	401
	
l7314:	
;main.c: 401: bSetTmp=0;
	clrf	(_bSetTmp)
	clrf	(_bSetTmp+1)
	clrf	(_bSetTmp+2)
	clrf	(_bSetTmp+3)
	line	403
	
l7316:	
;main.c: 403: {bFlashCnt=7; fFlash=1;};
	movlw	(07h)
	movwf	(_bFlashCnt)
	
l7318:	
	bsf	(_fFlash/8),(_fFlash)&7
	line	404
	
l7320:	
;main.c: 404: bRunCnt=0;
	clrf	(_bRunCnt)
	line	405
	
l5100:	
	return
	opt stack 0
GLOBAL	__end_of_pTuneHour
	__end_of_pTuneHour:
;; =============== function _pTuneHour ends ============

	signat	_pTuneHour,88
	global	_pSwitchMode
psect	text452,local,class=CODE,delta=2
global __ptext452
__ptext452:

;; *************** function _pSwitchMode *****************
;; Defined at:
;;		line 389 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;  mod             1    wreg     unsigned char 
;; Auto vars:     Size  Location     Type
;;  mod             1    0[BANK0 ] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       1       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       1       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pKeyProc
;;		_pDispProc
;; This function uses a non-reentrant model
;;
psect	text452
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	389
	global	__size_of_pSwitchMode
	__size_of_pSwitchMode	equ	__end_of_pSwitchMode-_pSwitchMode
	
_pSwitchMode:	
	opt	stack 3
; Regs used in _pSwitchMode: [wreg+status,2]
;pSwitchMode@mod stored from wreg
	movwf	(pSwitchMode@mod)
	line	390
	
l7302:	
;main.c: 390: bRunMode=mod;
	movf	(pSwitchMode@mod),w
	movwf	(_bRunMode)
	line	391
	
l7304:	
;main.c: 391: bRunStep=0;
	clrf	(_bRunStep)
	line	392
	
l7306:	
;main.c: 392: bRunCnt=0;
	clrf	(_bRunCnt)
	line	393
;main.c: 393: {bFlashCnt=3; fFlash=1;};
	movlw	(03h)
	movwf	(_bFlashCnt)
	
l7308:	
	bsf	(_fFlash/8),(_fFlash)&7
	line	394
	
l5096:	
	return
	opt stack 0
GLOBAL	__end_of_pSwitchMode
	__end_of_pSwitchMode:
;; =============== function _pSwitchMode ends ============

	signat	_pSwitchMode,4216
	global	_pWashFlow
psect	text453,local,class=CODE,delta=2
global __ptext453
__ptext453:

;; *************** function _pWashFlow *****************
;; Defined at:
;;		line 645 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text453
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	645
	global	__size_of_pWashFlow
	__size_of_pWashFlow	equ	__end_of_pWashFlow-_pWashFlow
	
_pWashFlow:	
	opt	stack 4
; Regs used in _pWashFlow: [wreg-fsr0h+status,2+status,0]
	line	646
	
l7280:	
;main.c: 646: if (fRunWash)
	btfss	(_fRunWash/8),(_fRunWash)&7
	goto	u801
	goto	u800
u801:
	goto	l5154
u800:
	goto	l7298
	line	651
;main.c: 649: {
;main.c: 651: case 0:
	
l5156:	
	line	652
;main.c: 652: RA2=1;
	bsf	(42/8),(42)&7
	line	653
;main.c: 653: RA1=0;
	bcf	(41/8),(41)&7
	line	655
	
l7284:	
;main.c: 655: if (++bRunWashT >= 100)
	movlw	(064h)
	incf	(_bRunWashT),f
	subwf	((_bRunWashT)),w
	skipc
	goto	u811
	goto	u810
u811:
	goto	l5162
u810:
	line	657
	
l7286:	
;main.c: 656: {
;main.c: 657: bRunWashT=0;
	clrf	(_bRunWashT)
	line	658
	
l7288:	
;main.c: 658: bRunWashStep++;
	incf	(_bRunWashStep),f
	goto	l5162
	line	663
;main.c: 663: case 1:
	
l5159:	
	line	664
;main.c: 664: RA2=1;
	bsf	(42/8),(42)&7
	line	665
;main.c: 665: RA1=1;
	bsf	(41/8),(41)&7
	line	667
	
l7290:	
;main.c: 667: if (++bRunWashT >= 100)
	movlw	(064h)
	incf	(_bRunWashT),f
	subwf	((_bRunWashT)),w
	skipc
	goto	u821
	goto	u820
u821:
	goto	l5162
u820:
	line	669
	
l7292:	
;main.c: 668: {
;main.c: 669: bRunWashT=0;
	clrf	(_bRunWashT)
	line	670
;main.c: 670: bRunWashStep=0;
	clrf	(_bRunWashStep)
	line	671
	
l7294:	
;main.c: 671: fRunWash=0;
	bcf	(_fRunWash/8),(_fRunWash)&7
	goto	l5162
	line	648
	
l7298:	
	movf	(_bRunWashStep),w
	; Switch size 1, requested type "space"
; Number of cases is 2, Range of values is 0 to 1
; switch strategies available:
; Name         Instructions Cycles
; simple_byte            7     4 (average)
; direct_byte           11     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             6     6 (fixed)
; spacedrange           10     9 (fixed)
; locatedrange           2     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	l5156
	xorlw	1^0	; case 1
	skipnz
	goto	l5159
	goto	l5162
	opt asmopt_on

	line	676
	
l5154:	
	line	678
;main.c: 676: else
;main.c: 677: {
;main.c: 678: RA2=0;
	bcf	(42/8),(42)&7
	line	679
;main.c: 679: RA1=0;
	bcf	(41/8),(41)&7
	line	680
	
l7300:	
;main.c: 680: bRunWashStep=0;
	clrf	(_bRunWashStep)
	line	681
;main.c: 681: bRunWashT=0;
	clrf	(_bRunWashT)
	line	683
	
l5162:	
	return
	opt stack 0
GLOBAL	__end_of_pWashFlow
	__end_of_pWashFlow:
;; =============== function _pWashFlow ends ============

	signat	_pWashFlow,88
	global	_pReadEE
psect	text454,local,class=CODE,delta=2
global __ptext454
__ptext454:

;; *************** function _pReadEE *****************
;; Defined at:
;;		line 729 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		None
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/20
;;		Unchanged: FFFFFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text454
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	line	729
	global	__size_of_pReadEE
	__size_of_pReadEE	equ	__end_of_pReadEE-_pReadEE
	
_pReadEE:	
	opt	stack 4
; Regs used in _pReadEE: []
	line	733
	
l5165:	
	return
	opt stack 0
GLOBAL	__end_of_pReadEE
	__end_of_pReadEE:
;; =============== function _pReadEE ends ============

	signat	_pReadEE,88
	global	_pInitT2
psect	text455,local,class=CODE,delta=2
global __ptext455
__ptext455:

;; *************** function _pInitT2 *****************
;; Defined at:
;;		line 111 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pInitMCU
;; This function uses a non-reentrant model
;;
psect	text455
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	111
	global	__size_of_pInitT2
	__size_of_pInitT2	equ	__end_of_pInitT2-_pInitT2
	
_pInitT2:	
	opt	stack 3
; Regs used in _pInitT2: [wreg]
	line	112
	
l7252:	
;InitMcu.c: 112: PR2 = 125;
	movlw	(07Dh)
	movwf	(146)^080h	;volatile
	line	113
;InitMcu.c: 113: T2CON = 0b00000011;
	movlw	(03h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(18)	;volatile
	line	114
	
l7254:	
;InitMcu.c: 114: TMR2IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1121/8)^080h,(1121)&7
	line	115
	
l3968:	
	return
	opt stack 0
GLOBAL	__end_of_pInitT2
	__end_of_pInitT2:
;; =============== function _pInitT2 ends ============

	signat	_pInitT2,88
	global	_pInitT1
psect	text456,local,class=CODE,delta=2
global __ptext456
__ptext456:

;; *************** function _pInitT1 *****************
;; Defined at:
;;		line 100 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pInitMCU
;; This function uses a non-reentrant model
;;
psect	text456
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	100
	global	__size_of_pInitT1
	__size_of_pInitT1	equ	__end_of_pInitT1-_pInitT1
	
_pInitT1:	
	opt	stack 3
; Regs used in _pInitT1: [wreg+status,2]
	line	101
	
l7244:	
;InitMcu.c: 101: T1CON = 0b00000000;
	clrf	(16)	;volatile
	line	102
	
l7246:	
;InitMcu.c: 102: TMR1L = 0x18;
	movlw	(018h)
	movwf	(14)	;volatile
	line	103
	
l7248:	
;InitMcu.c: 103: TMR1H = 0xFC;
	movlw	(0FCh)
	movwf	(15)	;volatile
	line	104
	
l7250:	
;InitMcu.c: 104: TMR1IE = 1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1120/8)^080h,(1120)&7
	line	105
	
l3965:	
	return
	opt stack 0
GLOBAL	__end_of_pInitT1
	__end_of_pInitT1:
;; =============== function _pInitT1 ends ============

	signat	_pInitT1,88
	global	_pInitT0
psect	text457,local,class=CODE,delta=2
global __ptext457
__ptext457:

;; *************** function _pInitT0 *****************
;; Defined at:
;;		line 86 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/0
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pInitMCU
;; This function uses a non-reentrant model
;;
psect	text457
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	86
	global	__size_of_pInitT0
	__size_of_pInitT0	equ	__end_of_pInitT0-_pInitT0
	
_pInitT0:	
	opt	stack 3
; Regs used in _pInitT0: [wreg]
	line	90
	
l7238:	
;InitMcu.c: 90: TMR0 = 246;
	movlw	(0F6h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(1)	;volatile
	line	91
	
l7240:	
;InitMcu.c: 91: T0IE = 0;
	bcf	(93/8),(93)&7
	line	92
	
l7242:	
;InitMcu.c: 92: T0IF = 0;
	bcf	(90/8),(90)&7
	line	93
	
l3962:	
	return
	opt stack 0
GLOBAL	__end_of_pInitT0
	__end_of_pInitT0:
;; =============== function _pInitT0 ends ============

	signat	_pInitT0,88
	global	_pInitPORT
psect	text458,local,class=CODE,delta=2
global __ptext458
__ptext458:

;; *************** function _pInitPORT *****************
;; Defined at:
;;		line 60 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, status,2
;; Tracked objects:
;;		On entry : 17F/0
;;		On exit  : 17F/20
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pInitMCU
;; This function uses a non-reentrant model
;;
psect	text458
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	60
	global	__size_of_pInitPORT
	__size_of_pInitPORT	equ	__end_of_pInitPORT-_pInitPORT
	
_pInitPORT:	
	opt	stack 3
; Regs used in _pInitPORT: [wreg+status,2]
	line	62
	
l7224:	
;InitMcu.c: 62: ANSEL = 0b00000000;
	bsf	status, 5	;RP0=1, select bank3
	bsf	status, 6	;RP1=1, select bank3
	clrf	(392)^0180h	;volatile
	line	63
;InitMcu.c: 63: ANSELH = 0b00000000;
	clrf	(393)^0180h	;volatile
	line	66
	
l7226:	
;InitMcu.c: 66: PORTA = 0b00010001;
	movlw	(011h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(5)	;volatile
	line	67
	
l7228:	
;InitMcu.c: 67: TRISA = 0b00010000;
	movlw	(010h)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(133)^080h	;volatile
	line	70
;InitMcu.c: 70: IOCB = 0b00000000;
	clrf	(150)^080h	;volatile
	line	71
	
l7230:	
;InitMcu.c: 71: PORTB = 0b11010111;
	movlw	(0D7h)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(6)	;volatile
	line	72
	
l7232:	
;InitMcu.c: 72: WPUB = 0b11111111;
	movlw	(0FFh)
	bsf	status, 5	;RP0=1, select bank1
	movwf	(149)^080h	;volatile
	line	73
	
l7234:	
;InitMcu.c: 73: TRISB = 0b00010000;
	movlw	(010h)
	movwf	(134)^080h	;volatile
	line	76
	
l7236:	
;InitMcu.c: 76: PORTC = 0b11111111;
	movlw	(0FFh)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(7)	;volatile
	line	77
;InitMcu.c: 77: TRISC = 0b00000000;
	bsf	status, 5	;RP0=1, select bank1
	clrf	(135)^080h	;volatile
	line	78
	
l3959:	
	return
	opt stack 0
GLOBAL	__end_of_pInitPORT
	__end_of_pInitPORT:
;; =============== function _pInitPORT ends ============

	signat	_pInitPORT,88
	global	_pInitAD
psect	text459,local,class=CODE,delta=2
global __ptext459
__ptext459:

;; *************** function _pInitAD *****************
;; Defined at:
;;		line 51 in file "D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		status,2
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/0
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pInitMCU
;; This function uses a non-reentrant model
;;
psect	text459
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\InitMcu.c"
	line	51
	global	__size_of_pInitAD
	__size_of_pInitAD	equ	__end_of_pInitAD-_pInitAD
	
_pInitAD:	
	opt	stack 3
; Regs used in _pInitAD: [status,2]
	line	52
	
l7222:	
;InitMcu.c: 52: ADCON1 = 0b00000000;
	clrf	(159)^080h	;volatile
	line	53
;InitMcu.c: 53: ADCON0 = 0b00000000;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(31)	;volatile
	line	54
	
l3956:	
	return
	opt stack 0
GLOBAL	__end_of_pInitAD
	__end_of_pInitAD:
;; =============== function _pInitAD ends ============

	signat	_pInitAD,88
	global	_pClrDisp
psect	text460,local,class=CODE,delta=2
global __ptext460
__ptext460:

;; *************** function _pClrDisp *****************
;; Defined at:
;;		line 105 in file "D:\MyWorks\CYD670(C16F883)\CYD670\drv_disp.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg
;; Tracked objects:
;;		On entry : 17F/20
;;		On exit  : 17F/0
;;		Unchanged: FFE80/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    3
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_main
;; This function uses a non-reentrant model
;;
psect	text460
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_disp.c"
	line	105
	global	__size_of_pClrDisp
	__size_of_pClrDisp	equ	__end_of_pClrDisp-_pClrDisp
	
_pClrDisp:	
	opt	stack 4
; Regs used in _pClrDisp: [wreg]
	line	106
	
l7176:	
;drv_disp.c: 106: bSeg0 = 10;
	movlw	(0Ah)
	bcf	status, 5	;RP0=0, select bank0
	movwf	(_bSeg0)
	line	107
;drv_disp.c: 107: bSeg1 = 10;
	movlw	(0Ah)
	movwf	(_bSeg1)
	line	108
;drv_disp.c: 108: bSeg2 = 10;
	movlw	(0Ah)
	movwf	(_bSeg2)
	line	109
;drv_disp.c: 109: bLed.byte = 0xff;
	movlw	(0FFh)
	movwf	(_bLed)
	line	110
	
l992:	
	return
	opt stack 0
GLOBAL	__end_of_pClrDisp
	__end_of_pClrDisp:
;; =============== function _pClrDisp ends ============

	signat	_pClrDisp,88
	global	_isr
psect	text461,local,class=CODE,delta=2
global __ptext461
__ptext461:

;; *************** function _isr *****************
;; Defined at:
;;		line 110 in file "D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;		None
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 0/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          3       0       0       0
;;      Totals:         3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    2
;; This function calls:
;;		_pScanKey
;;		_pScanDisp
;; This function is called by:
;;		Interrupt level 1
;; This function uses a non-reentrant model
;;
psect	text461
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\main.c"
	global	__size_of_isr
	__size_of_isr	equ	__end_of_isr-_isr
	
_isr:	
	opt	stack 2
; Regs used in _isr: [wreg-fsr0h+status,2+status,0+pclath+cstack]
psect	intentry,class=CODE,delta=2
global __pintentry
__pintentry:
global interrupt_function
interrupt_function:
	global saved_w
	saved_w	set	btemp+0
	movwf	saved_w
	swapf	status,w
	movwf	(??_isr+0)
	movf	fsr0,w
	movwf	(??_isr+1)
	movf	pclath,w
	movwf	(??_isr+2)
	ljmp	_isr
psect	text461
	line	112
	
i1l7256:	
;main.c: 112: if (T0IF)
	btfss	(90/8),(90)&7
	goto	u76_21
	goto	u76_20
u76_21:
	goto	i1l7268
u76_20:
	line	114
	
i1l7258:	
;main.c: 113: {
;main.c: 114: T0IF=0;
	bcf	(90/8),(90)&7
	line	115
	
i1l7260:	
;main.c: 115: TMR0=246;
	movlw	(0F6h)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	movwf	(1)	;volatile
	line	117
;main.c: 117: RB7 = !RB7;
	movlw	1<<((55)&7)
	xorwf	((55)/8),f
	line	120
	
i1l7262:	
;main.c: 120: if (++bPulseCnt >= (330/10))
	movlw	(021h)
	incf	(_bPulseCnt),f
	subwf	((_bPulseCnt)),w
	skipc
	goto	u77_21
	goto	u77_20
u77_21:
	goto	i1l7268
u77_20:
	line	122
	
i1l7264:	
;main.c: 121: {
;main.c: 122: bPulseCnt=0;
	clrf	(_bPulseCnt)
	line	123
	
i1l7266:	
;main.c: 123: TotalLiter++;
	incf	(_TotalLiter),f
	skipnz
	incf	(_TotalLiter+1),f
	skipnz
	incf	(_TotalLiter+2),f
	skipnz
	incf	(_TotalLiter+3),f
	line	141
	
i1l7268:	
;main.c: 124: }
;main.c: 125: }
;main.c: 141: if (TMR2IF)
	bcf	status, 5	;RP0=0, select bank0
	bcf	status, 6	;RP1=0, select bank0
	btfss	(97/8),(97)&7
	goto	u78_21
	goto	u78_20
u78_21:
	goto	i1l5027
u78_20:
	line	143
	
i1l7270:	
;main.c: 142: {
;main.c: 143: TMR2IF=0;
	bcf	(97/8),(97)&7
	line	145
;main.c: 145: RB0=1;
	bsf	(48/8),(48)&7
	line	146
;main.c: 146: RB1=1;
	bsf	(49/8),(49)&7
	line	147
;main.c: 147: RB2=1;
	bsf	(50/8),(50)&7
	line	148
;main.c: 148: RA0=1;
	bsf	(40/8),(40)&7
	line	150
	
i1l7272:	
;main.c: 150: pScanKey();
	fcall	_pScanKey
	line	151
;main.c: 151: pScanDisp();
	fcall	_pScanDisp
	line	153
	
i1l7274:	
;main.c: 153: if (++b10ms>=5)
	movlw	(05h)
	incf	(_b10ms),f
	subwf	((_b10ms)),w
	skipc
	goto	u79_21
	goto	u79_20
u79_21:
	goto	i1l5027
u79_20:
	line	155
	
i1l7276:	
;main.c: 154: {
;main.c: 155: b10ms=0;
	clrf	(_b10ms)
	line	156
	
i1l7278:	
;main.c: 156: f10ms = 1;
	bsf	(_f10ms/8),(_f10ms)&7
	line	159
	
i1l5027:	
	movf	(??_isr+2),w
	movwf	pclath
	movf	(??_isr+1),w
	movwf	fsr0
	swapf	(??_isr+0)^0FFFFFF80h,w
	movwf	status
	swapf	saved_w,f
	swapf	saved_w,w
	retfie
	opt stack 0
GLOBAL	__end_of_isr
	__end_of_isr:
;; =============== function _isr ends ============

	signat	_isr,88
	global	_pScanKey
psect	text462,local,class=CODE,delta=2
global __ptext462
__ptext462:

;; *************** function _pScanKey *****************
;; Defined at:
;;		line 31 in file "D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  bKeyBuf         1    3[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0, pclath, cstack
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         1       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         1       0       0       0
;;Total ram usage:        1 bytes
;; Hardware stack levels used:    1
;; Hardware stack levels required when called:    1
;; This function calls:
;;		_pReadKey
;; This function is called by:
;;		_isr
;; This function uses a non-reentrant model
;;
psect	text462
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
	line	31
	global	__size_of_pScanKey
	__size_of_pScanKey	equ	__end_of_pScanKey-_pScanKey
	
_pScanKey:	
	opt	stack 2
; Regs used in _pScanKey: [wreg-fsr0h+status,2+status,0+pclath+cstack]
	line	34
	
i1l7178:	
;drv_key.c: 32: U8 bKeyBuf;
;drv_key.c: 34: bKeyBuf = pReadKey();
	fcall	_pReadKey
	movwf	(pScanKey@bKeyBuf)
	line	36
	
i1l7180:	
;drv_key.c: 36: if (bKeyOld != bKeyBuf)
	movf	(_bKeyOld),w
	xorwf	(pScanKey@bKeyBuf),w
	skipnz
	goto	u70_21
	goto	u70_20
u70_21:
	goto	i1l7186
u70_20:
	line	38
	
i1l7182:	
;drv_key.c: 37: {
;drv_key.c: 38: bKeyOld = bKeyBuf;
	movf	(pScanKey@bKeyBuf),w
	movwf	(_bKeyOld)
	line	39
	
i1l7184:	
;drv_key.c: 39: bKeyCnt = 0;
	bcf	status, 5	;RP0=0, select bank0
	clrf	(_bKeyCnt)
	line	40
;drv_key.c: 40: }
	goto	i1l1973
	line	43
	
i1l7186:	
;drv_key.c: 41: else
;drv_key.c: 42: {
;drv_key.c: 43: if (bKeyCnt == 15)
	bcf	status, 5	;RP0=0, select bank0
	movf	(_bKeyCnt),w
	xorlw	0Fh
	skipz
	goto	u71_21
	goto	u71_20
u71_21:
	goto	i1l7192
u71_20:
	line	45
	
i1l7188:	
;drv_key.c: 44: {
;drv_key.c: 45: bKeyCnt = 0;
	clrf	(_bKeyCnt)
	line	46
	
i1l7190:	
;drv_key.c: 46: bKeyData.byte = bKeyOld;
	movf	(_bKeyOld),w
	movwf	(_bKeyData)
	line	47
;drv_key.c: 47: }
	goto	i1l1973
	line	49
	
i1l7192:	
;drv_key.c: 48: else
;drv_key.c: 49: bKeyCnt++;
	incf	(_bKeyCnt),f
	line	51
	
i1l1973:	
	return
	opt stack 0
GLOBAL	__end_of_pScanKey
	__end_of_pScanKey:
;; =============== function _pScanKey ends ============

	signat	_pScanKey,88
	global	_pReadKey
psect	text463,local,class=CODE,delta=2
global __ptext463
__ptext463:

;; *************** function _pReadKey *****************
;; Defined at:
;;		line 57 in file "D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  i               1    2[COMMON] unsigned char 
;;  tmp             1    1[COMMON] unsigned char 
;;  buf             1    0[COMMON] unsigned char 
;; Return value:  Size  Location     Type
;;                  1    wreg      unsigned char 
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/20
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         3       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         3       0       0       0
;;Total ram usage:        3 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_pScanKey
;; This function uses a non-reentrant model
;;
psect	text463
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_key.c"
	line	57
	global	__size_of_pReadKey
	__size_of_pReadKey	equ	__end_of_pReadKey-_pReadKey
	
_pReadKey:	
	opt	stack 2
; Regs used in _pReadKey: [wreg-fsr0h+status,2+status,0]
	line	61
	
i1l7194:	
;drv_key.c: 58: U8 i,tmp,buf;
;drv_key.c: 61: RC0=1;
	bsf	(56/8),(56)&7
	line	62
;drv_key.c: 62: RC1=1;
	bsf	(57/8),(57)&7
	line	63
;drv_key.c: 63: RC2=1;
	bsf	(58/8),(58)&7
	line	65
;drv_key.c: 65: RB5=1;
	bsf	(53/8),(53)&7
	line	66
;drv_key.c: 66: TRISB5=1;
	bsf	status, 5	;RP0=1, select bank1
	bsf	(1077/8)^080h,(1077)&7
	line	69
;drv_key.c: 69: tmp=1;
	clrf	(pReadKey@tmp)
	incf	(pReadKey@tmp),f
	line	70
;drv_key.c: 70: while(tmp--);
	
i1l7196:	
	decf	(pReadKey@tmp),f
	movf	((pReadKey@tmp)),w
	xorlw	0FFh
	skipz
	goto	u72_21
	goto	u72_20
u72_21:
	goto	i1l7196
u72_20:
	line	72
	
i1l7198:	
;drv_key.c: 72: buf = 0xFF;
	movlw	(0FFh)
	movwf	(pReadKey@buf)
	line	73
	
i1l7200:	
;drv_key.c: 73: for (i=0;i<=2;i++)
	clrf	(pReadKey@i)
	goto	i1l7208
	line	77
;drv_key.c: 76: {
;drv_key.c: 77: case 0:
	
i1l1982:	
	line	78
;drv_key.c: 78: RC0=1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(56/8),(56)&7
	line	79
;drv_key.c: 79: RC1=1;
	bsf	(57/8),(57)&7
	line	80
;drv_key.c: 80: RC2=0;
	bcf	(58/8),(58)&7
	line	81
;drv_key.c: 81: break;
	goto	i1l1983
	line	83
;drv_key.c: 83: case 1:
	
i1l1984:	
	line	84
;drv_key.c: 84: RC2=1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(58/8),(58)&7
	line	85
;drv_key.c: 85: RC1=0;
	bcf	(57/8),(57)&7
	line	86
;drv_key.c: 86: RC0=1;
	bsf	(56/8),(56)&7
	line	87
;drv_key.c: 87: break;
	goto	i1l1983
	line	89
;drv_key.c: 89: case 2:
	
i1l1985:	
	line	90
;drv_key.c: 90: RC1=1;
	bcf	status, 5	;RP0=0, select bank0
	bsf	(57/8),(57)&7
	line	91
;drv_key.c: 91: RC0=0;
	bcf	(56/8),(56)&7
	line	92
;drv_key.c: 92: RC2=1;
	bsf	(58/8),(58)&7
	line	93
;drv_key.c: 93: break;
	goto	i1l1983
	line	75
	
i1l7208:	
	movf	(pReadKey@i),w
	; Switch size 1, requested type "space"
; Number of cases is 3, Range of values is 0 to 2
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           10     6 (average)
; direct_byte           13     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             7     6 (fixed)
; spacedrange           12     9 (fixed)
; locatedrange           3     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	i1l1982
	xorlw	1^0	; case 1
	skipnz
	goto	i1l1984
	xorlw	2^1	; case 2
	skipnz
	goto	i1l1985
	goto	i1l1983
	opt asmopt_on

	line	95
	
i1l1983:	
	line	98
;drv_key.c: 98: tmp=1;
	clrf	(pReadKey@tmp)
	incf	(pReadKey@tmp),f
	line	99
;drv_key.c: 99: while(tmp--);
	
i1l7210:	
	decf	(pReadKey@tmp),f
	movf	((pReadKey@tmp)),w
	xorlw	0FFh
	skipz
	goto	u73_21
	goto	u73_20
u73_21:
	goto	i1l7210
u73_20:
	
i1l1988:	
	line	101
;drv_key.c: 101: buf<<=1;
	clrc
	rlf	(pReadKey@buf),f
	line	103
;drv_key.c: 103: if (RB5)
	bcf	status, 5	;RP0=0, select bank0
	btfss	(53/8),(53)&7
	goto	u74_21
	goto	u74_20
u74_21:
	goto	i1l1989
u74_20:
	line	104
	
i1l7212:	
;drv_key.c: 104: buf |= 0x01;
	bsf	(pReadKey@buf)+(0/8),(0)&7
	goto	i1l7214
	line	105
	
i1l1989:	
	line	106
;drv_key.c: 105: else
;drv_key.c: 106: buf &= 0xFE;
	bcf	(pReadKey@buf)+(0/8),(0)&7
	line	73
	
i1l7214:	
	incf	(pReadKey@i),f
	
i1l7216:	
	movlw	(03h)
	subwf	(pReadKey@i),w
	skipc
	goto	u75_21
	goto	u75_20
u75_21:
	goto	i1l7208
u75_20:
	
i1l1980:	
	line	109
;drv_key.c: 107: }
;drv_key.c: 109: RB5=0;
	bcf	(53/8),(53)&7
	line	110
;drv_key.c: 110: TRISB5=0;
	bsf	status, 5	;RP0=1, select bank1
	bcf	(1077/8)^080h,(1077)&7
	line	112
	
i1l7218:	
;drv_key.c: 112: return buf;
	movf	(pReadKey@buf),w
	line	113
	
i1l1991:	
	return
	opt stack 0
GLOBAL	__end_of_pReadKey
	__end_of_pReadKey:
;; =============== function _pReadKey ends ============

	signat	_pReadKey,89
	global	_pScanDisp
psect	text464,local,class=CODE,delta=2
global __ptext464
__ptext464:

;; *************** function _pScanDisp *****************
;; Defined at:
;;		line 73 in file "D:\MyWorks\CYD670(C16F883)\CYD670\drv_disp.c"
;; Parameters:    Size  Location     Type
;;		None
;; Auto vars:     Size  Location     Type
;;  tmp             1    0        unsigned char 
;; Return value:  Size  Location     Type
;;		None               void
;; Registers used:
;;		wreg, fsr0l, fsr0h, status,2, status,0
;; Tracked objects:
;;		On entry : 60/0
;;		On exit  : 60/0
;;		Unchanged: FFF9F/0
;; Data sizes:     COMMON   BANK0   BANK1   BANK2
;;      Params:         0       0       0       0
;;      Locals:         0       0       0       0
;;      Temps:          0       0       0       0
;;      Totals:         0       0       0       0
;;Total ram usage:        0 bytes
;; Hardware stack levels used:    1
;; This function calls:
;;		Nothing
;; This function is called by:
;;		_isr
;; This function uses a non-reentrant model
;;
psect	text464
	file	"D:\MyWorks\CYD670(C16F883)\CYD670\drv_disp.c"
	line	73
	global	__size_of_pScanDisp
	__size_of_pScanDisp	equ	__end_of_pScanDisp-_pScanDisp
	
_pScanDisp:	
	opt	stack 3
; Regs used in _pScanDisp: [wreg-fsr0h+status,2+status,0]
	line	77
	
i1l7150:	
;drv_disp.c: 74: U8 tmp;
;drv_disp.c: 77: switch (bScanCnt)
	goto	i1l7170
	line	80
	
i1l7152:	
;drv_disp.c: 80: PORTC = bLed.byte;
	movf	(_bLed),w
	movwf	(7)	;volatile
	line	81
	
i1l7154:	
;drv_disp.c: 81: RB0 = 0;
	bcf	(48/8),(48)&7
	line	82
;drv_disp.c: 82: break;
	goto	i1l7172
	line	84
	
i1l7156:	
;drv_disp.c: 84: PORTC = bSeg1;
	movf	(_bSeg1),w
	movwf	(7)	;volatile
	line	85
	
i1l7158:	
;drv_disp.c: 85: RB1 = 0;
	bcf	(49/8),(49)&7
	line	86
;drv_disp.c: 86: break;
	goto	i1l7172
	line	88
	
i1l7160:	
;drv_disp.c: 88: PORTC = bSeg2;
	movf	(_bSeg2),w
	movwf	(7)	;volatile
	line	89
	
i1l7162:	
;drv_disp.c: 89: RB2 = 0;
	bcf	(50/8),(50)&7
	line	90
;drv_disp.c: 90: break;
	goto	i1l7172
	line	92
	
i1l7164:	
;drv_disp.c: 92: PORTC = bSeg0;
	movf	(_bSeg0),w
	movwf	(7)	;volatile
	line	93
	
i1l7166:	
;drv_disp.c: 93: RA0 = 0;
	bcf	(40/8),(40)&7
	line	94
;drv_disp.c: 94: break;
	goto	i1l7172
	line	77
	
i1l7170:	
	movf	(_bScanCnt),w
	; Switch size 1, requested type "space"
; Number of cases is 4, Range of values is 0 to 3
; switch strategies available:
; Name         Instructions Cycles
; simple_byte           13     7 (average)
; direct_byte           15     7 (fixed)
; jumptable            260     6 (fixed)
; rangetable             8     6 (fixed)
; spacedrange           14     9 (fixed)
; locatedrange           4     3 (fixed)
;	Chosen strategy is simple_byte

	opt asmopt_off
	xorlw	0^0	; case 0
	skipnz
	goto	i1l7152
	xorlw	1^0	; case 1
	skipnz
	goto	i1l7156
	xorlw	2^1	; case 2
	skipnz
	goto	i1l7160
	xorlw	3^2	; case 3
	skipnz
	goto	i1l7164
	goto	i1l7172
	opt asmopt_on

	line	97
	
i1l7172:	
;drv_disp.c: 97: if (++bScanCnt > 3)
	movlw	(04h)
	incf	(_bScanCnt),f
	subwf	((_bScanCnt)),w
	skipc
	goto	u69_21
	goto	u69_20
u69_21:
	goto	i1l989
u69_20:
	line	98
	
i1l7174:	
;drv_disp.c: 98: bScanCnt = 0;
	clrf	(_bScanCnt)
	line	99
	
i1l989:	
	return
	opt stack 0
GLOBAL	__end_of_pScanDisp
	__end_of_pScanDisp:
;; =============== function _pScanDisp ends ============

	signat	_pScanDisp,88
psect	text465,local,class=CODE,delta=2
global __ptext465
__ptext465:
	global	btemp
	btemp set 07Eh

	DABS	1,126,2	;btemp
	global	wtemp0
	wtemp0 set btemp
	end
