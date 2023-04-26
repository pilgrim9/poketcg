;-------------------------------------------------------------------------------
;
; Assembler Structured Control-flow Macros
; by John Hardy @ 2019 ALL WRONGS RESERVED
; https://github.com/jhlagado/struct-z80
;
; Inspired by the work of Garth Wilson and Dave Keenan
; http://wilsonminesco.com/StructureMacros/
; http://dkeenan.com/AddingStructuredControlFlowToAnyAssembler.htm
;
;-------------------------------------------------------------------------------
DEF _STRUC_COUNT = 0

DEF STRUC_12 = 0
DEF STRUC_11 = 0
DEF STRUC_10 = 0
DEF STRUC_9 = 0
DEF STRUC_8 = 0
DEF STRUC_7 = 0
DEF STRUC_6 = 0
DEF STRUC_5 = 0
DEF STRUC_4 = 0
DEF STRUC_3 = 0
DEF STRUC_2 = 0
DEF STRUC_TOP = 0

MACRO STRUC_PUSH
    DEF STRUC_COUNT = STRUC_COUNT + 1
    DEF STRUC_12 = STRUC_11
    DEF STRUC_11 = STRUC_10
    DEF STRUC_10 = STRUC_9
    DEF STRUC_9 = STRUC_8
    DEF STRUC_8 = STRUC_7
    DEF STRUC_7 = STRUC_6
    DEF STRUC_6 = STRUC_5
    DEF STRUC_5 = STRUC_4
    DEF STRUC_4 = STRUC_3
    DEF STRUC_3 = STRUC_2
    DEF STRUC_2 = STRUC_TOP
    DEF STRUC_TOP = \1
ENDM

MACRO STRUC_POP
    DEF STRUC_COUNT = STRUC_COUNT - 1
    DEF STRUC_TOP = STRUC_2
    DEF STRUC_2 = STRUC_3
    DEF STRUC_3 = STRUC_4
    DEF STRUC_4 = STRUC_5
    DEF STRUC_5 = STRUC_6
    DEF STRUC_6 = STRUC_7
    DEF STRUC_7 = STRUC_8
    DEF STRUC_8 = STRUC_9
    DEF STRUC_9 = STRUC_10
    DEF STRUC_10 = STRUC_11
    DEF STRUC_11 = STRUC_12
    DEF STRUC_12 = 0
ENDM

MACRO STRUC_FWD
    DEF CUR_ADR = $
    org STRUC_TOP - 2
    dw CUR_ADR
    org CUR_ADR
ENDM

; if

MACRO _if
    jp \1, L_%%M
    jp $              ; placeholder jump to _else or _endif
    STRUC_PUSH $
L_%%M:
ENDM

MACRO _else
    jp $              ; placeholder jump to _endif
    STRUC_FWD
    DEF STRUC_TOP = $  ;reuse top of stack
ENDM

MACRO _endif
    STRUC_FWD
    STRUC_POP
ENDM

MACRO _andif ; continues _if test with a second test if first test was true
    jp \1, L_%%M
    jp $              ; placeholder jump to _endif
    STRUC_FWD
    DEF STRUC_TOP = $  ;reuse top of stack
L_%%M:
ENDM

; switch

MACRO _switch
    jr L_%%M
    jp $            ; placeholder jump to endswitch
    STRUC_PUSH $
L_%%M:
ENDM

MACRO _case
    jp \1, L_%%M
    jp $            ; placeholder jump to endcase
    STRUC_PUSH $
L_%%M:
ENDM

MACRO _endcase
    jp STRUC_2 - 3  ; jump to placeholder jump to endswitch
    STRUC_FWD
    STRUC_POP
ENDM

MACRO _endswitch
    STRUC_FWD
    STRUC_POP
ENDM

; skip

MACRO _skip
    jp $              ; placeholder jump to _else or _endif
    STRUC_PUSH $
ENDM

MACRO _endskip
    STRUC_FWD
    STRUC_POP
ENDM
