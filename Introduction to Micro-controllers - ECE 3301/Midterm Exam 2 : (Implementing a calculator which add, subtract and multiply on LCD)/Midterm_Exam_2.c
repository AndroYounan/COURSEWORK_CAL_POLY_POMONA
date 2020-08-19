/* 
 * File:   Midterm_Exam_2.c
 * Author: Andro Younan
 *
 * Created on July 28, 2020, 9:20 AM
 */

#include <stdio.h>
#include <stdlib.h>
#include "LiquidCrystal.h"
#include "config.h"
# define _XTAL_FREQ 1000000
# define SW0 PORTDbits.RD3
# define SW1 PORTDbits.RD4
/*
 * 
 */
void __interrupt() adc_sample(void);
volatile signed long long int L_num;
volatile signed long long int R_num;

int main() 
{
// Configure LCD Pins
    // Data pins connected to PORTB
    TRISB = 0x00; 
    
    // RS = RD0
    // RW = RD1
    // E  = RD2
    // switches D3 and D4 are inputs 
    TRISDbits.RD0 = 0;
    TRISDbits.RD1 = 0;
    TRISDbits.RD2 = 0;
    TRISDbits.RD3 = 1;
    TRISDbits.RD4 = 1;
    
//    INTCON = 0x00;
    // connect the LCD pins to the appropriate PORT pins
    pin_setup(&PORTB, &PORTD);
    
    // initialize the LCD to be 16x2 (this is what I have, yours might be different)
    begin(16, 2, LCD_5x8DOTS);

 //--------------------------------------------------------------------------
    // 1 - Configure the A/D Module
// * Configure analog pins, voltage reference and digital I/O 
    // Reference voltages are VSS and VDD
    ADCON1 = 0x0D;
    TRISAbits.RA0 = 1; // connected to left-potentiometer
    TRISAbits.RA1 = 1; // connected to right-potentiometer
// * Select A/D acquisition time
    // * Select A/D conversion clock
    // Right justified, ACQT = 2 TAD, ADCS = FOSC/2
    ADCON2bits.ADCS = 0; // FOSC/2
    ADCON2bits.ACQT = 1; // ACQT = 2 TAD
    ADCON2bits.ADFM = 1; // right justified
// * Select A/D input channel
    ADCON0bits.CHS = 0; // Channel 0 (AN0), starting with the left-potentiometer
// * Turn on A/D module
    ADCON0bits.ADON = 1;   
    
    // 2 - Configure A/D interrupt
    // * Clear ADIF bit
    // * Set ADIE bit
    // * Select interrupt priority ADIP bit
    // * Set GIE bit
    
    PIR1bits.ADIF = 0;
    PIE1bits.ADIE = 1;
    IPR1bits.ADIP = 1;
    RCONbits.IPEN = 0; // disable priority levels
    INTCONbits.PEIE = 1; // enable peripheral interrupts
    INTCONbits.GIE = 1;
    
    // 3 - Wait the required acquisition time (if required)
    // ---> using ACQT = 2 TAD, no need to manually specify a wait    
 
    while(1)
    {
        // 4- Start conversion: Set GO/DONE(bar) bit
        ADCON0bits.GO = 1;   
        if (SW0 == 0 && SW1 == 0) // ( if --> 0 Clear LCD ) 
        {
            home();
            clear();
        } 
        else if (SW0 == 1 && SW1 == 0) // ( if 1 --> ADD )
        {
            home();
            print("(");
            print_int(L_num);
            print(")+(");
            print_int(R_num);
            print(")=");
            print("       ");
        setCursor(0, 1);
            print_int(L_num+R_num);
            print("       ");   
        }    
        else if ((SW0 == 0) && (SW1 == 1)) // ( if 2 --> Subtract )
        {
            home();
            print("(");
            print_int(L_num);
            print(")-(");
            print_int(R_num);
            print(")=");
            print("       ");
        setCursor(0, 1);
            print_int(L_num-R_num);
            print("       ");    
        }else // ( if 3 --> Multiply ) 
        {
            home();
            print("(");
            print_int(L_num);
            print(")*(");
            print_int(R_num);
            print(")=");
            print("       ");
        setCursor(0, 1);
            print_int(L_num*R_num);
            print("       ");      
        }                          
    }
    // 7 - Go to Step 1 or Step 2 as required  
    return 0;
}
void __interrupt() adc_sample(void)
{
    // test which interrupt called this interrupt service routine
    
    // ADC Interrupt
    if (PIR1bits.ADIF && PIE1bits.ADIE)
    {
        // 5 Wait for A/D conversion to complete by
        // * Waiting for the A/D interrupt
  
        // 6 - Read A/D result registers (ADRESH:ADRESL); clear bit ADIF, if required
        
        // reset the flag to avoid recursive interrupt calls
        PIR1bits.ADIF = 0;
        
        if (ADCON0bits.CHS == 0) // channel AN0 (L-potentiometer)
        {
            L_num = (ADRESH << 8) | ADRESL;
            L_num = L_num - 511; 
            ADCON0bits.CHS = 1;
        }
        else if (ADCON0bits.CHS == 1) // channel AN1 (R-potentiometer)
        {
            R_num = (ADRESH << 8) | ADRESL;
            R_num = R_num - 511;
            ADCON0bits.CHS = 0;
        }
}
}
