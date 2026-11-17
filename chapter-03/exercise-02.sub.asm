    ; SUB example
    LDI r20, 0x34
    LDI r21, 0x25
    SUB r20, r21

    STS 0x0100, r20
    LDS r22, 0x0100

stop:
    RJMP stop
