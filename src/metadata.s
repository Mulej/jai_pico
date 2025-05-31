.section .metadata, "a", @progbits

.align 4

.4byte 0xffffded3 # Header for metadata block


.byte  0x42 # IMAGE_DEF item
.byte  0x01 # item size (in words)
.byte  0x11 # IMAGE_TYPE_EXE | EXE_SECURITY_NS    executable to run in non secure zone
.byte  0x11 # EXE_CPU_RISCV | EXE_CHIP_RP2350     for riscv cpu on rp2350 chip

.byte  0x44 # ENTRY_POINT item
.byte  0x04 # item size
.2byte 0x0000 # pad
.4byte main # entry point
.4byte 0x20081000 # initial stack pointer
.4byte 0x20061000 # stack pointer limit (optional, change size if removed)

.byte  0x06 # LOAD_MAP item, used by the bootrom to load the code from flash into ram
.2byte 0x0004 # item size (3 * num_entries + 1)
.byte  0x81 # 8 -> absolute, 1 entry
.4byte 0x10000000 # storage address
.4byte 0x20000000 # runtime address
.4byte __end # runtime end address

.byte  0xff # BLOCK_ITEM_LAST
.2byte 0x0009 # Other items' size (length of all other items in words)
.byte  0x00 # pad


.4byte 0x00000000 # Relative pointer to next block, 0 means point to self e.i. just this block, if you have multiple blocks they must form a loop

.4byte 0xab123579 # Footer
