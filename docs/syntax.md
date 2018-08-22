# Syntax with *nasm*

# Jump

```assembly
jmp label   ; 123

je  label   ; jump if equal, ZF
jz  label   ; jump if equal, ZF



```

# Segments

```assembly
segment .bss
  sum resb 1

; later
mov   [sum], rax
```
