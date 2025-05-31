/*
Store the code in flash and execute it in sram.
*/

MEMORY
{
    flash (r) : ORIGIN = 0x10000000, LENGTH = 0x0800000
    sram (rwx) : ORIGIN = 0x20000000, LENGTH = 0x0800000
}

SECTIONS
{
    .metadata : {
        *(.metadata*)
    } > sram AT > flash
    .text : {
        *(.text*)
    } > sram AT > flash

    .data : {
        *(.data*)
    } > sram AT > flash
    .rodata : {
        *(.rodata*)
    } > sram AT > flash
    .eh_frame : {
        *(.eh_frame*)
    } > sram AT > flash

    __end = .;
}

ENTRY(main)
