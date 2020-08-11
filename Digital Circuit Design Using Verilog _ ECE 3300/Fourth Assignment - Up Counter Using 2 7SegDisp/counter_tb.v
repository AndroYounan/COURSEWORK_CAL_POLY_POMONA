`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2020 10:57:59 PM
// Design Name: 
// Module Name: counter_tb
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


module counter_tb( );
       reg mclk_tb = 1,clr_tb,pause_tb;
       wire [6:0] a_to_g_tb;
       wire [7:0] AN_tb;
       wire dp_tb;
       UpCounter7Seg block(
                    .mclk(clk_tb),
                    .clr(clr_tb),
                    .pause(pause_tb),
                    .a_to_g(a_to_g_tb),
                    .AN(AN_tb),
                    .dp(dp_tb)
                     );
       always
        begin
        #5 mclk_tb = ~ mclk_tb;
        end
       initial
        begin
            clr_tb = 0;
            pause_tb = 0;
           #50
            pause_tb = 1;
           #50
            pause_tb = 0;
           #50
            clr_tb = 1;
           #50
            clr_tb = 0;
           #50
           $finish;     
        end 
endmodule
