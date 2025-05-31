main :: () {
    initialize_clock();
    initialize_bootrom_functions();
    reset(.RESET_IO_BANK0 | .RESET_PADS_BANK0);

    OUT_PIN :: 0;

    setPinAsOutput(OUT_PIN);

    for 0..19 {
        for 0..0x1000 {
            delay(0x1000);
            setOutputPin(OUT_PIN);
            delay(0x100);
            clearOutputPin(OUT_PIN);
        }
        delay(0x1000000);
    }
    reboot(0x0002 | 0x0100, 1, 0, 0);
}

#load "builtins.jai";
#load "gpio.jai";
