/* 
 * File:   Lab_4.c
 * Author: Andro Younan
 *
 * Created on July 9, 2020, 3:54 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
/*
 * 
 */
# define SW0 PORTCbits.RC1
# define SW1 PORTDbits.RD1
# define LED0 PORTCbits.RC0
# define LED1 PORTDbits.RD0
int main(int argc, char** argv) 
{
// Turn off the ADC
    ADCON1 = 0xff;
    
    // PORTC: bit #0 is output (connected to LED0), bit #1 is input (connected to SW0)
    TRISC = 0x02;
    
    // PORTD: bit #0 is output (connected to LED1), bit #1 is input (connected to SW1)
    TRISD = 0x02;
    
    while (1)
    {
        if (SW0 == 0)
            LED0 = 0; // Turn on LED0 (cathode connected to port)
        else
            LED0 = 1;
        if (SW1 == 0)
            LED1 = 0; // Turn on LED1 (cathode connected to port)
        else
            LED1 = 1;
    }
    return (EXIT_SUCCESS);
}

