; Read and test PORTB to see whether it has the value 45H.
; If it does, send 99H to PORTC; otherwise, it is cleared.

#include <avr/io.h>

    .org 0

    LDI r16, 0xFF
    OUT _SFR_IO_ADDR(DDRC), r16   ; PORTC out
    LDI r16, 0
    OUT _SFR_IO_ADDR(DDRB), r16   ; PORTB in
    IN r16, _SFR_IO_ADDR(PINB)
    LDI r17, 0x45
    EOR r16, r17
    BRNE SETPORT                  ; branch if PORTB <> 0x45
    LDI r16, 0x99                 ; PORTC value when PORTB = 0x45
    RJMP OVER
    SETPORT:
        LDI r16, 0                ; PORTC value when PORTB <> 0x45
    OVER:
        OUT _SFR_IO_ADDR(PORTC), r16 ; set value
