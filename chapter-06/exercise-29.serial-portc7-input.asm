; Write a program to bring in a byte of data serially via pin PC7 and save it
; in r20. The byte comes in with the LSB first.

#include <avr/io.h>

    .text
    .org 0

    CBI _SFR_IO_ADDR(DDRC), 7        ; bit 7 of Port C is input
    LDI r16, 8                       ; r16 = 8
    LDI r20, 0                       ; r20 = 0

again:
    SBIC _SFR_IO_ADDR(PINC), 7       ; skip the next line if bit 7 of Port C is 0
    SEC                              ; set carry flag to one
    SBIS _SFR_IO_ADDR(PINC), 7       ; skip the next line if bit 7 of Port C is 1
    CLC                              ; clear carry flag to zero
    ROR r20                          ; rotate right r20. move C flag to MSB of r20
    DEC r16                          ; decrement r16
    BRNE again                       ; if r16 is not zero go to again

here:
    JMP here                         ; stop here
