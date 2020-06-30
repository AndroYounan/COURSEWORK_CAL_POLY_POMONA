# Lab 3: Third Assignment - 16-bits Full Adder

A 1-bit full adder is a combinational circuit that adds three inputs and produces two outputs. The first two inputs are (A) and (B) and the third input is the carry in (CI). The outputs are the (SUM) and the carry out (CO).\ 

## Instructions for this lab :

Design and implement 16-bits adder with an enable on FPGA.

## Notes

In order to achieve that, I have designed a 1-bit adder as if I have only one switch for my input. So, I have used (2x1) multiplexer and two (16-bits) registers, so I always get to choose whether I want my input to represent A or B by a using a push button (LEFT).\
Then I have created the N-bits Full Adder where I declared my parameter to be 16 and instantiated my 1-bit adder 16 times using a for loop.\
Also, I have used another push button (CENTER) as an enable for the whole circuit.\
The carry-in is implemented using a push button too (UP).\

A binary decoder is a multi-input, multi-output combinational circuit that converts a binary code of n input lines into a one output of 2n output line. These are used when there is need to activate exactly one of 2n output based on an n-bit input value. 

Generally, decoders are provided with enable inputs to activate the device, and we are going to design our decoder with active high enable. When the enable is logically one the decoder will be activated and the output will be based on the inputs, and when the enable is logically zero, the device will be deactivated regardless of its inputs.

For simplicity we will provide 4-bit input bus instead of 4 different inputs and one 16-bit output instead of 16 different outputs.

In this assignment, I have used Verilog [version 2019.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2019-2.html) to model and implement the functionality of this design.\
Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
