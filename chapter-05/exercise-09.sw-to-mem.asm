; A switch is connected to pin PB0.
; Write a program to get the status of SW and save it
; in location 0x200.

#include <avr/io.h>

.EQU MYLOC, 0x200

CBI _SFR_IO_ADDR(DDRB), 0      ; PB0 input
AGAIN:
    LDI r20, 0
    SBIC _SFR_IO_ADDR(PINB), 0 ; Skip next instruction if PB0 is low
    LDI r20, 1                 ; PB0 was high
    STS MYLOC, r20
    RJMP AGAIN
