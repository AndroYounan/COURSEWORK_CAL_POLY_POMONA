# Lab 2: Decoder 4x16

A binary decoder is a multi-input, multi-output combinational circuit that converts a binary code of n input lines into a one output of 2n output line. These are used when there is need to activate exactly one of 2n output based on an n-bit input value. \
Generally, decoders are provided with enable inputs to activate the device, and we are going to design our decoder with active high enable. When the enable is logically one the decoder will be activated and the output will be based on the inputs, and when the enable is logically zero, the device will be deactivated regardless of its inputs.\
For simplicity we will provide 4-bit input bus instead of 4 different inputs and one 16-bit output instead of 16 different outputs.\
In this assignment, I use Verilog to model and implement the functionality of the 4x16 decoder.\
Also, I have applied the code into [FPGA Nexys A7 100T](https://store.digilentinc.com/nexys-a7-fpga-trainer-board-recommended-for-ece-curriculum/)
