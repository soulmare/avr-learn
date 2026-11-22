    ; This example shows the stack and stack pointer
    ; and the registers used after the execution of each instruction.
    #include <avr/io.h>

    ; Initialize the Stack Pointer (SP) to the last location of SRAM (RAMEND)
    LDI R16, hi8(RAMEND)
    OUT _SFR_IO_ADDR(SPH), R16 ; Load Stack Pointer High byte (0x08 for ATmega328P)

    LDI R16, lo8(RAMEND)
    OUT _SFR_IO_ADDR(SPL), R16 ; Load Stack Pointer Low byte (0xff for ATmega328P)

    ; Initialize registers
    LDI R31, 0
    LDI R20, 0x21
    LDI R22, 0x66

    ; Push register values onto the stack
    ; PUSH stores at the current SP address, then decrements SP.
    ; Stores 0x21 at SRAM[0x08ff]
    PUSH R20
    ; Stores 0x66 at SRAM[0x08fe]
    PUSH R22

    ; Pop values from the stack
    POP R22
    POP R20

stop:
    RJMP stop
