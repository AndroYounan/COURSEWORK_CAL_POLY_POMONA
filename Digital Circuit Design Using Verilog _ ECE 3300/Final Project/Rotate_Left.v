`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2020 12:16:09 AM
// Design Name: 
// Module Name: Rotate_Left
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


module Rotate_Left #(parameter n = 16)
                                    (
                                    input [n-1:0] in,
                                    output [n-1:0] op1,
                                    output [n-1:0] op2,
                                    output [n-1:0] op3,
                                    output [n-1:0] op4,
                                    output reg [n-1:0] result,
                                    input [$clog2(n)-1:0] s
                                    );
       //**SAME AS Shift_Left but wire zero is replaced with the last bit of the input**\\
/* ------------------------------------------------------ */
/*                    Stage #1                            */
/* ------------------------------------------------------ */                                   
       mux_2to1 Stage1_1stblock
                     (
                        .in1(in[0]),
                        .in2(in[n-1]),
                        .s(s[0]),
                        .op(op1[0])
                     );
       genvar a;
       for (a=0; a<n-1; a=a+1)
        begin
            mux_2to1 Stage1_Remaining_blocks
                     (
                        .in1(in[a+1]),
                        .in2(in[a]),
                        .s(s[0]),
                        .op(op1[a+1])
                     );     
        end
/* ------------------------------------------------------ */
/*                    Stage #2                            */
/* ------------------------------------------------------ */ 
       genvar b;
       for (b=0; b<2; b=b+1)
        begin
            mux_2to1 Stage2_1st2blocks
                     (
                        .in1(op1[b]),
                        .in2(op1[b+2]),
                        .s(s[1]),
                        .op(op2[b])
                     );     
        end
       genvar c; 
       for (c=0; c<n-2; c=c+1)
        begin
            mux_2to1 Stage2_Remaining_blocks
                     (
                        .in1(op1[c+2]),
                        .in2(op1[c]),
                        .s(s[1]),
                        .op(op2[c+2])
                     );     
        end
/* ------------------------------------------------------ */
/*                    Stage #3                            */
/* ------------------------------------------------------ */ 
       genvar d;
       for (d=0; d<4; d=d+1)
        begin
            mux_2to1 Stage3_1st4blocks
                     (
                        .in1(op2[d]),
                        .in2(op1[b+4]),
                        .s(s[2]),
                        .op(op3[d])
                     );     
        end
       genvar e; 
       for (e=0; e<n-4; e=e+1)
        begin
            mux_2to1 Stage3_Remaining_blocks
                     (
                        .in1(op2[e+4]),
                        .in2(op2[e]),
                        .s(s[2]),
                        .op(op3[e+4])
                     );     
        end 
/* ------------------------------------------------------ */
/*                    Stage #4                            */
/* ------------------------------------------------------ */ 
       genvar f;
       for (f=0; f<8; f=f+1)
        begin
            mux_2to1 Stage4_1st8blocks
                     (
                        .in1(op3[f]),
                        .in2(op1[b+8]),
                        .s(s[3]),
                        .op(op4[f])
                     );     
        end
       genvar g; 
       for (g=0; g<n-8; g=g+1)
        begin
            mux_2to1 Stage4_Remaining_blocks
                     (
                        .in1(op3[g+8]),
                        .in2(op3[g]),
                        .s(s[3]),
                        .op(op4[g+8])
                     );     
        end
       always @ (*)
        begin
            case (s)
                0 : result = in;
                1 : result = op1;
                2 : result = op2;
                3 : result = op2;
                4 : result = op3;
                5 : result = op3;
                6 : result = op3;
                7 : result = op3;
                8 : result = op4;
                9 : result = op4;
                'hA : result = op4;
                'hB : result = op4;
                'hC : result = op4;
                'hD : result = op4;
                'hE : result = op4;
                'hF : result = op4;
                default : result = in; // default case --> the input will be printed
            endcase        
        end                             
endmodule
