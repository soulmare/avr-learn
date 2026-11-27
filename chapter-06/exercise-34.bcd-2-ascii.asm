; Assume that R20 contains packed BCD.
; Write a program to convert the packed BCD to two
; ASCII numbers and place them in R21 and R22.

#include <avr/io.h>

    .text
    .org 0

    LDI r20, 0x29    ; the packed BCD to be converted (0b00101001)

    MOV r22, r20     ; copy the packed BCD to r22
    ANDI r22, 0x0F   ; isolate the lower nibble
    ORI r22, 0x30    ; convert to ASCII

    MOV r21, r20     ; copy the packed BCD to r21
    SWAP r21         ; make the higher nibble the new lower
    ANDI r21, 0x0F   ; isolate the upper nibble which is lower now
    ORI r21, 0x30    ; convert to ASCII
