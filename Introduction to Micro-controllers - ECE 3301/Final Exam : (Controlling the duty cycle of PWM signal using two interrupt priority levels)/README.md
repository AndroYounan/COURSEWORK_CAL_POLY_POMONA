# Final Exam : (Controlling the duty cycle of PWM signal using two interrupt priority levels)

## Instructions that I followed for this lab :
The data pins of the LCD must be connected to `PORTD`.\
The 3 signal pins of the LCD must be connected to the 3 least significant bits of `PORTE`.\
The wiper (middle) pin of the potentiometers must be connected to `AN0` and `AN1`.\
The other pins of the potentiometers must be connected to +5V and 0V.\
The emergency stop push button must be connected to `INT0`.\
The PWM signal must be generated using CCP2. The signal must be connected to a DC motor and green LED.\
The emergency stop LED (red LED) must be connected to `RB1`.\
I used two interrupt priority levels.\
The high interrupt should only handle interrupts coming from `INT0`, which is stopping the system and turning on the red LED.\
The low interrupt should contain code to handle the ADC and Timer0 interrupts.\
I had to set **Timer0** to generate interrupts every 10 ms, each time this interrupt is invoked I change the motor speed (or the duty cycle of the PWM signal).\
The delay should range from 0 ms to 10240 ms, in other words I had to take the ADC input and multiply it by 10 ms.\
The motor speed should range from 0 to 1024.

## Note
I have written this code using [MPLAB X IDE v5.40](https://www.microchip.com/mplab/mplab-x-ide)

