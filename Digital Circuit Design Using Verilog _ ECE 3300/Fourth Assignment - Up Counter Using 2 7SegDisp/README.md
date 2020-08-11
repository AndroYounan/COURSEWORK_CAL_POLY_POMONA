# Lab 4: Fourth Assignment - Up Counter Using 2 7SegDisp

we are implementing the use of two BCD counters in this assignment

## Instructions for this lab :

Only the first and the last 7 segment display on the board will be turned in use while the rest have to remain off all the time.

The digit on the right has to count up from 0 to 9 and repeats it self. The digit on the left starts at 0 and gets increased by 1 every time the digit on the right moves from 9 to 0. When the left digit reaches 9, it will repeat the same process. 
Design and implement 16-bits adder with an enable on FPGA.

## Notes

In order to achieve that, I have used the last 3-bits in 20-bits counter so that the 8 digits can be driven once every 10.48 ms which considered acceptable for our eys to distinguish.

I have used the first switch as reset when it is high and the last switch as pause when it is high. 

In this assignment, I have used [Verilog 2019.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2019-2.html) to model and implement the functionality of this design.

Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
