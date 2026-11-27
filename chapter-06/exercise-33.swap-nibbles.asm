; In the absence of a SWAP instruction, exchange the nibbles.
; Show the process with a simple program.

#include <avr/io.h>

    .text
    .org 0

    LDI r20, 0x72                   ; r20 = the value to swap (0b01110010)
    LDI r16, 4                      ; r16 = 4 - bit counter
    LDI r21, 0                      ; r21 = 0, receives the upper nibble

begin:
    CLC                              ; clear carry flag
    ROL r20                          ; rotate r20 left, moving its upper bit to C
    ROL r21                          ; rotate r21 left, moving C into its lower bit
    DEC r16                          ; decrement r16
    BRNE begin                       ; if r16 is not zero, go to begin
    OR r20, r21                      ; combine the exchanged nibbles in r20

here:
    JMP here                         ; stop here
