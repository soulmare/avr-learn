    ; ADD example
    LDI r20, 0x25
    LDI r21, 0x13
    ADD r20, r21

    STS 0x0100, r20
    LDS r22, 0x0100

stop:
    RJMP stop
