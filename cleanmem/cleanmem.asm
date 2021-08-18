    processor 6502
    seg code
    org $F000           ; Define the code origin at $F000
Start:
    sei                 ; Disable interrupts
    cld                 ; Disable the BCD decimal math mode
    ldx #$FF            ; Loads the X register with #$FF
    txs                 ; Transfer the X register to the (S)tack pointer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Clear the Page Zero region ($00 ti $FF)
; Meaning the entire RAM and also the entire TIA register
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #0              ; A = 0
    ldx #$FF            ; X = #$FF
    sta $FF             ; make sure $FF is zeroed before the loop starts
MemLoop:
    dex                 ; X--
    sta $0,X            ; Store the value of A inside memory address $0 + X
    bne MemLoop         ; Loop until X = 0 ( z-flag is set )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Fill the ROM size to exactly 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC
    .word Start         ; reset vector at $FFFC ( ehre the program starts )
    .word Start         ; Interrupt vector at $FFFE ( unused in the VCS )