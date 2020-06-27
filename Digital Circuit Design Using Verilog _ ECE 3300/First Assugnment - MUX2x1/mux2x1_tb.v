`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2020 04:50:27 PM
// Design Name: 
// Module Name: mux2x1_tb
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


module mux2x1_tb(

                 );
                 reg [3:0] A_SW;
                 reg [3:0] B_SW;
                 reg  Sel;
                 wire [3:0]LED;
            mux2x1 TB_TESTING (.A(A_SW),
                               .B(B_SW),
                               .S(Sel),
                               .F(LED)
                              );
            initial
              begin
              A_SW = 4'b0000;
              B_SW = 4'b1111;
              Sel = 1'b0;
              // F is 0000
              #10
              A_SW = 4'b0000;
              B_SW = 4'b1111;
              Sel = 1'b1;
              // F is 1111
              #10
              A_SW = 4'b1001;
              B_SW = 4'b0110;
              Sel = 1'b0;
              // F is 1001
              #10
              A_SW = 4'b1001;
              B_SW = 4'b0110;
              Sel = 1'b1;
              // F is 0110
              #10
              $finish;
              end              
endmodule
