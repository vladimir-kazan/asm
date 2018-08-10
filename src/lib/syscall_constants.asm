%ifidn __OUTPUT_FORMAT__, elf64
    %define     SYS_WRITE   0x0000001
    %define     SYS_READ    0x0000000
    %define     SYS_EXIT    0x000003C
%elifidn __OUTPUT_FORMAT__, macho64
    %define     SYS_WRITE   0x2000004
    %define     SYS_READ    0x2000003
    %define     SYS_EXIT    0x2000001
%endif
; to be continued...
