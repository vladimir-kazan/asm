; %include './syscall.asm'

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
; void iprint(Integer number)
; Integer printing (itoa)
; num in rdi - 1st argument
iprint:
    mov     rcx, 0          ; num counter
    mov     rax, rdi
; if positive
    cmp     rax, 0x0
    jnl     .divideLoop
; else
    neg     rax
    mov     rdi, 45
    push    rax
    push    rcx
    call    printChar
    pop     rcx
    pop     rax

.divideLoop:
    inc     rcx
    mov     rdx, 0          ; empty remainder
    mov     rsi, 0Ah
    div     rsi
    add     rdx, 30h        ; 48 or 30h or '0'
    push    rdx
    cmp     rax, 0
    jnz     .divideLoop
.printLoop:
    dec     rcx
    mov     rdi, rsp
    push    rcx
    call    sprint
    pop     rcx
    pop     rdi
    cmp     rcx, 0
    jnz     .printLoop
    ret

;------------------------------------------
; int atoi(Integer number)
; Ascii to integer function (atoi)
;
; atoi:
; in rdi - 1st argument
; return rax
atoi:
    push    rbx
    mov     rcx, 0          ; init counter

; check first char
    xor     rbx, rbx        ; set 0
    mov     bl, [rdi + rcx] ; current char in rbx
    ; if char is minus
    mov     rax, 1
    cmp     bl, 45          ; '-'
    jne     .begin
    mov     rax, -1
    inc     rcx

.begin:
    push    rax
    mov     rax, 0          ; initialise rax with decimal value 0

.multiplyLoop:
    xor     rbx, rbx        ; set 0
    mov     bl, [rdi + rcx] ; current char in rbx
; if char is minus
    cmp     bl, 45          ; '-' code is 45
    jne     .notNegative
    ; mov     rax, 0xa
    inc     rcx
    jmp     .multiplyLoop

.notNegative:
; if end of string
    cmp     bl, 10          ; compare ebx register's lower half value against ascii value 10 (linefeed character)
    je      .finished       ; jump if equal to label finished
    cmp     bl, 0           ; compare ebx register's lower half value against decimal value 0 (end of string)
    jz      .finished       ; jump if zero to label finished
; if char is number
    cmp     bl, 48          ; ascii value 48 (char value 0)
    jge      .processNumber ; jump if less than to label finished
    cmp     bl, 57          ; compare ebx register's lower half value against ascii value 57 (char value 9)
    jle      .processNumber ; jump if greater than to label finished

.processNumber:
    sub     bl, 48
    add     rax, rbx
    mov     rbx, 10
    mul     rbx
    inc     rcx
    jmp     .multiplyLoop
.finished:
    xor     rdx, rdx        ; otherwise wrong result in linux
    mov     rbx, 10
    div     rbx             ; rax/rbx
    pop     rbx
    mul     rbx             ; 1 or -1
    pop     rbx             ; restore initial value
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
