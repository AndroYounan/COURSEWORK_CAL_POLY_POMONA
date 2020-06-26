#include <xc.inc>
    ;psect code

    ;A = 0xF1 91 B5
    num_AH equ 0x22
    num_AM equ 0x21
    num_AL equ 0x20

    movlw   0xF1
    movwf   num_AH, f, a
    movlw   0x91
    movwf   num_AM, f, a
    movlw   0xB5
    movwf   num_AL, f, a
    
    ;B = 0x07 A2 04
    num_BH equ 0x52
    num_BM equ 0x51
    num_BL equ 0x50

    movlw   0x07
    movwf   num_BH, f, a
    movlw   0xA2
    movwf   num_BM, f, a
    movlw   0x04
    movwf   num_BL, f, a
    
    ; RENAMING of locations 
    num_CH equ 0x52
    num_CM equ 0x51
    num_CL equ 0x50
 
    ; sum the low bytes first
    movwf   num_AL, w, a
    addwf   num_BL, w, a
    movwf   num_CL, f, a
    
    ; sum the medium bytes
    movwf   num_AM, w, a
    addwfc  num_BM, w, a; add with carry
    movwf   num_CM, f, a
    
    ; sum the high bytes
    movwf   num_AH, w, a
    addwfc  num_BH, w, a; add with carry
    movwf   num_CH, f, a
    
end


