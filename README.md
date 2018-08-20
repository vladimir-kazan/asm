# asm
Assembly x64 playground
http://asmtutor.com
https://cs.brown.edu/courses/cs033/docs/guides/x64_cheatsheet.pdf
http://www.cs.smith.edu/~jfrankli/231f13/231/doc/pcasm-book.pdf

http://cs.lmu.edu/~ray/notes/nasmtutorial/

https://www.nasm.us/doc/nasmdoc0.html

https://software.intel.com/en-us/articles/introduction-to-x64-assembly

https://www.tutorialspoint.com/assembly_programming/assembly_arithmetic_instructions.htm

https://software.intel.com/en-us/articles/intel-sdm

## Tools

1. NASM — compiler, https://www.nasm.us/xdoc/2.13.03/nasmdoc.pdf
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

Linux — http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
https://github.com/torvalds/linux/blob/master/arch/x86/entry/syscalls/syscall_64.tbl
Mac — https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master


```c
1	AUE_EXIT	ALL	{ void exit(int rval); }
4	AUE_NULL	ALL	{ user_ssize_t write(int fd, user_addr_t cbuf, user_size_t nbyte); }
```

# Debugging

https://lldb.llvm.org/lldb-gdb.html
https://www.nesono.com/sites/default/files/lldb%20cheat%20sheet.pdf

## gdb

https://www.csee.umbc.edu/portal/help/nasm/nasm.shtml

`brew install gdb`

```sh
# v8.0.1
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/c3128a5c335bd2fa75ffba9d721e9910134e4644/Formula/gdb.rb

brew pin gdb # stop updating

codesign -fs gdbcert /usr/local/bin/gdb
```

The purpose for creating a certificate was to codesign gdb on Mac. Here are the steps:
- Name of Certificate = gdbcert
- Identity Type = Self Signed Root
- Certificate Type = Code Signing

**Sign:**
- Create a certificate with all the parameters mentioned above.
- Instead of saving the Keychain under location System, save it under Login.
- Then, unlock the System Keychain by clicking on the lock icon on the top left corner and drag the certificate from Login to System.
- Right Click the Certificate, click on Get Info and and under Trust, set to Always Trust.
- Restart taskgated in terminal: killall taskgated
- Enable root account:
    - Open System Preferences.
    - Go to User & Groups > Unlock.
    - Login Options > "Join" (next to Network Account Server).
    - Click "Open Directory Utility".
    - Go up to Edit > Enable Root User.
- Run codesign -fs gdbc /usr/local/bin/gdb in the terminal.
- Disable Root Account again and you should be good to go.
- Credits:
    - Keychain Access error when creating new system certificate
    - https://gist.github.com/hlissner/898b7dfc0a3b63824a70e15cd0180154

```sh
# .gdbinit
set startup-with-shell off
set auto-load safe-path /
set disassembly-flavor intel
```

To create a code signing certificate, open the Keychain Access application. Choose menu Keychain Access -> Certificate Assistant -> Create a Certificate…

Choose a name for the certificate (e.g., gdb-cert), set Identity Type to Self Signed Root, set Certificate Type to Code Signing and select the Let me override defaults. Click several times on Continue until you get to the Specify a Location For The Certificate screen, then set Keychain to System.

Double click on the certificate, open Trust section, and set Code Signing to Always Trust. Exit Keychain Access application.

Restart the taskagted service, and sign the binary.

```sh
$ sudo killall taskgated
$ codesign -fs gdb-cert /usr/local/bin/gdb


break start
run

layout asm
layout regs

# disassemble current instruction
x /i $rip

print /x $rax
p /t $rax # binary


# print stack (3 records)
x/3 $sp
```

## lldb

```sh
# set breakpoint
b start
# run
run

# show registers
register read rax rsp rbp
re r
re r --all
register read --format binary rax

# show code
disassemble --frame
di -f
disassemble --frame --bytes
di -f -b

# breakpoint
breakpoint set --name main
b s -n main
b main
```

---
# Bash
## Some commands

```sh
########################################
# to binary:

# dec to bin
echo "obase=2;$num" | bc
echo $(([##2]$num)) # with zsh

# hex to bin
echo $(([##2]0xf)) # 1111

########################################
# to decimal:

# hex to dec
echo $((0xff)) # 255
echo $((16#f)) # 15

# bin to dec
echo $((2#1000)) # 8

########################################
# to hexadecimal:

# dec to hex
printf '%x\n' 42
echo $(([##16]$num)) # with zsh
```

```sh

-~~..~:#;L .-:#;L,.- .~:#:;.T -~~.~:;..~:;.
E8+U *T +U’ *T# .97 *L E8+’ *;T’ *;, D97 ‘*L .97 ’*L "T;E+:, D9 *L *L H7 I#T7 I# "*:.H7I#I# U: :8*#+,:8T,79U::8:8
,#B. .IE, "T;E* .IE,J*+;#:T*" ,#B. .IE, .IE,
```
