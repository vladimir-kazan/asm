%ifidn __OUTPUT_FORMAT__, elf64
    %define     SYS_WRITE       0x0000001
    %define     SYS_EXIT        0x000003C
%elifidn __OUTPUT_FORMAT__, macho64
    %define     SYS_WRITE       0x2000004
    %define     SYS_EXIT        0x2000001
%endif

%macro printString 2
    mov     rax, SYS_WRITE
    mov     rdi, 1              ; stdout
    ; lea     rsi, [%1]         ; with "default rel" on top if error on mac
    mov     rsi, %1             ; string
    mov     rdx, %2             ; length
    syscall
%endmacro

%macro printChar 1
    mov     rdi, %1
    push    rdi
    mov     rsi, rsp
    printString rsi, 1
    pop     rdi
%endmacro

%macro exit 1
    mov     rax, SYS_EXIT
    mov     rdi, %1
    syscall
%endmacro

SECTION .text
global  start

start:
    printString message, message.len
    printChar 0x21      ; "!"" char
    printChar 0xA
    exit 0

SECTION .data
message:    db  "Hello world with macros"
.len:       equ $ - message
