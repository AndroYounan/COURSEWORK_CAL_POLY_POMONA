/* 
 * File:   Lab_7.c
 * Author: Andro Younan
 *
 * Created on July 18, 2020, 6:36 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
/*
 * 
 */
# define SW PORTBbits.RB1
# define LED PORTDbits.RD1
int main(int argc, char** argv) 
{
    // Turn off the ADC
    ADCON1 = 0xff;
    // PORTB: bit #1 is input (comparator's output)
    TRISB = 0x02;
    // PORTD: bit #1 is output (connected to LED - Anode connected to LED)
    TRISD = 0x00;
    while (1)
    {
        LED = 0;
        if (SW == 1)
        {
            LED = 1; // when switch = 1, turn ON the LED (Anode connected to the port)
        }
    }
    return (EXIT_SUCCESS);
}

