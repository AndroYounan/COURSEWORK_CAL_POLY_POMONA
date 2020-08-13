`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2020 06:56:54 PM
// Design Name: 
// Module Name: Shifter_Rotator_Left_Right
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


module Shifter_Rotator_Left_Right #(parameter n = 16)
                                                    (
                                                    input [n-1:0] in,
                                                    output reg [n-1:0] op1,
                                                    output reg [n-1:0] op2,
                                                    output reg [n-1:0] op3,
                                                    output reg [n-1:0] op4,
                                                    output reg [n-1:0] result,
                                                    input [$clog2(n)-1:0] s,
                                                    input [1:0] Sh_Ro_L_R
                                                    );
       wire [n-1:0] op_SL;
       wire [n-1:0] op_SR;
       wire [n-1:0] op_RL;
       wire [n-1:0] op_RR;
       wire [n-1:0] op1_SL;wire [n-1:0] op1_SR;wire [n-1:0] op1_RL;wire [n-1:0] op1_RR;
       wire [n-1:0] op2_SL;wire [n-1:0] op2_SR;wire [n-1:0] op2_RL;wire [n-1:0] op2_RR;
       wire [n-1:0] op3_SL;wire [n-1:0] op3_SR;wire [n-1:0] op3_RL;wire [n-1:0] op3_RR;
       wire [n-1:0] op4_SL;wire [n-1:0] op4_SR;wire [n-1:0] op4_RL;wire [n-1:0] op4_RR;
       Shift_Left #(.n(n)) SL
                                    (
                                    .in(in),
                                    .op1(op1_SL),
                                    .op2(op2_SL),
                                    .op3(op3_SL),
                                    .op4(op4_SL),
                                    .result(op_SL),
                                    .s(s)
                                    );
       Shift_Right #(.n(n)) SR
                                    (
                                    .in(in),
                                    .op1(op1_SR),
                                    .op2(op2_SR),
                                    .op3(op3_SR),
                                    .op4(op4_SR),
                                    .result(op_SR),
                                    .s(s)
                                    );                             
       Rotate_Left #(.n(n)) RL
                                    (
                                    .in(in),
                                    .op1(op1_RL),
                                    .op2(op2_RL),
                                    .op3(op3_RL),
                                    .op4(op4_RL),
                                    .result(op_RL),
                                    .s(s)
                                    );
       Rotate_Right #(.n(n)) RR
                                    (
                                    .in(in),
                                    .op1(op1_RR),
                                    .op2(op2_RR),
                                    .op3(op3_RR),
                                    .op4(op4_RR),
                                    .result(op_RR),
                                    .s(s)
                                    );
       always @ (*)
        begin
            case (Sh_Ro_L_R)
                2'b00: 
                begin result = op_SL; op1=op1_SL; op2=op2_SL; op3=op3_SL; op4=op4_SL; end //Shift_Left
                2'b01: 
                begin result = op_SR; op1=op1_SR; op2=op2_SR; op3=op3_SR; op4=op4_SR; end //Shift_Right
                2'b10:
                begin result = op_RL; op1=op1_RL; op2=op2_RL; op3=op3_RL; op4=op4_RL; end //Rotate_Left
                2'b11:
                begin result = op_RR; op1=op1_RR; op2=op2_RR; op3=op3_RR; op4=op4_RR; end //Rotate_Right             
            endcase
        end                                                                                                                                                                   
endmodule
