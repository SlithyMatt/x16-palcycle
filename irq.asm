.ifndef IRQ_INC
IRQ_INC = 1


def_irq: .word $0000

init_irq:
   sei
   lda IRQVec
   sta def_irq
   lda IRQVec+1
   sta def_irq+1
   lda #<handle_irq
   sta IRQVec
   lda #>handle_irq
   sta IRQVec+1
   cli
   rts

handle_irq:
   ; check for VSYNC
   lda VERA_isr
   and #(VERA_isr_vsync_mask)
   beq @done_vsync
   ; main animation loop. See `palette.asm`
   jsr pal_tick

@done_vsync:
   ; TODO check other IRQs
   jmp (def_irq)

.endif
