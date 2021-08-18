    processor 6502

    seg code
    org $F000   ; Define the code origin at $F000

Start:
    sei         ; Disable interrupts
    cld         ; Disable the BCD decimal math mode
    ldx #$FF    ; Loads the X register with #$FF
    txs         ; Transfer the X register to the (S)tack pointer

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 ti $FF)
; Meaning the entire RAM and also the entire TIA register
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
