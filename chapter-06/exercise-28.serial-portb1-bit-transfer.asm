; Write a program to transfer the value 41H serially (one bit at a time) via
; pin PB1. Put one high at the start and end of the data. Send the LSB first.

#include <avr/io.h>

    .text
    .org 0

    SBI _SFR_IO_ADDR(DDRB), 1        ; bit 1 of Port B is output
    LDI r20, 0x41                    ; r20 = the value to be sent
    CLC                              ; clear carry flag
    LDI r16, 8                       ; r16 = 8 - bit counter
    SBI _SFR_IO_ADDR(PORTB), 1       ; bit 1 of PORTB is 1

again:
    ROR r20                          ; rotate right r20 (send LSB to C flag)
    BRCS one                         ; if C = 1 then go to one
    CBI _SFR_IO_ADDR(PORTB), 1       ; bit 1 of PORTB is cleared to zero
    JMP next                         ; go to next

one:
    SBI _SFR_IO_ADDR(PORTB), 1       ; bit 1 of PORTB is set to one

next:
    DEC r16                          ; decrement r16
    BRNE again                       ; if r16 is not zero then go to again
    SBI _SFR_IO_ADDR(PORTB), 1       ; bit 1 of PORTB is set to one

here:
    JMP here                         ; RB1 = high
