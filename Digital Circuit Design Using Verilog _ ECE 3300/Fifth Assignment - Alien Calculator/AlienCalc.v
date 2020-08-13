`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2020 04:49:18 PM
// Design Name: 
// Module Name: AlienCalc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AlienCalc(
    input sys_clk, 
    input [1:0] i_Calc, 
    input [4:0] i_A, i_B,
    output [7:0] o_enable,
    output [6:0] o_CAG,
    output o_DP
    );
    
   wire [7:0] Result; 
   wire isNeg; 
    
    assign o_DP = 1; 
    
    Calculator inst0(
        .i_A(i_A),
        .i_B(i_B),
        .i_Calc(i_Calc),
        .o_Result(Result),
        .o_Neg(isNeg)); 
    
    Display inst1(
        .sys_clk(sys_clk),
        .i_A(i_A),
        .i_B(i_B),
        .i_Result(Result),
        .i_Neg(isNeg),
        .o_CAG(o_CAG),
        .o_enable(o_enable));
    
endmodule

