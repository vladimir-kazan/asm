
%include '../../lib/syscall_constants.asm'
%include '../../lib/functions.asm'

SECTION .text
global  start

start:
    mov     rdi, strings
    call    sprint
    mov     rdi, 21h
    call    printChar
    mov     rdi, 0Ah
    call    printChar

    mov     rdi, strings
    call    sprintLF

    mov     rdi, 0h
    call    exit



SECTION .data
strings:     db  "Strings", 0h
