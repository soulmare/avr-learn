    #include <avr/io.h>
    .ORG 0

    LDI r16, hi8(RAMEND)
    OUT _SFR_IO_ADDR(SPH), r16
    LDI r16, lo8(RAMEND)
    OUT _SFR_IO_ADDR(SPL), r16              ; Initialize stack pointer.

    LDI r16, 0x55                           ; Load R16 with 55H.
BACK:
    COM r16                                 ; Complement R16.
    OUT _SFR_IO_ADDR(PORTB), r16            ; Load PORTB SFR.
    RCALL DELAY                             ; Time delay.
    RJMP BACK                               ; Keep doing this indefinitely.

    ; -------------------- this is the delay subroutine --------------------
DELAY:
    LDI r20, 0xFF                           ; R20 = 0xFF.
AGAIN:
    NOP                                     ; No operation wastes clock cycles.
    NOP
    DEC r20
    BRNE AGAIN                              ; Repeat until R20 becomes 0.
    RET
