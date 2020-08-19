config OSC = INTIO2
config BOR = OFF
config STVREN = OFF
config WDT = OFF
config MCLRE = ON
#include <xc.inc>
    goto main
psect code
main: 
    ; set the I/O port directions
    setf    ADCON1, a   ; AN inputs are now digital inputs
    bcf	    TRISD, 1, a ; RC1 is output (connected to LED)
    bsf	    TRISB, 1, a ; RB1 is input (the comparator output)
    ;turn off the led in the beginning
    bcf   PORTD, 1, a ; turn off LED0 (anode connected to port) 
infloop:
	movwf	PORTB, a
	andlw	00000010B   ; keep the value of (input = Coparator's output) bit #1 in PORTB
	bz	ledoff	    ; if switch = 0, turn OFF LED
	bnz	ledon	    ; if switch = 1, turn ON LED
	ledon:	bsf	PORTD, 1, a ; turn on LED (Anode connected to port)
	bra	infloop
	ledoff: bcf	PORTD, 1, a ; turn off LED (Anode connected to port)
	bra	infloop	
end	

