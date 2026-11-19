    ; Write a program to
    ; (a) load the PORTB register with the value 0x55,
    ; and (b) complement Port B 700 times.
    #include <avr/io.h>

    LDI r16, 0x55
    OUT _SFR_IO_ADDR(PORTB), r16
    LDI r20, 7 ; external loop counter

LOOP1:
    LDI r21, 10 ; internal loop counter

LOOP2:
    COM r16
    OUT _SFR_IO_ADDR(PORTB), r16
    DEC r21
    BRNE LOOP2

    DEC r20
    BRNE LOOP1

stop:
    RJMP stop
