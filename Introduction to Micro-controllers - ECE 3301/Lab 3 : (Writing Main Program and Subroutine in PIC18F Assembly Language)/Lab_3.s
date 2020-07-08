#include <xc.inc>
	goto start	
	
	; Lab 3 Prelab
	psect code
N   equ	0x00	; Number of X's
Z   equ 0x60	; Final answer is stored here
X   equ 0x50	; Starting point of Xi array
loc equ 0x70    ; location to get Xi values stored at and used through
start:	; load location 0x50 to 0x58 with arbitrary numbers for testing
	; you should also use "Memory Fill" to test it with zeros, ones, or even random numbers
	movlw 8 ;N numbers
	movwf N,f,a
	bcf STATUS,0,a
	
	lfsr	0, X
	movlw	1
	movwf	POSTINC0, f, a
	movlw	2
	movwf	POSTINC0, f, a
	movlw	3
	movwf	POSTINC0, f, a
	movlw	4
	movwf	POSTINC0, f, a
	movlw	5
	movwf	POSTINC0, f, a
	movlw	6
	movwf	POSTINC0, f, a
	movlw	7
	movwf	POSTINC0, f, a
	movlw	8
	movwf	POSTINC0, f, a
	clrf	WREG
    	; TODO: Your main program code starts here
	; 	- Use FSR1 to point to Xi
	;	- Call sum8 to generate the sum
	;	- Divide the resulting sum by 8 using rotate right with carry (you should reset the carry after each rotation)

       lfsr	1, X
loop: movff 	POSTINC1, loc
      call	sum8,1
      decfsz	N,f,a
      bra	loop
      
      BCF	STATUS,0,a
      RRCF	Z,f,a
      BCF	STATUS,0,a
      RRCF	Z,f,a
      BCF	STATUS,0,a
      RRCF	Z,f,a
      BCF	STATUS,0,a
      
	
stop:	bra	stop

    ; TODO: Your subroutine program codes goes here
sum8:	movwf loc, w,a
	addwf Z,f,a
	return 1
	
end
