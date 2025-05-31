SIO_BASE :: 0xD0000000;

SIO_GPIO_IN_READ  :: (SIO_BASE+0x04);

SIO_GPIO_OUT_RW   :: (SIO_BASE+0x10);
SIO_GPIO_OUT_SET  :: (SIO_BASE+0x18);
SIO_GPIO_OUT_CLR  :: (SIO_BASE+0x20);
SIO_GPIO_OUT_XOR  :: (SIO_BASE+0x28);

SIO_GPIO_OE_RW    :: (SIO_BASE+0x30);
SIO_GPIO_OE_SET   :: (SIO_BASE+0x38);
SIO_GPIO_OE_CLR   :: (SIO_BASE+0x40);
SIO_GPIO_OE_XOR   :: (SIO_BASE+0x48);

SIO_MTIME_CTRL_RW :: (SIO_BASE+0x1A4);
SIO_MTIME_RW      :: (SIO_BASE+0x1B0);


CLOCKS_BASE :: 0x40010000;

CLK_REF_CTRL_RW        :: (CLOCKS_BASE+0x30+0x0000);
CLK_REF_CTRL_XOR       :: (CLOCKS_BASE+0x30+0x1000);
CLK_REF_CTRL_SET       :: (CLOCKS_BASE+0x30+0x2000);
CLK_REF_CTRL_CLR       :: (CLOCKS_BASE+0x30+0x3000);

CLK_SYS_CTRL_RW        :: (CLOCKS_BASE+0x3C+0x0000);
CLK_SYS_CTRL_XOR       :: (CLOCKS_BASE+0x3C+0x1000);
CLK_SYS_CTRL_SET       :: (CLOCKS_BASE+0x3C+0x2000);
CLK_SYS_CTRL_CLR       :: (CLOCKS_BASE+0x3C+0x3000);

CLK_SYS_RESUS_CTRL_RW  :: (CLOCKS_BASE+0x84+0x0000);
CLK_SYS_RESUS_CTRL_XOR :: (CLOCKS_BASE+0x84+0x1000);
CLK_SYS_RESUS_CTRL_SET :: (CLOCKS_BASE+0x84+0x2000);
CLK_SYS_RESUS_CTRL_CLR :: (CLOCKS_BASE+0x84+0x3000);

XOSC_BASE :: 0x40048000;

XOSC_CTRL_RW     :: (XOSC_BASE+0x00+0x0000);
XOSC_CTRL_XOR    :: (XOSC_BASE+0x00+0x1000);
XOSC_CTRL_SET    :: (XOSC_BASE+0x00+0x2000);
XOSC_CTRL_CLR    :: (XOSC_BASE+0x00+0x3000);

XOSC_STATUS_RW   :: (XOSC_BASE+0x04+0x0000);
XOSC_STATUS_XOR  :: (XOSC_BASE+0x04+0x1000);
XOSC_STATUS_SET  :: (XOSC_BASE+0x04+0x2000);
XOSC_STATUS_CLR  :: (XOSC_BASE+0x04+0x3000);

XOSC_STARTUP_RW  :: (XOSC_BASE+0x0C+0x0000);
XOSC_STARTUP_XOR :: (XOSC_BASE+0x0C+0x1000);
XOSC_STARTUP_SET :: (XOSC_BASE+0x0C+0x2000);
XOSC_STARTUP_CLR :: (XOSC_BASE+0x0C+0x3000);

XOSC_COUNT_RW    :: (XOSC_BASE+0x10+0x0000);
XOSC_COUNT_XOR   :: (XOSC_BASE+0x10+0x1000);
XOSC_COUNT_SET   :: (XOSC_BASE+0x10+0x2000);
XOSC_COUNT_CLR   :: (XOSC_BASE+0x10+0x3000);

IO_BANK0_BASE :: 0x40028000;

IO_BANK0_GPIO_STATUS_RW  :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x0+0x0000);
}
IO_BANK0_GPIO_STATUS_XOR :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x0+0x1000);
}
IO_BANK0_GPIO_STATUS_SET :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x0+0x2000);
}
IO_BANK0_GPIO_STATUS_CLR :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x0+0x3000);
}

IO_BANK0_GPIO_CTRL_RW  :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x4+0x0000);
}
IO_BANK0_GPIO_CTRL_XOR :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x4+0x1000);
}
IO_BANK0_GPIO_CTRL_SET :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x4+0x2000);
}
IO_BANK0_GPIO_CTRL_CLR :: (pin: u32) -> *u32 {
    return xx (IO_BANK0_BASE+(pin)*0x8+0x4+0x3000);
}

PADS_BANK0_BASE :: 0x40038000;

PADS_BANK0_BASE_GPIO_RW  :: (pin: u32) -> *u32 {
    return xx (PADS_BANK0_BASE+(pin)*0x4+0x4+0x0000);
}
PADS_BANK0_BASE_GPIO_XOR :: (pin: u32) -> *u32 {
    return xx (PADS_BANK0_BASE+(pin)*0x4+0x4+0x1000);
}
PADS_BANK0_BASE_GPIO_SET :: (pin: u32) -> *u32 {
    return xx (PADS_BANK0_BASE+(pin)*0x4+0x4+0x2000);
}
PADS_BANK0_BASE_GPIO_CLR :: (pin: u32) -> *u32 {
    return xx (PADS_BANK0_BASE+(pin)*0x4+0x4+0x3000);
}

ROSC ::  0x400e8000;


ROSC_CTRL      :: ROSC + 0x00;
ROSC_FREQA     :: ROSC + 0x04;
ROSC_FREQB     :: ROSC + 0x08;
ROSC_RANDOM    :: ROSC + 0x0c;
ROSC_DORMANT   :: ROSC + 0x10;
ROSC_DIV       :: ROSC + 0x14;
ROSC_PHASE     :: ROSC + 0x18;
ROSC_STATUS    :: ROSC + 0x1c;
ROSC_RANDOMBIT :: ROSC + 0x20;
ROSC_COUNT     :: ROSC + 0x24;


RESET_FLAGS :: enum_flags u32 {
    RESET_USBCTRL    :: 1<<28;
    RESET_UART1      :: 1<<27;
    RESET_UART0      :: 1<<26;
    RESET_TRNG       :: 1<<25;
    RESET_TIMER1     :: 1<<24;
    RESET_TIMER0     :: 1<<23;
    RESET_TBMAN      :: 1<<22;
    RESET_SYSINFO    :: 1<<21;
    RESET_SYSCFG     :: 1<<20;
    RESET_SPI1       :: 1<<19;
    RESET_SPI0       :: 1<<18;
    RESET_SHA256     :: 1<<17;
    RESET_PWM        :: 1<<16;
    RESET_PLL_USB    :: 1<<15;
    RESET_PLL_SYS    :: 1<<14;
    RESET_PIO2       :: 1<<13;
    RESET_PIO1       :: 1<<12;
    RESET_PIO0       :: 1<<11;
    RESET_PADS_QSPI  :: 1<<10;
    RESET_PADS_BANK0 :: 1<< 9;
    RESET_JTAG       :: 1<< 8;
    RESET_IO_QSPI    :: 1<< 7;
    RESET_IO_BANK0   :: 1<< 6;
    RESET_I2C1       :: 1<< 5;
    RESET_I2C0       :: 1<< 4;
    RESET_HSTX       :: 1<< 3;
    RESET_DMA        :: 1<< 2;
    RESET_BUSCTRL    :: 1<< 1;
    RESET_ADC        :: 1<< 0;
}

reset :: (reset_flags: RESET_FLAGS) {
    RESETS_BASE          :: 0x40020000;
    RESETS_RESET_CLR     :: (RESETS_BASE+0x0+0x3000);
    RESETS_RESET_DONE_RW :: (RESETS_BASE+0x8+0x0000);
    put32(xx RESETS_RESET_CLR, xx reset_flags);
    while (get32(xx RESETS_RESET_DONE_RW) & xx reset_flags) != xx reset_flags {}
}

setPinAsOutput :: (pin: u32) {
    // Add isolation on pin
    put32(PADS_BANK0_BASE_GPIO_SET(pin), 1<<8);

    // Set pin control to software
    put32(IO_BANK0_GPIO_CTRL_RW(pin), 5);

    // Enable output on pin
    put32(xx SIO_GPIO_OE_SET, xx 1<<pin);

    // Disable input
    put32(PADS_BANK0_BASE_GPIO_CLR(pin), 1<<6);

    // Remove isolation on pin, disable input
    put32(PADS_BANK0_BASE_GPIO_CLR(pin), 1<<8);
}

// Because of RP2350-E9 this is (mostly) useless and the readPin function has to do it...
setPinAsInput :: (pin: u32) {
    // Add isolation on pin
    put32(PADS_BANK0_BASE_GPIO_SET(pin), 1<<8);

    // Set pin control to software
    put32(IO_BANK0_GPIO_CTRL_RW(pin), 5);

    // Disable output on pin
    put32(xx SIO_GPIO_OE_CLR, xx 1<<pin);

    // Enable input
    put32(PADS_BANK0_BASE_GPIO_SET(pin), 1<<6);

    // Remove isolation on pin
    put32(PADS_BANK0_BASE_GPIO_CLR(pin), 1<<8);
}

readPin :: (pin: u32) -> u32 {
    // Because of RP2350-E9 we need to do a bunch of extra things here...
    // Enable input
    put32(PADS_BANK0_BASE_GPIO_SET(pin), 1<<6);
    // Remove isolation on pin
    put32(PADS_BANK0_BASE_GPIO_CLR(pin), 1<<8);

    // If not for RP2350-E9 this line would be the only one needed...
    output := (get32(xx SIO_GPIO_IN_READ) >> xx pin) & xx 1;

    // Disable input
    put32(PADS_BANK0_BASE_GPIO_CLR(pin), 1<<6);

    return output;
}

clearOutputPin :: (pin: u32) {
    put32(xx SIO_GPIO_OUT_CLR, xx 1<<pin);
}

setOutputPin :: (pin: u32) {
    put32(xx SIO_GPIO_OUT_SET, xx 1<<pin);
}

xorOutputPin :: (pin: u32) {
    put32(xx SIO_GPIO_OUT_XOR, xx 1<<pin);
}

clearOutputMask :: (mask: u32) {
    put32(xx SIO_GPIO_OUT_CLR, mask);
}

setOutputMask :: (mask: u32) {
    put32(xx SIO_GPIO_OUT_SET, mask);
}

xorOutputMask :: (mask: u32) {
    put32(xx SIO_GPIO_OUT_XOR, mask);
}

ROM_TABLE_CODE :: (c1: u8, c2: u8) -> u32 {
    return c1.(u32) | (c2.(u32) << 8);
}

lookupFunc :: (code: u32) -> *void {
    BOOTROM_TABLE_LOOKUP_ENTRY_OFFSET : *u16 : xx 0x7dfa;
    lookup_func: #type (code: u32, flags: u32) -> u32 #c_call = xx BOOTROM_TABLE_LOOKUP_ENTRY_OFFSET.*;
    return xx lookup_func(code, 1);
}

reboot: #type (flags: u32, delay_ms: u32, p0: u32, p1: u32) #c_call = xx 0;

initialize_bootrom_functions :: () {
    reboot = xx lookupFunc(ROM_TABLE_CODE("R", "B"));
}

initialize_clock :: () {
    // If you want a proper controllable clock you should switch to XOSC, ROSC is not very accurate.
    // Increase ROSC frequency

    // Set drive strength to max
    put32(xx ROSC_FREQA, 0x96967777);
    put32(xx ROSC_FREQB, 0x96967777);

    // Set frequency range to high
    put32(xx ROSC_CTRL, 0xfabfa5);
    put32(xx ROSC_CTRL, 0xfabfa7);

    // Set frequency divider to 1
    put32(xx ROSC_DIV, 0xaa01);
}
