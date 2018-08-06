; nasm -felf64 hello.asm -o hello.o
; ld -o hello hello.o
; nasm -f macho64 hello.asm -o hello.o && ld -macosx_version_min 10.7.0 -lSystem -o hello hello.o -e main
; ./hello
; echo $? # for return code

global start        ; ld [-e main] # for entrypoint

section .data
msg:    db      "Hello, world!!!", 0x0a     ; 0x0a = 10 = /n
.len:   equ     $ - msg

section .text
start:
; main program
; ============
; We're about to make a syscall write(rdi, rsi, rdx)
; where:
; rdi - the file descriptor, in this case 1 (stdout)
; rsi - the buffer's address, i.e where is the data to be written out?
;       in our case, it is hello_string.
; rdx - the number of bytes to be written
; write(rdi, rsi, rdx)

    mov rax, 0x2000004  ; system call number should be stored in rax
    mov rdi, 1          ; argument #1 in rdi: where to write, stdout = 1
    mov rsi, msg        ; argument #2 where does the string starg
    mov rdx, msg.len    ; argument #3 how many bytes to write
    syscall

    ; exit
    mov rax, 0x2000001      ; exit syscall number
    xor rdi, rdi            ; exit status 0
    ; mov rdi, 42
    syscall



