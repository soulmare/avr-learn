    ; Write a program to
    ; (a) clear R20,
    ; then (b) add 3 to R20 ten times,
    ; and (c) send the sum to PORTB.
    ; Use the zero flag and BRNE.
    #include <avr/io.h>

    LDI r20, 0
    LDI r21, 3
    LDI r22, 10

BACK:
    ADD r20, r21
    DEC r22
    BRNE BACK

    OUT _SFR_IO_ADDR(PORTB), r20

stop:
    RJMP stop
