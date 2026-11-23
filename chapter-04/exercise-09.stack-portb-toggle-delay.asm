    ; Toggle all PORTB bits continuously by writing 0x55 and 0xAA.
    ; Add a time delay between each write.
    #include <avr/io.h>
    .ORG 0

    ; Initialize the stack because the delay routine is called with CALL.
    LDI r16, hi8(RAMEND)              ; Load the high byte of RAMEND into R16 (0x08 for ATmega328P).
    OUT _SFR_IO_ADDR(SPH), r16        ; Load the Stack Pointer High register.
    LDI r16, lo8(RAMEND)              ; Load the low byte of RAMEND into R16 (0xff for ATmega328P).
    OUT _SFR_IO_ADDR(SPL), r16        ; Load the Stack Pointer Low register.

BACK:
    LDI r16, 0x55                     ; Load R16 with 0x55.
    OUT _SFR_IO_ADDR(PORTB), r16      ; Send 0x55 to PORTB (address 0x25 for ATmega328P).
    CALL DELAY                        ; Time delay.

    LDI r16, 0xAA                     ; Load R16 with 0xAA.
    OUT _SFR_IO_ADDR(PORTB), r16      ; Send 0xAA to PORTB.
    CALL DELAY                        ; Time delay.

    RJMP BACK                         ; Keep doing this indefinitely.

    ; -------------------- this is the delay subroutine --------------------
    .ORG 0x300                        ; Put the time-delay subroutine at address 0x300.
DELAY:
    LDI r20, 0xFF                     ; R20 = 255, the counter.
AGAIN:
    NOP                               ; No operation wastes clock cycles.
    NOP
    DEC r20                           ; Decrement the counter.
    BRNE AGAIN                        ; Repeat until R20 becomes 0.
    RET                               ; Return to the caller.
