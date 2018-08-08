%include        'syscall_constants.asm'

; default rel

; %macro printString 2
;     mov     rax, 0x2000004 ; write
;     mov     rdi, 1 ; stdout
;     lea     rsi, [%1]
;     mov     rdx, %2
;     syscall
; %endmacro
; printString str1, str1.len
