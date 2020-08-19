# Lab 7 and 8 : (Polled IO Vs Interrupt IO)

## Instructions that I followed for this lab :
In both labs, I have done the same thing using the same circuit but using 2 different approaches, namely Polled I/O and interrupt I/O.

I had to use one of the analog comparators inside an LM339 to compare Vx and Vy.\
When Vx > Vy the output of the comparator will be set to +5V ; whereas, it is 0 if Vx < Vy.\
The microcontroller will take the output of the comparator as an input to its `RB1`, it will then turn on/off the led on its `RD1` to match the output of the comparator, namely LED is on when Vx > Vy and LED is off when Vx < Vy.\
for lab 7, I have written assembly and c-code using Polled I/O.\
for lab 8, I have written assembly and c-code using Interrupt I/O.

## Note
I have written this code using [MPLAB X IDE v5.40](https://www.microchip.com/mplab/mplab-x-ide)
