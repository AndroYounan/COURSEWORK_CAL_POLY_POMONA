
config OSC = INTIO2
config BOR = OFF        ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
config STVREN = OFF     ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
config WDT = OFF        ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
config MCLRE = ON       ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#include <xc.inc>
	goto start	
	
	; Based on the specification of the switches and LEDs in a table and k-maps,
	; LED0 = ~SW0 , LED1 = ~SW1
	psect code
start:	
	setf	ADCON1, a   ; Turn off ADC inputs
	bcf     TRISC,0, a  ; LED0 (output) bit #0 on PORTC
	bcf	TRISD,0, a  ; LED1 (output) bit #0 on PORTD
	bsf	TRISC,1, a  ; SW0 (input) bit #1 on PORTC
	bsf     TRISD,1, a  ; SW1 (input) bit #1 on PORTD
infloop0:
	movf	PORTC, w, a
	andlw	00000010B   ; keep the value of (SW0) bit #1 in PORTC
	bz	led0on	    ; if SW0 = 0, turn LED0 on
	bnz	led0off	    ; if SW0 = 1, turn LED0 off
infloop1:	
	movf	PORTD, w, a
	andlw	00000010B   ; keep the value of (SW1) bit #1 in PORTD
	bz	led1on	    ; if SW1 = 0, turn LED1 on
	bnz	led1off	    ; if SW1 = 1, turn LED1 off
	
	bra	infloop0	

led0on:	bcf	PORTC, 0, a ; turn on LED0 (cathode connected to port)
	bra	infloop1
led0off:bsf	PORTC, 0, a ; turn off LED0 (cathode connected to port)
	bra	infloop1			
led1on:	bcf	PORTD,0, a  ; turn on LED1 (cathode connected to port)
    	bra	infloop0
led1off:bsf	PORTD,0, a  ; turn off LED1 (cathode connected to port)
	bra	infloop0
end



