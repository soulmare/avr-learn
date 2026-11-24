; Write a test program for the AVR chip
; to toggle all the bits of PORTB, PORTC, and PORTD
; every 1/4 of a second.
; Assume a crystal frequency of 1 MHz.

#include <avr/io.h>

; initialize stack pointer
LDI     r16, hi8(RAMEND)
OUT     _SFR_IO_ADDR(SPH), r16
LDI     r16, lo8(RAMEND)
OUT     _SFR_IO_ADDR(SPL), r16

LDI r16, 0xFF
OUT _SFR_IO_ADDR(DDRB), r16    ; make Port B an output port
OUT _SFR_IO_ADDR(DDRC), r16    ; make Port C an output port
OUT _SFR_IO_ADDR(DDRD), r16    ; make Port D an output port

LDI r16, 0x55                 ; R16 = 0x55

AGAIN:
    OUT _SFR_IO_ADDR(PORTB), r16  ; put 0x55 on Port B pins
    OUT _SFR_IO_ADDR(PORTC), r16  ; put 0x55 on Port C pins
    OUT _SFR_IO_ADDR(PORTD), r16  ; put 0x55 on Port D pins
    COM r16                       ; complement R16
    CALL DELAY                    ; quarter of a second delay
    RJMP AGAIN

; --------------- 1/4 SECOND DELAY
DELAY:
    LDI r20, 200
    LOOP_0:
        LDI r21, 250
        LOOP_1:
            NOP
            NOP
            DEC r21
            BRNE LOOP_1
        DEC r20
        BRNE LOOP_0
    RET
