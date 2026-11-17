    ldi r20, 0x25
    ldi r21, 0x13
    add r20, r21

    sts 0x0100, r20
    lds r22, 0x0100

stop:
    rjmp stop
