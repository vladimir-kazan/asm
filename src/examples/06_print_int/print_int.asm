%include '../../lib/syscall_constants.asm'
%include '../../lib/functions.asm'

SECTION .text
global  start
default rel

start:
    lea     rdi, [msg]
    call    sprintLF

    mov     rcx, 0       ; counter of how many bytes we need to print in the end
; divideLoop:
;     inc     rcx
    xor     rdx, rdx
    mov     rax, 250
    mov     rdi, 100
    idiv    rdi         ; value in rax, and the remainder in rdx

    ; iprint
    mov     rax, 731
    mov     rcx, 0      ; counter
divideLoop:
    inc     rcx
    mov     rdx, 0      ; empty rdx before division operations
    mov     rsi, 0Ah    ; divide by 10
    idiv    rsi
    add     rdx, 30h    ; 48 or '0' or 30h
    push    rdx
    cmp     rax, 0
    jnz     divideLoop

printLoop:
    dec     rcx
    mov     rdi, rsp
    push    rcx
    call    sprint
    pop     rcx
    pop     rax
    cmp     rcx, 0
    jnz     printLoop

    mov     rdi, 0Ah
    call    printChar

    mov     rdi, 0
    call    exit

SECTION .data
msg     db  'Print integers:', 0h
