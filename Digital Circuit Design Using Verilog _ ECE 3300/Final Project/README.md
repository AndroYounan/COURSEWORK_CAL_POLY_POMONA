# Lab 6: Final Project - Barrel Shifter

In this lab, I need to shift/rotate left/right 15 bits up to 15 times.

## Instructions for this lab :

Create an X module which will allow to switch between an auto and manual mode for selecting the number of times we need to shift/rotate left/right.

## Notes

In order to achieve that, I have create 4 modules; one for each mode of operation we have. Then, I instantiated those 4 modules in a top module which is handling all the shifting/rotation left/ right.

This top module is instantiated in the top module along with the X module and a third module responsible for the display interface.

The comments inside each module describes how each design has been achieved.

In this assignment, I have used [Verilog 2019.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2019-2.html) to model and implement the functionality of this design.

Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
