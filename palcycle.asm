.include "x16.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start

.include "filenames.asm"
.include "loadvram.asm"
.include "irq.asm"
.include "vsync.asm"

VRAM_BITMAP = $10000

start:

   ; Disable layer 1
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer1, 1
   stz VERA_data0

   VERA_SET_ADDR VRAM_hscale, 1  ; set display to 2x scale
   lda #64
   sta VERA_data0
   sta VERA_data0

   ; load VRAM data from binaries
   lda #>(VRAM_palette>>4)
   ldx #<(VRAM_palette>>4)
   ldy #<palette_fn
   jsr loadvram

   lda #>(VRAM_BITMAP>>4)
   ldx #<(VRAM_BITMAP>>4)
   ldy #<bitmap_fn
   jsr loadvram

   ; configure layer 0 for background bitmaps
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer0, 1  ; configure VRAM layer 0
   lda #$C1
   sta VERA_data0 ; 4bpp bitmap
   stz VERA_data0 ; 320x240
   stz VERA_data0
   stz VERA_data0
   lda #<(VRAM_BITMAP >> 2)
   sta VERA_data0
   lda #>(VRAM_BITMAP >> 2)
   sta VERA_data0
   stz VERA_data0
   stz VERA_data0 ; Palette offset = 0
   stz VERA_data0
   stz VERA_data0

   ; setup interrupts
   jsr init_irq


mainloop:
   wai
   jsr check_vsync
   bra mainloop
