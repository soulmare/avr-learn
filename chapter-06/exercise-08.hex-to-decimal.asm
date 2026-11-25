; Convert a hexadecimal number to decimal digits.
; Assume data memory location 0x315 contains $FD (253 decimal). Convert the
; value to decimal and store the digits in 0x322, 0x323, and 0x324, with the
; least-significant digit in 0x322.

#include <avr/io.h>

    .text
    .org 0

    .equ HEX_NUM, 0x315
    .equ RMND_L, 0x322
    .equ RMND_M, 0x323
    .equ RMND_H, 0x324

#define NUM r20
#define DENOMINATOR r21
#define QUOTIENT r22

    LDI r16, 0xFD              ; $FD = 253 in decimal
    STS HEX_NUM, r16           ; store $FD in location 0x315

    LDS NUM, HEX_NUM
    LDI DENOMINATOR, 10        ; DENOMINATOR = 10

L1:
    INC QUOTIENT
    SUB NUM, DENOMINATOR
    BRCC L1                    ; if C = 0 go back
    DEC QUOTIENT                ; once too many
    ADD NUM, DENOMINATOR        ; add back to it
    STS RMND_L, NUM             ; store remainder as the 1st digit

    MOV NUM, QUOTIENT
    LDI QUOTIENT, 0

L2:
    INC QUOTIENT
    SUB NUM, DENOMINATOR
    BRCC L2
    DEC QUOTIENT                ; once too many
    ADD NUM, DENOMINATOR        ; add back to it
    STS RMND_M, NUM             ; store remainder as the 2nd digit
    STS RMND_H, QUOTIENT        ; store quotient as the 3rd digit

HERE:
    JMP HERE                    ; stay here forever
