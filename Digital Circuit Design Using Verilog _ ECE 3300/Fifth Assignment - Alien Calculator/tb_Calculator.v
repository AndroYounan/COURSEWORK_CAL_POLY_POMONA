`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2020 03:23:02 PM
// Design Name: 
// Module Name: tb_Calculator
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


module tb_Calculator();
    reg [4:0] tb_A = 0, tb_B = 0; 
    reg [1:0] tb_Calc = 0;
    wire [7:0] tb_Result;
    wire tb_Neg; 
    
    Calculator uut(
        .i_A(tb_A),
        .i_B(tb_B),
        .i_Calc(tb_Calc),
        .o_Result(tb_Result),
        .o_Neg(tb_Neg)); 
  
/* -------------------------------------------------------------------------------- */  
/*  Using 4 for-loops, able to test all possible combinations.                      */
/*  32 was used since the inputs i_A and i_B are 5 bits each.                       */ 
/*  2 for-loops with 32, one for i_A and the other for i_B.                         */
/*  3 was used since there are 3 modes of operations for i_Calc.                    */
/* -------------------------------------------------------------------------------- */    
    
    integer i, j, k, l;
     
    initial begin
        for(i = 0; i < 32 * 32 * 3; i = i + 1) begin
            for(j = 0; j < 3; j = j + 1) begin
                for(k = 0; k < 32; k = k + 1) begin
                    for(l = 0; l < 32; l = l + 1) begin
                        #5 tb_Calc = j; tb_A = k; tb_B = l; 
                    end
                end
            end
        end
    end
endmodule

