`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/19/2020 04:49:32 PM
// Design Name: 
// Module Name: Decoder4x16_tb
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


module Decoder4x16_tb(

                      );
       reg [3:0] X_tb;
       reg En_tb;
       wire [15:0] Y_tb;               
       
       Decoder4x16 decoder (
                           .X(X_tb),.En(En_tb),.Y(Y_tb)
                           );
       integer i;                    
       initial
            begin
                for (i=0;i<16;i=i+1)
                    begin
                       #100 
                        X_tb  = i;
                        En_tb = 1'b1;   
                    end
//                En_tb = 1'b0;
//                X_tb  = 4'h0;
//               #10
//                X_tb  = 4'h1;
//               #10
//                X_tb  = 4'h6;
//               #10
//                X_tb  = 4'hC;
//               #10
//                En_tb = 1'b1;
//                X_tb  = 4'h0;
//               #10
//                X_tb  = 4'h1;
//               #10
//                X_tb  = 4'h6;
//               #10
//                X_tb  = 4'hC;
//               #10
               $finish;
            end
                           
endmodule
