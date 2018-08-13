%include '../../lib/syscall.asm'
%include '../../lib/functions.asm'

SECTION     .text
global      start
default     rel


SECTION     .text
start:
    lea     rdi, [msg]
    call    sprintLF
    mov     rdi, 0
    call    exit

    ret

SECTION     .data
msg:    db  "Convert string to number:"
