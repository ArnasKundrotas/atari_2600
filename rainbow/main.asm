    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000                   ; defines the origin of the ROM at $F000
Start:
    CLEAN_START                 ; Macro to safely clear the memory 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Star a new frame by turning on VBLANK and VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
NextFrame:
    lda #2                       ; same as binary value %00000010
    sta VBLANK                   ; turn on VBLANK
    sta VSYNC                    ; turn on VSYNC

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  3 scanlines of VSYNC
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    sta WSYNC                    ; first scanline
    sta WSYNC                    ; second scanline
    sta WSYNC                    ; third scanline

    lda #0
    sta VSYNC                    ; turn off VSYN

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  37 scanlines of VBLANK
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldx #37                       ; X = 37 (counter)
LoopVBlank:
    sta WSYNC                     ; hit WSYNC and wait for the next scanline
    dex                           ; X--
    bne LoopVBlank                ; loop while X != 0

    lda #0
    sta VBLANK               ; turn off VBLANK

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Draw 192 visible Scanlines (kernal)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ldx #192                      ; counter for 192 visible scanlines
LoopScanline:
    stx COLUBK                    ; set the background color
    sta WSYNC                     ; wait for the next scanline
    dex                           ; X--
    bne LoopScanline              ; loop while X != 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  30 scanlines of overscan
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    lda #2                        ; hit and turn on VBLANK again
    sta VBLANK

    ldx #30                       ; counter for 30 scanlines
LoopOverscan:
    sta WSYNC                     ; wait for the next scanline
    dex                           ; X--
    bne LoopOverscan              ; loop while X != 0

    jmp NextFrame

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Complete my ROM size to 4KB
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC                   ; defines origin to $FFFC
    .word Start                 ; reset vector at $FFFC
    .word Start                 ; interrupt vector $FFFE