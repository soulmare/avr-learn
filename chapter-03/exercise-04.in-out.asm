    ; ATmega328P I/O register addresses
    #include <avr/io.h>

    ; Configure PB5 as an output
    LDI r16, 0b00100000
    OUT _SFR_IO_ADDR(DDRB), r16

    ; Set PB5 high
    LDI r16, 0b00100000
    OUT _SFR_IO_ADDR(PORTB), r16
    LDS r16, PORTB

    ; Read the PINB input register
    IN r16, _SFR_IO_ADDR(PINB)

stop:
    RJMP stop
