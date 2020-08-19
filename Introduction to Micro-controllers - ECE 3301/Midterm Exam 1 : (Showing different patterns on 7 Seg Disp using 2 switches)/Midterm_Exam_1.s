config OSC = INTIO2
config BOR = OFF        ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
config STVREN = OFF     ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
config WDT = OFF        ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
config MCLRE = ON       ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#include <xc.inc>	
	goto start		
	psect code
count equ 166666
start:	setf	ADCON1, a   ; turn off the ADC
	clrf	TRISA, a    ; output connected to 7seg
	setf	TRISD, a    ; input  connected to 2 switches
infiniteloop:
	movf	PORTD, W, a // reading the switches
	andlw	00000011B
	bz	Off	    // ( if 0 --> off )
	andlw	00000001B   
	bz	RC	    // ( if 2 --> rotate clockwise )
	movf	PORTD, W, a 
	andlw	00000010B   
	bz	Toggles	    // ( if 1 --> toggles )
	bnz	RCC	    // ( if 3 --> rotate counterclockwise ) 
	bra	infiniteloop
Off:	movlw	11111111B	
	movwf	PORTA, a
	bra	infiniteloop
Toggles:
	movlw	11111110B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11111111B
	movwf	PORTA, a
	call    Delay, 1
	bra	infiniteloop
RC:	movlw	10011111B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11001111B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11100111B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11110011B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11111001B
	movwf	PORTA, a
	call	Delay, 1
	movlw	10111101B
	movwf	PORTA, a
	call	Delay, 1
	bra	infiniteloop
RCC:	movlw	10111101B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11111001B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11110011B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11100111B
	movwf	PORTA, a
	call	Delay, 1
	movlw	11001111B
	movwf	PORTA, a
	call	Delay, 1
	movlw	10011111B
	movwf	PORTA, a
	call	Delay, 1
	bra	infiniteloop
delay2550us:			    
	movlw	255
l1:	decf	WREG, w, a
	nop
	nop
	nop
	bnz	l1
	return 1

Delay:			    
	movlw	100		    
	movwf	0x10, a
l2:	call	delay2550us
	decf	0x10, f, a
	bnz	l2
	return 1	
	
