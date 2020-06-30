# Lab 3: Third Assignment - 16-bits Full Adder

A 1-bit full adder is a combinational circuit that adds three inputs and produces two outputs. The first two inputs are (A) and (B) and the third input is the carry in (CI). The outputs are the (SUM) and the carry out (CO).

## Instructions for this lab :

Design and implement 16-bits adder with an enable on FPGA.

## Notes

In order to achieve that, I have designed a 1-bit Full Adder as if I have only one switch for my input. So, I have used (2x1) multiplexer and two (16-bits) registers, so I always get to choose whether I want my input to represent A or B by a using a push button (LEFT).\

Then I have created the N-bits Full Adder where I declared my parameter to be 16 and instantiated my 1-bit Full Adder 16 times using a for loop.\

Also, I have used another push button (CENTER) as an enable for the whole circuit. The carry-in is implemented using a push button too (UP).\

In this assignment, I have used Verilog [version 2019.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2019-2.html) to model and implement the functionality of this design.\

Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
