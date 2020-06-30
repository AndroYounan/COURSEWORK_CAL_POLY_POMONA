`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal State University Polytechnic Pomona
// Engineer: Andro Younan
// 
// Create Date: 06/28/2020 01:03:51 PM
// Design Name: Full Adder (16-bits) Test Bench 
// Module Name: FA_NBIT_tb
// Project Name: Full Adder (16-bits)
// Target Devices: Nexys A7-100t
// Tool Versions: 2019.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module FA_NBIT_tb #(parameter SIZE_tb = 16)
                 (
                  );
       reg [SIZE_tb-1:0] I_tb;
       reg En_tb, CI_tb, sel_tb;
       wire [SIZE_tb-1:0] SUM_tb;
       wire CO_tb;           
       FA_NBIT #(.SIZE(SIZE_tb)) BLOCK 
               (
                .I(I_tb),
                .En(En_tb),
                .CI(CI_tb),
                .sel(sel_tb),
                .SUM(SUM_tb),
                .CO(CO_tb)
                );
       initial
            begin
                En_tb = 1'b0;
                I_tb  = 16'd500;
                CI_tb = 1'b0;
                sel_tb= 1'b0;
               #10 
                En_tb = 1'b1;
                I_tb  = 16'd500;
                CI_tb = 1'b0;
                sel_tb= 1'b0;
               #10 
                En_tb = 1'b1;
                I_tb  = 16'd400;
                CI_tb = 1'b0;
                sel_tb= 1'b1;
               #10 
                En_tb = 1'b1;
                I_tb  = 16'd400;
                CI_tb = 1'b1;
                sel_tb= 1'b1;
               #10 
                En_tb = 1'b1;
                I_tb  = 16'd300;
                CI_tb = 1'b0;
                sel_tb= 1'b1;
               #10 
                En_tb = 1'b1;
                I_tb  = 16'd32800;
                CI_tb = 1'b0;
                sel_tb= 1'b0;
               #10
                En_tb = 1'b1;
                I_tb  = 16'd32800;
                CI_tb = 1'b0;
                sel_tb= 1'b1;
               #10
               En_tb = 1'b0;
                I_tb  = 16'd32800;
                CI_tb = 1'b0;
                sel_tb= 1'b1;
               #10
                En_tb = 1'b1;
                I_tb  = 16'd3;
                CI_tb = 1'b0;
                sel_tb= 1'b0;
               #10
                En_tb = 1'b1;
                I_tb  = 16'd5;
                CI_tb = 1'b1;
                sel_tb= 1'b1;
               #10 
                $finish;  
            end                    
endmodule
