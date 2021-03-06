; nasm -felf64 hello.asm -o hello.o
; ld -o hello hello.o
; nasm -f macho64 hello.asm -o hello.o && ld -macosx_version_min 10.7.0 -lSystem -o hello hello.o -e main
; ./hello
; echo $? # for return code
; ld hello.o -e start -o hello
%ifidn __OUTPUT_FORMAT__, elf64
    %define     SYS_WRITE       0x0000001
    %define     SYS_EXIT        0x000003C
%elifidn __OUTPUT_FORMAT__, macho64
    %define     SYS_WRITE       0x2000004
    %define     SYS_EXIT        0x2000001
%endif

global  start                           ; ld [-e main] # for entrypoint

section .data
msg:    db      "Hello, world!!!", 0x0a ; 0x0a = 10 = /n
.len:   equ     $ - msg

section     .text
start:
    mov         rax, SYS_WRITE          ; system call number should be stored in rax
    mov         rdi, 1                  ; argument #1 in rdi: where to write, stdout = 1
    mov         rsi, msg                ; argument #2 where does the string starg
    mov         rdx, msg.len            ; argument #3 how many bytes to write
    syscall

    ; exit
    mov         rax, SYS_EXIT           ; exit syscall number
    xor         rdi, rdi                ; exit status 0
    ; mov rdi, 42
    syscall
