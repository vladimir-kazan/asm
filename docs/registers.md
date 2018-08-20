# Registers

## Decomposition

64-bit|32 bits|16 bits|8 bits
---|---|---|---
rax|eax|ax|al
rbx|ebx|bx|bl
rcx|ecx|cx|cl
rdx|edx|dx|dl
rsi|esi|si|sil
rdi|edi|di|dil
rbp|ebp|bp|bpl
rsp|esp|sp|spl
r8|r8d|r8w|r8b
..|
r15|r15d|r15w|r15b

## General-Purpose registers

- rax - *"a"*
- rbx - *"b"*
- rcx - *"c"*
- rdx - *"d"*
- rbp - register base pointer (start of stack)
- rsp - register stack pointer (current location in stack, growing downwards)
- rsi - register source index (source for data copies)
- rdi - register destination index (destination for data copies)
----
- rax, accumulator
- rbx, base, addressing
- rcx, counter, loops
- rdx, data, input/output

## syscall

- first 6 arguments are in rdi, rsi, rdx, rcx, r8d, r9d; remaining arguments are on the stack.
- the syscall number is in rax.
- return value is in rax.
- the called routine is expected to preserve rsp, rbp, rbx, r12, r13, r14, and r15 but may trample any other registers.


## Volatility
rax, rcx, rdx, r8-r11 are volatile.
rbx, rbp, rdi, rsi, r12-r15, rsp are nonvolatile.

## Other info
Register|Usage|Preserved across calls
---|---|---
%rax (r0)|temporary register; with variable arguments passes information about the number of vector registers used; **1st return** register|No
%rbx (r3)|callee-saved register|Yes
%rcx (r1)|used to pass **4th** integer argument to functions|No
%rdx (r2)|used to pass **3rd** argument to functions; **2nd return register**|No
%rsp (r4)|stack pointer|Yes
%rbp (r5)|callee-saved register, optionally used as frame pointer|Yes
%rsi (r6)|used to pass **2st** argument to functions|No
%rdi (r7)|used to pass **1st** argument to functions|No
%r8|used to pass **5th** argument to functions|No
%r9|used to pass **6th** argument to functions|No
%r10|temporary register, used for passing a function’s static chain pointer|No
%r11|temporary register|No

## Links

https://www.uclibc.org/docs/psABI-x86_64.pdf
