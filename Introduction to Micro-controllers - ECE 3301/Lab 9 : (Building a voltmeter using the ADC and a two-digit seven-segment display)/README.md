# Lab 9 : (Building a voltmeter using the ADC and a two-digit seven-segment display)

## Instructions that I followed for this lab :
In this lab, I had to utilize one of the ADC channels to build the voltmeter.\
Since I do not have a variable power supply for testing, I had to build a voltage divider using a single potentiometer. The pins should be connected to +5V, 0V, and the wiper (middle) pin should be connected to pin `AN0` on the MicroController.\
The MicroController should be outputting the measured voltage as two BCD digits. The digits should be output on `PORTB`. i.e. the 4 least significant bits of `PORTB` should output the fractional voltage number and the 4 most significant digits of `PORTB` should output the whole voltage number.\
In order to use all pins of `PORTB`, specifically `RB5`, we should modify the `LVP` configuration bit to `OFF`.\
The two-digit seven-segment displays should be connected to two 7447 decoder ICs.\
The pins of `PORTB` are connected to the appropriate input on the 7447 decoders.

## Note
I have written this code using [MPLAB X IDE v5.40](https://www.microchip.com/mplab/mplab-x-ide)
