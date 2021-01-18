.ifndef PALETTE_INC
PALETTTE_INC = 1

.include "x16.inc"

; palette offset. we can scroll this which will 
; scroll what color our vram data points to
BM_PO = VERA_L0_hscroll_h

frame: .byte 0

pal_tick:
   inc frame
   lda frame
   and #$03       ; number of frames to skip. set this to #$07 to see it scroll slower
   bne @return
   stz VERA_ctrl  ; reset control in case someone change ADDRSEL or DCSEL
   lda BM_PO
   inc
   cmp #13
   bmi @set
   lda #0
@set:
   sta BM_PO
@return:
   rts

.endif
