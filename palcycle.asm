.include "x16.inc"
.include "vera.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start

.include "filenames.asm"
.include "loadvram.asm"
.include "irq.asm"
.include "palette.asm"

VRAM_BITMAP = $10000

start:
   ; always reset control line or you could be writing to wrong memory location
   stz VERA_ctrl

   ; Disable layers, sprites while we configure them
   lda VERA_dc_video
   and #($FF ^ (VERA_dc_video_sprite_enable_mask | VERA_dc_video_layer1_enable_mask | VERA_dc_video_layer0_enable_mask))
   sta VERA_dc_video

   ; set display to 2x scale along both vertical and horizontal axes
   lda #(VERA_dc_scale_2x)
   sta VERA_dc_hscale
   sta VERA_dc_vscale

   ; load palette data from binaries
   lda #>(VRAM_palette>>4)
   ldx #<(VRAM_palette>>4)
   ldy #<palette_fn
   jsr loadvram

   ; load bitmap data from binaries
   lda #>(VRAM_BITMAP>>4)
   ldx #<(VRAM_BITMAP>>4)
   ldy #<bitmap_fn
   jsr loadvram

   ; reset ADDRSEL and DCSEL
   stz VERA_ctrl

   ; configure VRAM layer 0 for background bitmaps
   lda #(VERA_bitmap_mode_enabled | VERA_colordepth_4bpp)
   sta VERA_L0_config
   
   ; configure the location of the tiles. this is confusing, but ultimately we want bits 16:11 of `VRAM_BITMAP`
   ; to set as our tilebase. then we set the tile size to 8pixels for height and width
   lda #((((VRAM_BITMAP >> 11) & $3F) << 2) | VERA_layer_tile_width_8 | VERA_layer_tile_height_8)
   sta VERA_L0_tilebase
   stz BM_PO ; Palette offset = 0

   ; re-enable layer 0
   lda VERA_dc_video
   ora #(VERA_dc_video_layer0_enable_mask)
   sta VERA_dc_video

   ; setup VSYNC interrupts. See `irq.asm`
   jsr init_irq

mainloop:
   wai
   bra mainloop
