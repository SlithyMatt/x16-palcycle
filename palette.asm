.ifndef PALETTE_INC
PALETTTE_INC = 1

.include "x16.inc"

BM_PO = VRAM_layer0 + 7

frame: .byte 0

pal_tick:
   inc frame
   lda frame
   and #$03
   bne @return
   stz VERA_ctrl
   VERA_SET_ADDR BM_PO, 0
   lda VERA_data0
   inc
   cmp #13
   bmi @set
   lda #0
@set:
   sta VERA_data0
@return:
   rts

.endif
