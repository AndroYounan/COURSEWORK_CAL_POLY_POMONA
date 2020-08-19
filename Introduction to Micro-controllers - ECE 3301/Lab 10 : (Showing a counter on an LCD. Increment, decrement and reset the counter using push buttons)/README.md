# Lab 10 : (Showing a counter on an LCD. Increment, decrement and reset the counter using push buttons)

## Instructions that I followed for this lab :
I had to add a new function to the driver called `print_int`. The function accepts an integer argument and prints its value on the LCD.\
The LCD data pins are connected to `PORTA`.\
The 3 signal pins are connected to the LSb of `PORTD`.\
The 3 push buttons (along with their pull up resistors) are connected to the LSb of `PORTB`.\
The LCD should display the content of a signed integer counter. The push buttons should increment, decrement, and reset this counter.

## Note
I have written this code using [MPLAB X IDE v5.40](https://www.microchip.com/mplab/mplab-x-ide)
