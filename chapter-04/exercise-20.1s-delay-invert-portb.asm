#include <avr/io.h>

; Write a program to toggle all the bits of I/O register PORTB every 1 s.
; Assume that the crystal frequency is 16 MHz and the system is using an ATmega328P.

.ORG 0

LDI     r16, hi8(RAMEND)
OUT     _SFR_IO_ADDR(SPH), r16
LDI     r16, lo8(RAMEND)
OUT     _SFR_IO_ADDR(SPL), r16

LDI     r16, 0x55                         ;load R16 with 0x55
BACK:
    COM     r16                            ;complement PORTB
    OUT     _SFR_IO_ADDR(PORTB), r16      ;send it to port B
    CALL    DELAY_1S                      ;time delay
    RJMP    BACK                          ;keep doing this indefinitely

DELAY_1S:
    LDI     r20, 106
L1:
    LDI     r21, 200
L2:
    LDI     r22, 250
L3:
    NOP
    NOP
    DEC     r22
    BRNE    L3
    DEC     r21
    BRNE    L2
    DEC     r20
    BRNE    L1
    RET
