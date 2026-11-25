#include <avr/io.h>

#define NUM r20
#define DENOMINATOR r21
#define QUOTIENT r22

    LDI NUM, 95             ; NUM = 95
    LDI DENOMINATOR, 10     ; DENOMINATOR = 10
    CLR QUOTIENT            ; QUOTIENT = 0

L1:
    INC QUOTIENT
    SUB NUM, DENOMINATOR
    BRCC L1                 ; branch if C is zero
    DEC QUOTIENT            ; once too many
    ADD NUM, DENOMINATOR    ; add back to it

HERE:
    JMP HERE                ; stay here forever
