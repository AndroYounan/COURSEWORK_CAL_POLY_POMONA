/* 
 * File:   Lab_9.c
 * Author: Andro Younan
 *
 * Created on July 24, 2020, 7:35 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
# define _XTAL_FREQ 1000000
/*
 * 
 */
unsigned int result; //Initialize variable
unsigned int wholeV; //Initialize variable
unsigned int fractionalV; //Initialize variable
int main() 
{
// 1 - Configure the A/D Module
    // AN0 is connected to wipe of potentiometer
    // Reference voltages are VSS and VDD
    ADCON1 = 0x0E;
    TRISAbits.RA0 = 1; // AN0 is an input
    TRISB=0x00;        // port B is the output
    // * Select A/D acquisition time
    // * Select A/D conversion clock
    // Right justified, ACQT = 2 TAD, ADCS = FOSC/2
    ADCON2bits.ADCS = 0; // FOSC/2
    ADCON2bits.ACQT = 1; // ACQT = 2 TAD
    ADCON2bits.ADFM = 0; // left justified
    // * Select A/D input channel
    ADCON0bits.CHS = 0; // Channel 0 (AN0)
    // * Turn on A/D module
    ADCON0bits.ADON = 1;
    while (1)
    {
// 4 - Start conversion: Set GO/DONE(bar) bit
    ADCON0bits.GO = 1;
// 5 Wait for A/D conversion to complete
    while (ADCON0bits.GO_NOT_DONE);
// 6 - Read A/D result registers (ADRESH:ADRESL);
    result = ADRESH; // Move the converted 8-bit data into result
    wholeV = result/51;
    fractionalV = (result%51)/5;
    wholeV = (wholeV<<4);
    result = wholeV + fractionalV;
    PORTB = result;
    }    
    return (EXIT_SUCCESS);
}

