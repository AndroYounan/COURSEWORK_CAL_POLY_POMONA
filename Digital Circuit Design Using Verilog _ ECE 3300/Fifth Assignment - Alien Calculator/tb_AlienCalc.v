`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2020 03:22:09 PM
// Design Name: 
// Module Name: tb_AlienCalc
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


module tb_AlienCalc();
    reg sys_clk = 0; 
    reg [4:0] tb_A = 0, tb_B = 0; 
    reg [1:0] tb_Calc = 0; 
    wire [7:0] tb_enable;
    wire [6:0] tb_CAG; 
    
    AlienCalc uut(
        .sys_clk(sys_clk),
        .i_A(tb_A),
        .i_B(tb_B),
        .i_Calc(tb_Calc),
        .o_enable(tb_enable),
        .o_CAG(tb_CAG)); 

    integer i, j, k, l;
    
    always #5 sys_clk = ~sys_clk; 
     
    initial begin
        for(i = 0; i < 32 * 32 * 3; i = i + 1) begin
            for(j = 0; j < 3; j = j + 1) begin
                for(k = 0; k < 32; k = k + 1) begin
                    for(l = 0; l < 32; l = l + 1) begin
                        #10480000 tb_Calc = j; tb_A = k; tb_B = l; 
                    end
                end
            end
        end
        $finish;
    end
endmodule

