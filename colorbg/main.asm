    processor 6502

    include "vcs.h"
    include "macro.h"

    seg code
    org $F000                   ; defines the origin of the ROM at $F000
Start:
    CLEAN_START                 ; Macro to safely clear the memory 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Set background luminosity to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    lda #$2e                    ; Load color intro A ( $1E is NTSC yellow )
    sta COLUBK                  ; store A to background color address $09

    jmp Start                   ; repeat from start

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  Set background luminosity to yellow
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    org $FFFC                   ; defines origin to $FFFC
    .word Start                 ; reset vector at $FFFC
    .word Start                 ; interrupt vector $FFFE