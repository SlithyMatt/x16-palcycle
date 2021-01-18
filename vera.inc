.ifndef VERA_INC

VERA_INC  = 1

; video settings masks
VERA_dc_video_output_mask           = %00000011
VERA_dc_video_chromadisable_mask    = %00000100
VERA_dc_video_layer0_enable_mask    = %00010000
VERA_dc_video_layer1_enable_mask    = %00100000
VERA_dc_video_sprite_enable_mask    = %01000000

; shared scaling constants for height and width
VERA_dc_scale_normal                = $80
VERA_dc_scale_2x                    = $40

; shared map tile sizes for height and width
VERA_layer_map_size_32              = $0
VERA_layer_map_size_64              = $1
VERA_layer_map_size_128             = $2
VERA_layer_map_size_256             = $3

; shift levels for use in VERA layer config registers
VERA_layer_map_width_shift          = $4    ; ex: VERA_layer_map_size_128 << VERA_layer_width_shift
VERA_layer_map_height_shift         = $6    ; ex: VERA_layer_map_size_64 << VERA_layer_height_shift

; tile sizes (in pixels)
VERA_layer_tile_width_8             = $0
VERA_layer_tile_width_16            = $1
VERA_layer_tile_height_8            = $0
VERA_layer_tile_height_16           = $2

VERA_colordepth_1bpp                = $0
VERA_colordepth_2bpp                = $1
VERA_colordepth_4bpp                = $2
VERA_colordepth_8bpp                = $3

VERA_bitmap_mode_enabled            = $1 << 2
VERA_T25C_mode_enabled              = $1 << 3

VERA_isr_vsync_mask                 = %00000001
VERA_isr_line_mask                  = %00000010
VERA_isr_sprcol_mask                = %00000100
VERA_isr_aflow_mask                 = %00001000
VERA_isr_collisions_mask            = %11110000

.endif
