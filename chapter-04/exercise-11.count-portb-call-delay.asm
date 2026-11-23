    ; Count from 00 to FF and send each count to PORTB.
    ; Put a time delay between each issuing of data to PORTB.
    #include <avr/io.h>

    #define COUNT r20
    .ORG 0

    ; Initialize the stack pointer because DISPLAY and DELAY use CALL and RET.
    LDI r16, hi8(RAMEND)              ; Load the high byte of RAMEND.
    OUT _SFR_IO_ADDR(SPH), r16        ; Load the Stack Pointer High register.
    LDI r16, lo8(RAMEND)              ; Load the low byte of RAMEND.
    OUT _SFR_IO_ADDR(SPL), r16        ; Load the Stack Pointer Low register.

    LDI COUNT, 0                       ; Count = 0.
BACK:
    CALL DISPLAY                       ; Increment and put the count in PORTB.
    RJMP BACK                          ; Repeat indefinitely.

    ; -------------------- this is the display subroutine --------------------
DISPLAY:
    INC COUNT                           ; Increment count.
    OUT _SFR_IO_ADDR(PORTB), COUNT      ; Send it to PORTB.
    CALL DELAY                          ; Provide a time delay.
    RET                                 ; Return to caller.

    ; -------------------- this is the delay subroutine ----------------------
    .ORG 0x300                          ; Put time delay at address 0x300.
DELAY:
    LDI r16, 0xFF                       ; R16 = 255.
AGAIN:
    NOP                                 ; No operation wastes clock cycles.
    NOP
    NOP
    DEC r16                             ; Decrement R16.
    BRNE AGAIN                          ; Repeat until R16 becomes 0.
    RET                                 ; Return to caller.
