
%include '../../lib/syscall .asm'
%include '../../lib/functions.asm'

SECTION .text
global  start
default rel

start:
    ; mov     rdi, string1
    ; call    sprint
    ; mov     rdi, 21h
    ; call    printChar
    ; mov     rdi, 0Ah
    ; call    printChar

    ; mov     rdi, smile
    ; call    sprintLF
data
    ; mov     rdi, string_demo
    ; call    sprintLF

    lea     rdi, [printFuns]
    call    sprintLF
    lea     rdi, [printFuns.iprint]
    call    sprintLF
    lea     rdi, [printFuns.iprint_1]
    call    sprintLF
    lea     rdi, [printFuns.iprint_2]
    call    sprintLF
    lea     rdi, [printFuns.iprint_3]
    call    sprint



    mov     rdi, 42
    call    iprint

    mov     rdi, 0Ah
    call    printChar

    mov     rdi, 0h
    call    exit


SECTION .data
printFuns:  db  "Print functions:", 0h
.iprint:    db  "  1. iprint(Integer number)", 0h
.iprint_1:  db  "     mov     rdi, 42", 0h
.iprint_2:  db  "     call    iprint", 0h
.iprint_3:  db  "     $output: ", 0h


smile: db `\u263a`,0h
string1:     db  "Strings",0h
string_demo:     db  "Demo",0h

