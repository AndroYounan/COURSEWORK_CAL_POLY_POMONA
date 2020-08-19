# Midterm Exam 2 : (Implementing a calculator which add, subtract and multiply on LCD)

## Instructions that I followed for this lab :
The data pins of the LCD must be connected to `PORTB`. (the `LVP` config bit has to be set to OFF inside `config.h`).\
The 3 signal pins of the LCD must be connected to the 3 least significant bits of `PORTD`.\
The DIP switches must be connected to `PORTD` pins, specifically `RD3` and `RD4`.\
The wiper (middle) pin of the potentiometers must be connected to `AN0` and `AN1`.\
The other pins of the potentiometers must be connected to +5V and 0V.
* Switch Pattern:
  `0`: Display is off.\
  `1`: Add the two signed integers.\
  `2`: Subtract the two signed integers.\
  `3`: Multiply the two signed integers.

## Note
I have written this code using [MPLAB X IDE v5.40](https://www.microchip.com/mplab/mplab-x-ide)

