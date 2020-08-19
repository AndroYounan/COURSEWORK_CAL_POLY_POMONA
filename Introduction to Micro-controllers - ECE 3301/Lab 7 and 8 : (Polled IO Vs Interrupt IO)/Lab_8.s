config OSC = INTIO2
config BOR = OFF        ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
config STVREN = OFF     ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
config WDT = OFF        ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
config MCLRE = ON       ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#include <xc.inc>
	goto main
psect intCodeHi, class = CODE, reloc = 2
    ;clear the flag every time we go through the interrupt to avoid being stuck on the interrupt
    bcf	    INTCON3, 0, a
    ;Do what needs to be done
    btfsc   PORTB, 1, a ; If RB1 is zero, skip the next instruction 
    infloop:
	movwf	PORTB, a
	andlw	00000010B   ; keep the value of (input = Coparator's output) bit #1 in PORTB
	bz	ledoff	    ; if switch = 0, turn OFF LED
	bnz	ledon	    ; if switch = 1, turn ON LED
	ledon:	bsf	PORTD, 1, a ; turn on LED (Anode connected to port)
	bra	infloop
	ledoff: bcf	PORTD, 1, a ; turn off LED (Anode connected to port)
	bra	infloop	
    retfie  0	
psect code
main: 
; set the I/O port directions
    setf    ADCON1, a   ; AN inputs are now digital inputs
    clrf    TRISD, a	; RD1 is output (connected to LED - Andoe connected to port)
    bsf	    TRISB, 1, a ; RB1 is input (connected to output of comparator)

; Setup the interrupt
    bsf	    INTCON, 7, a ; Enable global interrupt
    bsf	    RCON, 7, a	 ; Enable priority
    movlw   01001000B	 ; Enable INT1, set it as high priority, restet INT1 Flag
    movwf   INTCON3, f, a
    bcf	    INTCON2, 5, a   ; Interrupt on falling edge (default)
    
; initial output value
    clrf    PORTD, a	; Start with the LED off
end	