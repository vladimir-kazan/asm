
%include '../../lib/syscall_constants.asm'
%include '../../lib/functions.asm'

SECTION .text
global  start

start:
    ; mov     rdi, string1
    ; call    sprint
    ; mov     rdi, 21h
    ; call    printChar
    ; mov     rdi, 0Ah
    ; call    printChar

    mov     rdi, smile
    call    sprintLF

    mov     rdi, string_demo
    call    sprintLF

    mov     rdi, 0h
    call    exit


SECTION .data
smile: db `\u263a`,0h
string1:     db  "Strings",0h
string_demo:     db  "Demo",0h

