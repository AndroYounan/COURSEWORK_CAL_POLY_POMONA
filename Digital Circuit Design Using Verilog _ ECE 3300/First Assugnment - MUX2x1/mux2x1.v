`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CPP
// Engineer: Andro Younan
// 
// Create Date: 06/09/2020 04:44:34 PM
// Design Name: MUX 2X1
// Module Name: mux2x1
// Project Name: MUX 2X1
// Target Devices: FPGA NEXYS A7 100T
// Tool Versions: 2019.2
// Description: Modeling the functionality of a MUX 2x1
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux2x1(
                input wire [3:0] A,
                input wire [3:0] B,
                input wire S,
                output wire [3:0] F
              );
           assign F [0]= ( A[0] & ~S ) | ( B[0] & S );
           assign F [1]= ( A[1] & ~S ) | ( B[1] & S );
           assign F [2]= ( A[2] & ~S ) | ( B[2] & S );
           assign F [3]= ( A[3] & ~S ) | ( B[3] & S );
           
endmodule
