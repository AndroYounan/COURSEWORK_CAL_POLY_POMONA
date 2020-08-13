# Lab 5: Fifth Assignment - Alien Calculator

In this lab, I am designing a claculator which is able to add, subtract, and multiply two signed numbers using alien signs for positive and negative.

## Instructions for this lab :

Digit #1 represents the first input. Digit #2 represents the first input'sign. Digit #s represents the second input. Digit #4 represents the second input's sign.

Digit #5 on the board has to be turned off all the time. 

Digit #6 & #7 represent the result. Digit #8 represents the result's output.

## Notes

In order to achieve that, I have used the last 3-bits in 20-bits counter so that the 8 digits can be driven once every 10.48 ms which considered acceptable for our eys to distinguish.

I have used the first 4 switches to represent the first input, the fifth switch to represent the first input'sign. Same thing applies for the second input by using the next five switches.

the last two switches represent the mode selector.

In this assignment, I have used [Verilog 2019.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2019-2.html) to model and implement the functionality of this design.

Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
