    ; Write a program to determine
    ; if RAM location 0x200 contains the value 0.
    ; If so, put 0x55 into it.
    #include <avr/io.h>

    .EQU MYLOC, 0x200

    ; LDI r16, 0x01
    ; STS MYLOC, r16
    LDS r20, MYLOC

    TST r20
    BRNE SKIP_IF_NOT_ZERO
    LDI r20, 0x55
    STS MYLOC, r20
SKIP_IF_NOT_ZERO:

stop:
    RJMP stop
