/* 
 * File:   Final_Exam.c
 * Author: Andro Younan
 *
 * Created on August 3, 2020, 8:10 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include "config.h"
#include "LiquidCrystal.h"

#define _XTAL_FREQ 1000000
#define Button     PORTBbits.RB0    // input
#define GreenLED   PORTCbits.RC1    // output , this is where the DC motor is connected too
#define  RedLED    PORTBbits.RB1    // output
// interrupts' prototypes
void __interrupt (low_priority)  motor_interrupt(void);
void __interrupt (high_priority) emergency_interrupt(void);
// declaring variables
volatile signed long long int Maxspeed;
volatile signed long long int Delay;

int main()
{
    // setup the LCD data (output)
    TRISD = 0x00;
    // setup the signal pins (output)
    TRISEbits.RE0 =0; // RS = RE0
    TRISEbits.RE1 =0; // RW = RE1
    TRISEbits.RE2 =0; // E  = RE2
    // connect the LCD pins to the appropriate PORT pins
     pin_setup(&PORTD, &PORTE);
    // initialize the LCD to be 16x2
    begin(16, 2, LCD_5x8DOTS);
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
    //*** (((( Setup the ADC )))) ***\\
// 1 - Configure the A/D Module
    // Configure analog pins, voltage reference and digital I/O
    ADCON1 = 0x0D;
    TRISAbits.RA0 = 1; // 1st potentiometer (MaxSpeed) is input
    TRISAbits.RA1 = 1; // 2nd potentiometer (Delay) is input

    // Select A/D conversion clock
    ADCON2bits.ADCS = 0; // FOSC/2
    // Select A/D acquisition time
    ADCON2bits.ACQT = 1; // ACQT = 2 TAD
    ADCON2bits.ADFM = 0; // left justified
    // ADCON2bits.ADFM = 1; // right justified
    
    // Select A/D input channel (we will be using TWO)
    ADCON0bits.CHS = 0; // will start the program sampling Channel 0 (AN0) 

    // Turn on A/D module
    ADCON0bits.ADON = 1;
// 2 - Configure A/D interrupt 
    PIR1bits.ADIF = 0;  // * Clear ADIF bit
    PIE1bits.ADIE = 1;  // * Set ADIE bit
    IPR1bits.ADIP = 0;  // * Select interrupt priority ADIP bit (low priority)
    //set up interrupt priorities
    RCONbits.IPEN =1;   // Enable priority levels
    INTCONbits.GIE = 1; // Global interrupt enable
    INTCONbits.GIEH =1; // Enable all high priority
    INTCONbits.GIEL =1; // Enable all low priority
    INTCONbits.PEIE =1; // Enable peripheral interrupts
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    //setup emergency_interrupt ***(INT0)***
    INTCONbits.INT0E = 1;    // enable the interrupt
    INTCONbits.INT0F = 0;    // resets the flag                                                
    INTCON2bits.INTEDG0 = 0; // falling edge
    //INTCON2bits.INTEDG0 = 1; // rising edge
    TRISBbits.RB0 = 1; // the button itself is input
    TRISBbits.RB1 = 0; // the RedLED is output
    RedLED=0;          // start the program with the RedLED OFF 
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    // setup timer0 
    T0CONbits.PSA = 1;    // prescaler is not assigned
    T0CONbits.T0CS = 0;   // clock source is internal instruction cycle
    T0CONbits.T08BIT = 0; // operate in 16 bits mode
    T0CONbits.TMR0ON = 1; // Turn on timer0
    TMR0 = 63037;         // timer0 starts at this value to achieve 10ms delay 
    //timer0 Interrupt
    INTCONbits.TMR0IE = 1;  // enable the interrupt
    INTCONbits.TMR0IF = 0;  // reset the flag to zero
    INTCON2bits.TMR0IP = 0; // set timer0 interrupt to low priority
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
    //*** (((( Setup the PWM signals )))) ***\\
    // - PR2 - calculating the value that Timer2 will stop at using: 
    // Frequency of 1 KHz
    // So PWM Period = 1x10^-3 Second
    PR2 =  249;
    // setup timer 2
    // FOSC = 1 MHz
    T2CONbits.T2CKPS = 0b00; // prescaler 1:1
    T2CONbits.TMR2ON = 1;    // turn on Timer2
    // setup CCP2 in PWM mode
    TRISCbits.RC1 = 0;
    CCP2CONbits.CCP2M = 0b1100;
    
    while(1)
        {
            // 4 - Start conversion
            ADCON0bits.GO = 1;

            home();
            print("MaxSpeed: ");
            print_int(Maxspeed);
            print("     ");

            setCursor(0,1);
            print("Delay: ");
            print_int(Delay*10); // multiplied by 10 so we can get value from 0ms to 10240ms
            print(" ms");
            print("     "); 
        } 
    
    return 0;
}

// *** The Interrupt service routines *** \\

void __interrupt (high_priority) emergency_interrupt(void)
{
    // test which interrupt called this Interrupt Service Routine
    // ---> INT0
    if(INTCONbits.INT0E && INTCONbits.INT0IF)
    {
       INTCONbits.INT0IF =0; // Turn off the interrupt flag to avoid recursive interrupts
        
       clear();  // clears LCD
        
       TRISCbits.RC1 = ~TRISCbits.RC1; //toggle GreenLED --> so that the first push will take us to the (first if) and the one after will take us to the (second if) and so on
       
       RedLED=0; //set off
       
        while(INTCONbits.INT0IF == 0) // while the interrupt flag is down --> so that we remain in the interrupt until the flag becomes high by another push for the button, but will go for the other if statement
        {
            if (GreenLED == 0)
            {     
                RedLED= 1;
                clear();
                print("     Stopping!   ");
                print("      ");
                home();
            }  
            else if(GreenLED == 1)
            {
                RedLED = 0;
                goto out;
            }
        }       
out:
      return;
    }
}

void __interrupt(low_priority) motor_interrupt(void)
{
    if (PIR1bits.ADIF && PIE1bits.ADIE)
    {
        // test which interrupt called this Interrupt Service Routine
        // ---> ADC
        PIR1bits.ADIF = 0; // Turn off the interrupt flag to avoid recursive interrupts
        if (ADCON0bits.CHS == 0)
        {
            Maxspeed = (ADRESH << 2) | ADRESL; 
            
            ADCON0bits.CHS = 1; // switch to the other channel
        }
        else if (ADCON0bits.CHS == 1)
        {
           Delay = ((ADRESH << 2) | ADRESL);	          
          
           ADCON0bits.CHS = 0; // switch to the other channel
        }
    }
    else if(INTCONbits.TMR0IE && INTCONbits.TMR0IF)
    {	
        // test which interrupt called this Interrupt Service Routine
        // ---> TMR0
        INTCONbits.TMR0IF = 0; // Turn off the interrupt flag to avoid recursive interrupts
        CCPR2L = ADRESH;
        CCP2CONbits.DC2B = ((ADRESL >> 6) & 0x03);
    }
    return;    
}

