`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal State University Polytechnic Pomona
// Engineer: Andro Younan
// 
// Create Date: 06/19/2020 04:37:19 PM
// Design Name: 4x16Decoder 
// Module Name: 4x16Decoder
// Project Name: 4x16Decoder
// Target Devices: Nexys A7 100t
// Tool Versions: 2019.2
// Description: Designing 4x16 decoder
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Decoder4x16(
                input [3:0] X,
                input En,
                output reg [15:0] Y
                  );
        always@(X or En)
            begin
            Y = 16'h0000;
            if (En)
                begin
                    case (X)
                        4'h0 : Y = 16'h0001;
                        4'h1 : Y = 16'h0002;
                        4'h2 : Y = 16'h0004;
                        4'h3 : Y = 16'h0008;
                        4'h4 : Y = 16'h0010;
                        4'h5 : Y = 16'h0020;
                        4'h6 : Y = 16'h0040;
                        4'h7 : Y = 16'h0080;
                        4'h8 : Y = 16'h0100;
                        4'h9 : Y = 16'h0200;
                        4'hA : Y = 16'h0400;
                        4'hB : Y = 16'h0800;
                        4'hC : Y = 16'h1000;
                        4'hD : Y = 16'h2000;
                        4'hE : Y = 16'h4000;
                        4'hF : Y = 16'h8000;
                    endcase    
                end
            end           
endmodule
