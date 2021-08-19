V_LINES
ldx #0
    stx PF0
    stx PF1
    stx PF2

    REPEAT 7
        sta WSYNC
    REPEND
ENDM
EOF