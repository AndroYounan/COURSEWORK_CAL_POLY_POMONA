/* 
 * File:   Lab_8.c
 * Author: Andro Younan
 *
 * Created on July 18, 2020, 7:48 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
/*
 * 
 */
# define _XTAL_FREQ 1000000 
# define SW   PORTBbits.RB1
# define LED  PORTDbits.RD1
void __interrupt(high_priority) interrupt_routine(void); // prototype
int main() 
{
    // All AN inputs are digital
    ADCON1 = 0xff;
    // PORTD is output (connected to LED - Anode connected to port)
    TRISD = 0x00;
    // RB1 is input (connected to SW = Comparator's output)
    TRISB = 0xff;   
    
    // Setup the interrupt
    INTCONbits.GIE = 1; // Global interrupt enable
    INTCON3bits.INT1E = 1; // Enable INT1
    INTCON3bits.INT1IF = 0; // reset INT1 flag
    INTCON2bits.INTEDG1 = 0; // falling edge
    
    // Setup priority
    RCONbits.IPEN = 1; //enable priority
    INTCONbits.GIEH = 1; // enable high priority
    INTCONbits.GIEL = 1; // enable low priority
    INTCON3bits.INT1IP = 1; // setting INT1 to be high priority
    
    // the led is off in the beginning and without interrupt
    while(1)
    {    
    PORTDbits.RD1 = 0;
    }
    return (EXIT_SUCCESS);
}
void __interrupt(high_priority) interrupt_routine(void)
{
    // test which interrupt called this Interrupt Service Routine - here we have only one anyway // INT1
    if (INTCON3bits.INT1E && INTCON3bits.INT1IF)
    {
        // Turn off the interrupt flag to avoid recursive interrupt calls
        INTCON3bits.INT1IF = 0;
        // Do what needs to be done
        while (SW == 1) // Comparator output is high
        {
            LED = 1; // turn ON the LED (Anode connected to the port)
        }
    }
    return;
}


