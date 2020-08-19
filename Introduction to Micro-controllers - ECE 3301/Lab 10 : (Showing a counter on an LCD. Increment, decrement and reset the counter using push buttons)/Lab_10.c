/* 
 * File:   Lab_10.c
 * Author: Andro Younan
 *
 * Created on July 25, 2020, 1:54 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "LiquidCrystal.h"
#include "config.h"
# define _XTAL_FREQ 1000000
/*
 * 
 */
signed int x = 0;
int main() 
{
// ALL ANx input are digital
    ADCON1 = 0xff;
    
    // Data pins connected to PORTA
    TRISA = 0x00; 
    
    // 3 signal pins to the LSb of PORTD
    // RS = RD0
    // RW = RD1
    // E  = RD2
    TRISD = 0x00;
    
    // 3 push buttons (along with their pull up resistors) to the LSb of PORTB
    //B1 = RB0
    //B2 = RB1
    //B3 = RB2
    TRISB = 0xff;

    // connect the LCD pins to the appropriate PORT pins 
    pin_setup(&PORTA, &PORTD);
    
    // initialize the LCD to be 16x2 
    begin(16, 2, LCD_5x8DOTS);
    
    while (1)
    {        
        if (PORTBbits.RB0 == 0) {x = x + 1;}
        if (PORTBbits.RB1 == 0) {x = x - 1;}
        if (PORTBbits.RB2 == 0) {x = 0;}
        
        home();
        print_int(x);
        print("       ");
    }    
    return (EXIT_SUCCESS);
}

