    ; INC example
    LDI r20, 0x34
    INC r20

    STS 0x100, r20

stop:
    RJMP stop
