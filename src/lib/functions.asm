; %include './syscall_constants.asm'

;------------------------------------------
; int strlen(String message)
; String length calculation function
;
; rdi - 1st arg with string address
; rax - return value
slen:
    mov     rax, rdi

nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar

finished:
    sub     rax, rdi
    ret

;------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    call    slen
    mov     rdx, rax            ; arg #3, length of string
    mov     rsi, rdi            ; arg #2, address of string
    mov     rdi, 1h             ; arg #1, stdout
    mov     rax, SYS_WRITE      ; write()
    syscall
    ret

;------------------------------------------
; void sprint(String message)
; String printing function with defined length
; rdi - address of string
; rsi - length
print:
    mov     rdx, rsi            ; arg #3, length of string
    mov     rsi, rdi            ; arg #2, address of string
    mov     rdi, 1h             ; arg #1, stdout
    mov     rax, SYS_WRITE      ; write()
    syscall
    ret

;------------------------------------------
; void printChar(Char char)
; String printing with single char by its' code
printChar:
    push    rdi
    mov     rdi, rsp
    mov     rsi, 1h
    call    print
    pop     rdi
    ret

;------------------------------------------
; void sprintLF(String message)
; String printing with line feed function
sprintLF:
    call    sprint
    mov     rdi, 0Ah
    call    printChar
    ret

;------------------------------------------
; void input(char *buf, size_t count)
; Read data from console
sinput:
    mov     rax, SYS_READ
    mov     rdx, rsi            ; 3rd, size
    mov     rsi, rdi            ; 2nd, address to put input
    mov     rdi, 0x0            ; 1st, fd for input
    syscall
    ret

;------------------------------------------
; void exit()
; Exit program and restore resources
;
; rdi - 1st argument, exit code
exit:
    mov     rax, SYS_EXIT
    syscall
    ret
