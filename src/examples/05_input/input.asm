
%include '../../lib/syscall.asm'
%include '../../lib/functions.asm'

SECTION .text
global  start
default rel

start:
    ; mov     rdi, title        ; this doesn't work for more than 1 string
    lea     rdi, [title]        ; or lea rdi, [rel title], without `global rel`
    call    sprintLF

    lea     rdi, [inputData]
    mov     rsi, 0xff
    call    sinput

    lea     rdi, [hello]
    call    sprintLF
    lea     rdi, [inputData]
    call    sprint

    mov     rdi, 0h
    call    exit

SECTION .data
title   db  "Input demo, please enter something:", 0h
hello   db  "Your input is: ", 0h

SECTION .bss
inputData: resb    255     ; reserve a 255 byte space in memory for the users input string
; variableName1:  RESB    1       ; reserve space for 1 byte
; variableName2:  RESW    1       ; reserve space for 1 word
; variableName3:  RESD    1       ; reserve space for 1 double word
; variableName4:  RESQ    1       ; reserve space for 1 double precision float (quad word)
; variableName5:  REST    1       ; reserve space for 1 extended precision float

