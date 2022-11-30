FNAME "basplyr.bin"
CPU Z80
;assemble with TNIASM
ORG $0100				;Z80 origin but actual address uses OFFSET
OFFSET:		EQU		27675	;27936-100h-5 program residing in memory at 27936
SNDPRT:		EQU		0FFh	;SOUND PORT
OFF:		EQU		0FFh	;SOUND OFF DATA
HEADER:
	DB	01h,00h,02h
BLOAD:
	DW	START+OFFSET
START:
	JR	SNDTBM		;position table
CLAIM:
	DB	'TVG90'		;identifier
SNDLOC:
	DS	2		;reserve 2 bytes for sound location poke
SNDLEN:
	DS	2		;reserve 2 bytes for sound length poke
OPRAT:
	DS	1		;reserve 1 byte for output rate
SNDTBM:
	PUSH	AF
	PUSH	BC
	PUSH	DE
	PUSH	HL
;moves sound table to a location in memory that starts excatly at a
;page boundary. this allows faster access to data.
	LD	DE,SNDTBO+OFFSET
	LD	HL,SNDTBL+OFFSET
	LD	BC,0100h		;dont foget for values of FFh
	LD	E,0			;even page
	LD	(SNDTBV+OFFSET),DE	;reference for later use
	LDIR
;sound table in place, now install output rate
	LD	A,(OPRAT+OFFSET)
	LD	(SPKRAT+OFFSET),A
;now setup start and end vectors
PLBSND:
;play sound block parms
	CALL	INITFQ+OFFSET		;freq init
	CALL	NOSND+OFFSET		;turn off any garbage
	LD	HL,(SNDTBV+OFFSET)	;where sndtbl gets loaded
	LD	DE,(SNDLOC+OFFSET)	;SNAG location
	LD	BC,(SNDLEN+OFFSET)	;snag length
;
PLYSPK:
;parameters set, play the tune
	LD	A,(DE)			;stored sound
	CALL	OPSND+OFFSET		;send it out
	INC	DE
	DEC	BC
	LD	A,B			;sound length inspection
	OR	C
	JR	NZ,PLYSPK
;
	CALL	NOSND+OFFSET		;enough noise already
;return to basic now.........
	POP	HL
	POP	DE
	POP	BC
	POP	AF
	RET				;back to basic language now.
NOSND:
	LD	HL,(SNDTBV+OFFSET)	;for some reason it needs to be restored
	LD	A,OFF			;turn off all three voices
	OUT	(SNDPRT),A		;turn off noise too
	CALL	OPSND+OFFSET
	RET
INITFQ:
	LD	E,0
	LD	BC,0381h
INILOO:
	LD	A,C
	OUT	(SNDPRT),A
	ADD	A,20h
	LD	C,A
	LD	A,E
	OUT	(SNDPRT),A
	DJNZ	INILOO
ININOI:
	LD	A,229
	OUT	(SNDPRT),A
	RET
;
OPSND:
;outputs sound byte per table values
	LD	L,A			;offset in to table
	LD	A,(HL)			;1st volume level
	OUT	(SNDPRT),A		;1st o/p
;remaining channels are encoded into tbale pointed to by HL
	INC	L
	LD	A,(HL)
	OUT	(SNDPRT),A
	INC	L			;next tbale entry
	LD	A,(HL)
	OUT	(SNDPRT),A
;
	PUSH	BC
SPKINS:
	DB	06h
SPKRAT:
	DS	1			;output rate
OPLOO:
	DJNZ	OPLOO
	POP	BC
	RET
SNDTBV:
	DW	0000
;
SNDPAD:
	DS	100h			;must use for proper padding
;
SNDTBO:
	DS	100h			;must reserve max of 100h here
;
SNDTBL:
;Use this tbale to arrive at appropriate data for sound voices
;therefore use 9x bx and dx
SOO:
	DB	0BFh,0DFh,09Fh,0BFh,0DFh
	DB	09Fh,0BFh,0DFh,09Fh,0BFh
	DB	0DFh,09Fh,0BFh,0DFh,0DFh	;cannot sync data at ends
	DB	09Fh
S0:	DB	0B0h,0D0h,090h,0B0h,0D0h
S1:	DB	090h,0B0h,0D1h,090h,0B0h
S2:	DB	0D1h,090h,0B1h,0D1h,090h
S3:	DB	0B1h,0D1h,091h,0B1h,0D1h
S4:	DB	091h,0B1h,0D2h,091h,0B1h
S5:	DB	0D2h,091h,0B2h,0D2h,091h
S6:	DB	0B2h,0D2h,092h,0B2h,0D2h
S7:	DB	092h,0B2h,0D3h,092h,0B2h
S8:	DB	0D3h,092h,0B3h,0D3h,092h
S9:	DB	0B3h,0D3h,093h,0B3h,0D3h
SA:	DB	093h,0B3h,0D4h,093h,0B3h
SB:	DB	0D4h,093h,0b4h,0D4h,093h
SC:	DB	0B4h,0D4h,094h,0B4h,0D4h
SD:	DB	094h,0B4h,0D5h,094h,0B4h
SE:	DB	0D5h,094h,0B5h,0D5h,094h
SF:	DB	095h,0B5h,0D5h,096h,0B5h
S10:	DB	095h,0B5h,0D5h,096h,0B5h
S11:	DB	0D5h,096h,0B5h,0D6h,096h
S12:	DB	0B5h,0D6h,096h,0B6h,0D6h
S13:	DB	096h,0B6h,0D6h,097h,0B6h
S14:	DB	0D6h,097h,0B6h,0D7h,097h
S15:	DB	0B6h,0D7h,097h,0B6h,0D7h
S16:	DB	096h,0B7h,0D8h,096h,0B7h
S17:	DB	0D7h,096h,0B9h,0D7h,096h
S18:	DB	0B9h,0D7h,097h,0B9h,0D7h
S19:	DB	097h,0B9h,0D8h,097h,0B9h
S1A:	DB	0D8h,097h,0BAh,0D8h,097h
S1B:	DB	0BAh,0D8h,098h,0BAh,0D8h
S1C:	DB	097h,0BAh,0DAh,097h,0BAh
S1D:	DB	0DAh,097h,0BBh,0DAh,097h
S1E:	DB	0BBh,0DAh,098h,0BBh,0DAh
S1F:	DB	098h,0BBh,0DBh,098h,0BBh
S20:	DB	0DBh,098h,0BCh,0DBh,099h
S21:	DB	0BBh,0DBh,09Ah,0BBh,0DBh
S22:	DB	09Ah,0BBh,0DCh,09Ah,0BBh
S23:	DB	0DCh,09Ah,0BCh,0DCh,09Ah
S24:	DB	0BCh,0DCh,09Bh,0BCh,0DCh
S25:	DB	09Bh,0BCh,0DDh,09Bh,0BCh
S26:	DB	0DDh,09Bh,0BDh,0DDh,09Bh
S27:	DB	0BDh,0DDh,09Ch,0BDh,0DDh
S28:	DB	09Ch,0BDh,0DDh,09Dh,0BDh
S29:	DB	0DDh,09Dh,0BDh,0DEh,09Dh
S2A:	DB	0BDh,0DEh,09Dh,0BEh,0DEh
S2B:	DB	09Dh,0BEh,0DEH,09Eh,0BEh
S2C:	DB	0DEH,09Eh,0BEh,0DFh,09Eh
S2D:	DB	0BEh,0DFh,09Eh,0BEh,0DFh
S2E:	DB	09Eh,0BFh,0DFh,09Eh,0BFh
S2F:	DB	0DFh,09Eh,0BFh,0DFh,09Fh