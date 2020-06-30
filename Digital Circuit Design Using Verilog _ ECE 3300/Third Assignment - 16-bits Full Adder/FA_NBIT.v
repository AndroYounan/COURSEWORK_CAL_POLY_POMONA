`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal State University Polytechnic Pomona
// Engineer: Andro Younan
// 
// Create Date: 06/28/2020 11:42:50 AM
// Design Name: Full Adder (N-bits)
// Module Name: FA_NBIT
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


module FA_NBIT #(parameter SIZE = 16)
               (
                input [SIZE-1:0] I,
                input En,
                input CI,
                input sel,
                output  [SIZE-1:0] SUM,
                output  CO
                );
                
        wire [SIZE:0] wire_RCA;
        assign wire_RCA[0] = CI;  
        assign CO = wire_RCA[SIZE];  
       
        genvar i;
        for (i=0; i<SIZE; i=i+1)
        begin      
        FA Block(
                 .I(I[i]),
                 .En(En),
                 .CI(wire_RCA[i]),
                 .sel(sel),
                 .SUM(SUM[i]),
                 .CO(wire_RCA[i+1])
                 ); 
        end            
endmodule
