%include '../../lib/syscall.asm'
%include '../../lib/functions.asm'

SECTION .text
global  start

; The last two stack items for a NASM compiled program are always the name of the program and the number of passed arguments.

start:
    mov     rdi, msg
    call    sprintLF

    pop     rcx         ; first value on the stack is the number of arguments
nextArg:
    cmp     rcx, 0h     ; check if there are more args
    jz      noMoreArgs
    pop     rdi         ; take next argument
    push    rcx
    call    sprintLF
    pop     rcx
    dec     rcx
    jmp     nextArg

noMoreArgs:
    mov     rdi, 0h
    call    exit

SECTION .data
msg:    db  "Passing arguments:", 0h
