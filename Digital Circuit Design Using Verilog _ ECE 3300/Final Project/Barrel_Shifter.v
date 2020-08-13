`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/30/2020 08:48:16 PM
// Design Name: 
// Module Name: Barrel_Shifter_Top_Module
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


module Barrel_Shifter_Top_Module #(parameter n = 16)
                                (
                                 input [1:0] Sh_Ro_L_R,        // OPERATION_SWITCHES
                                 input clk,                    // CLK
                                 input load,                   // Push Button  
                                 input auto,                   // SWITCH A/M 
                                 input [3:0] s_sw,             // S_MANUAL_SWITCHES .. # of shifts and rotations
                        
                                 output [3:0] an,           // DIGITS_ON         //// removed reg
                                 output wire [3:0] an1,        // DIGITS_OFF 
                                 output  [6:0] a_to_g,      // 7_SEGMENTS           //////////
                                 output wire DP,               // DECIMAL_POINT 
                                 
                                 input [3:0] SW,               // INPUT (DEMUX_IN) 
                                 input [1:0] in_sel           // SELECTOR (DEMUX_IN)  ///// removed ,
                                );
       wire [n-1:0] result_wire; 
       wire [$clog2(n)-1:0] s_wire;
       wire [3:0] digit1_wire;
       wire [3:0] digit2_wire;
       wire [3:0] digit3_wire;
       wire [3:0] digit4_wire;
       wire [n-1:0] op1_wire;
       wire [n-1:0] op2_wire;
       wire [n-1:0] op3_wire;
       wire [n-1:0] op4_wire;                        
       Shifter_Rotator_Left_Right #(.n(n)) block1
                                                 (
                                                    .in({digit4_wire,digit3_wire,digit2_wire,digit1_wire}),//After the demux do its job, its OP values will get assigned to the input here so we can start operating on it
                                                    .op1(op1_wire),
                                                    .op2(op2_wire),
                                                    .op3(op3_wire),
                                                    .op4(op4_wire),
                                                    .result(result_wire), //This result goes to the DispInterface Module
                                                    .s(s_wire), //This gets its value from the s_op in Auto_Manual Module 
                                                    .Sh_Ro_L_R(Sh_Ro_L_R)
                                                 );
       Auto_Manual block2
                         (
                            .clk(clk),
                            .load(load),
                            .auto(auto),
                            .s_sw(s_sw),
                           // .sload_sw(sload_sw),
                            .s_op(s_wire)//This sends its value from to the (s) in the the Shifter_Rotator_Left_Right Module
                         );
       DispInterface_including_InputSelectorDeMux block3
                                                        (
                                                            // DispInterface
                                                            .clk(clk),
                                                            .op(result_wire),//This gets its value from result in the Shifter_Rotator_Left_Right Module
                                                            .an(an),
                                                            .an1(an1),
                                                            .a_to_g(a_to_g),
                                                            .DP(DP),
                                                            // InputSelector
                                                            .SW(SW),
                                                            .in_sel(in_sel),
                                                            .digit1(digit1_wire),
                                                            .digit2(digit2_wire),
                                                            .digit3(digit3_wire),
                                                            .digit4(digit4_wire)
                                                        );                                                                                        
endmodule
