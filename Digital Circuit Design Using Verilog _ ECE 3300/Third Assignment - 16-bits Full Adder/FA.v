`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal State University Polytechnic Pomona
// Engineer: Andro Younan
// 
// Create Date: 06/28/2020 11:40:15 AM
// Design Name: Full Adder (1-bit)
// Module Name: FA
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


module FA(
            input I,
            input En,
            input CI,
            input sel,
            output reg SUM,
            output reg CO
          );
          reg A , B;
       always@(*)
            begin
                if (En)
                    begin
                        case (sel)
                        0 : A = I;
                        1 : B = I;
                        endcase
                        SUM = A ^ B ^ CI;
                        CO  = (A&B) | (A&CI) | (B&CI);
                    end  
                else
                    begin
                        SUM = 1'b0;
                        CO  = 1'b0;
                        A   = 1'b0;
                        B   = 1'b0;
                    end  
            end   
endmodule
