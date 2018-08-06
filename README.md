# asm
Assembly x64 playground


## Tools

1. NASM — compiler
```sh
brew install nasm
```
2. GCC — C compiler
3. GNU Make — build system
4. GDB — debugger
5. ViM

## Build binaries
```sh
nasm -f macho64 hello.asm -o hello.o
ld -macosx_version_min 10.7.0 -lSystem -o hello hello.o -e main
./hello
# return code
echo $?
```

## syscall

https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master

```c
1	AUE_EXIT	ALL	{ void exit(int rval); }
4	AUE_NULL	ALL	{ user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); }
```

## registers

https://www.uclibc.org/docs/psABI-x86_64.pdf

decomposition
- rax = r0
- eax = r0d — double word, lower 32 bits
- ax = r0w — word, lower 16 bits
- ah + al = r0b — byte, lower 8 bits

Others
- rsi (64) -> esi (32) -> si (16) -> sil (8)
- rdi (64) -> edi (32) -> di (16) -> dil (8)
- rsp (64) -> esp (32) -> sp (16) -> spl (8)
- rbp (64) -> ebp (32) -> bp (16) -> bpl (8)

Register|Usage|Preserved across calls
---|---|---
%rax (r0)|temporary register; with variable arguments passes information about the number of vector registers used; 1st return register|No
%rcx (r1)|used to pass **4th** integer argument to functions|No
%rdx (r2)|used to pass **3rd** argument to functions; 2nd return register|No
%rbx (r3)||
%rsp (r4)||
%rbp (r5)||
%rsi (r6)|used to pass **2st** argument to functions|No
%rdi (r7)|used to pass **1st** argument to functions|No

