/* 
 * File:   Lab_6.c
 * Author: Andro Younan
 *
 * Created on July 9, 2020, 5:36 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
/*
 * 
 */
int main(int argc, char** argv) 
{
    // 	; USING ((COMMON ANODE)) 7 SEGMENT DISPLAY
    char sseg[15] = {0x81, 0xCF, 0x92, 0x86, 0xCC, 0xA4, 0xA0, 0x8F, 0x80, 0x84, 0x88, 0xE0, 0xB1, 0xC2, 0xB0};
    
    // Turn off ADC
    ADCON1 = 0xff;
    
    // PORTA is output (connected to 7segment display)
    TRISA = 0x00;
    
    // PORTD is input (connected to switches)
    TRISD = 0xff;
    
    while (1)
    {
        int numA = PORTD & 0b00000111;
        int numB = PORTD & 0b00111000;
        int numC = numB >> 3;
        PORTA = sseg[ numA + numC ];
    }

    return (EXIT_SUCCESS);
}

