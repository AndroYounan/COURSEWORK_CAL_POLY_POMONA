/* 
 * File:   Midterm_Exam_1.c
 * Author: Andro Younan
 *
 * Created on July 12, 2020, 2:39 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"

/*
 * 
 */
# define SW0 PORTDbits.RD0
# define SW1 PORTDbits.RD1
#define _XTAL_FREQ 1000000
int main(int argc, char** argv) 
{
    int off = 0xff;
    int g = 0xFE;
    int ab = 0x9F;
    int bc = 0xcf;
    int cd = 0xe7;
    int de = 0xf3;
    int ef = 0xf9;
    int fa = 0xbd;
    
    // Turn off the ADC
    ADCON1 = 0xff;
    // output connected to 7seg
    TRISA = 0x00;
    // input  connected to 2 switches
    TRISD = 0x03;
    while (1)
    {
        if (SW0 == 0 && SW1 == 0) // ( if 0 --> off ) 
        {
            PORTA = off;
        } 
        else if (SW0 == 1 && SW1 == 0) // ( if 1 --> toggles )
        {
            PORTA = g; __delay_ms(500); 
            PORTA = off; __delay_ms(500); 
        }    
        else if ((SW0 == 0) && (SW1 == 1)) // ( if 2 --> rotate clockwise )
        {
            PORTA = ab;  __delay_ms(500); 
            PORTA = bc;  __delay_ms(500);
            PORTA = cd;  __delay_ms(500);
            PORTA = de;  __delay_ms(500);
            PORTA = ef;  __delay_ms(500);
            PORTA = fa;  __delay_ms(500);
        }else // ( if 3 --> rotate counterclockwise ) //if (SW0 == 1 && SW1 == 1) 
        {
            PORTA = fa;  __delay_ms(500);
            PORTA = ef;  __delay_ms(500);
            PORTA = de;  __delay_ms(500);
            PORTA = cd;  __delay_ms(500);
            PORTA = bc;  __delay_ms(500);
            PORTA = ab;  __delay_ms(500); 
        }    
    }
    return (EXIT_SUCCESS);
}

