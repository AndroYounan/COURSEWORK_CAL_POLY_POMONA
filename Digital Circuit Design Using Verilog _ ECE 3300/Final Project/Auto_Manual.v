`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2020 05:19:48 PM
// Design Name: 
// Module Name: Auto_Manual
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


module Auto_Manual(
                    input clk,
                    input load,
                    input auto,
                    input [3:0] s_sw,
                    output reg [3:0] s_op
                  );
       reg [33:0] clk_div;
       always @ (posedge clk or posedge auto or posedge load)
        begin
        clk_div <= clk_div + 1;
            if (auto)
                begin
                    if (load)
                        begin
                            clk_div [33:30] <= s_sw; 
                        end
                    else 
                        s_op <= clk_div [33:30];       
                end
            else
                s_op <= s_sw;    
        end            
endmodule
