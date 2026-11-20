    ; Find the sum of the values 0x79, 0xF5, and 0xE2.
    ; Put the sum into R20 (low byte) and R21 (high byte).

    LDI r20, 0x0
    LDI r21, 0x0
    LDI r16, 0x79
    LDI r17, 0xF5
    LDI r18, 0xE2

    ADD r20, r16
    ADD r20, r17
    BRSH NEXT1
    INC r21
NEXT1:
    ADD r20, r18
    BRSH NEXT2
    INC r21
NEXT2:

stop:
    RJMP stop
