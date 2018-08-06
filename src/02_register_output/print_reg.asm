; Max x64
; nasm -f macho64 print_reg.asm -F dwarf -g -o print_reg.o && ld -macosx_version_min 10.7.0 -lSystem -o print_reg print_reg.o && ./print_reg
; Linux x64
; nasm -f elf64 print_reg.asm -F dwarf -g -o print_reg.o && ld print_reg.o -e start -o print_reg && ./print_reg

%ifidn __OUTPUT_FORMAT__, elf64
        %define     SYS_WRITE       0x0000001
        %define     SYS_EXIT        0x000003C
%elifidn __OUTPUT_FORMAT__, macho64
        %define     SYS_WRITE       0x2000004
        %define     SYS_EXIT        0x2000001
%endif

global start

        section     .data
codes:  db          '0123456789ABCDEF', 10
.len:   equ         $ - codes

        section     .text

write:
        ; mov         rdi, code           ; 1st
        ; mov         rsi, codes.len      ; 2nd
        push        rax
        push        rdi
        push        rsi
        push        rdx

        mov         rax, SYS_WRITE      ; write()
        mov         rdx, rsi            ; arg #3, length of string
        mov         rsi, rdi            ; arg #2, address of string
        mov         rdi, 1              ; arg #1, stdout

        push        rcx                 ; syscall leaves rcx and r11 changed
        syscall
        pop         rcx

        pop         rdx
        pop         rsi
        pop         rdi
        pop         rax
        ret

; void exit(code)
exit:
        mov         rax, SYS_EXIT   ; 1 - exit(), 6 - close()
        mov         rdi, 0          ; exit code
        syscall
        ret

start:

        mov         rax, 0x1122334455667788
        mov         rdi, 1  ; arg #1
        mov         rdx, 1  ; data
        mov         rcx, 12 ; counter

.loop:
        sub         rcx, 4

        mov         rdi, codes          ; 1st
        mov         rsi, codes.len      ; 2nd
        call        write
        test        rcx, rcx       ; test if zero
        jnz .loop

        call        exit
