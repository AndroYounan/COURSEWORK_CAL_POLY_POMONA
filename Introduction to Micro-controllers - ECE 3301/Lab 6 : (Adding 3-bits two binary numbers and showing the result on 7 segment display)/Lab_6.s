config OSC = INTIO2
config BOR = OFF        ; Brown-out Reset Enable bits (Brown-out Reset disabled in hardware and software)
config STVREN = OFF     ; Stack Full/Underflow Reset Enable bit (Stack full/underflow will not cause Reset)
config WDT = OFF        ; Watchdog Timer Enable bit (WDT disabled (control is placed on the SWDTEN bit))
config MCLRE = ON       ; MCLR Pin Enable bit (MCLR pin enabled; RE3 input pin disabled)
#include <xc.inc>	
	goto start	
	
	; Convert BCD into 7 Segment pattern
	; Start by copying the program from subroutine
	
	psect data  
	; USING ((COMMON ANODE)) 7 SEGMENT DISPLAY
lookup:	DB  0x81, 0xCF, 0x92, 0x86, 0xCC, 0xA4, 0xA0, 0x8F, 0x80, 0x84, 0x88, 0xE0, 0xB1, 0xC2, 0xB0
	
	psect code
SSEG	EQU 0x41    ; 7segment pattern table starting address in data memory
I	EQU 0x70    ; used as a counter index
numA	EQU 0x80
numB	EQU 0x81	
start:	
	; Move the 7seg pattern from program memory into data memory
	movlw	low lookup
	movwf	TBLPTRL, f, a
	movlw	high lookup
	movwf	TBLPTRH, f, a
	movlw	low highword lookup
	movwf	TBLPTRU, f, a
	
	lfsr	0, SSEG ; starting address in data memory
	movlw	15
	movwf	I, f, a ; initialize counter with 15
loop:	TBLRD*+    ; read 1B from program memory and advance TBLPTR by 1
	movff	TABLAT, POSTINC0 ;copy TABLAT into INDF0 them move FSR0 pointer forward
	decf	I, f, a;
	bnz	loop
	
	
	; set the I/O port directions
	setf	ADCON1, a   ; turn off the ADC
	clrf	TRISA, a    ; output connected to 7seg
	setf	TRISD, a    ; input  connected to 4 switches
	
	; start the read/display
infiniteloop:
	movf	PORTD, w, a ; read (A) value from switches
	andlw	00000111B   ; keep the lowest 3 bits only
	movwf	numA, a
	movf	PORTD, w, a ; read (B) value from switches
	andlw	00111000B   ; keep the second lowest 3 bits only
	movwf	numB, a
	; shifting 3 bits to the right
	RRNCF	numB
	RRNCF	numB
	RRNCF	numB
	; addition
	movf	numA, w, a
	addwf 	numB, w, a
	call	bcd2sseg, 0
	movwf	PORTA, a
	bra	infiniteloop
    
	; convert a BCD pattern stored in 4 lsb of WREG into 7Seg
bcd2sseg: 
	lfsr	0, SSEG; move fsr0 pointer back to start of table
	movf	PLUSW0, w, a
	return 0; WREG will have the sseg pattern upon return
	
end






