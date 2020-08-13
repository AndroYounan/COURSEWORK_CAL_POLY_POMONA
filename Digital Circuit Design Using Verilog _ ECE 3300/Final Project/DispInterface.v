`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/28/2020 11:27:05 PM
// Design Name: 
// Module Name: DispInterface
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


module DispInterface_including_InputSelectorDeMux(
                                                    // DispInterface
                                                    input clk,
                                                    input [15:0] op,
                                                    output reg[3:0] an,
                                                    output wire [3:0] an1,
                                                    output reg [6:0] a_to_g,
                                                    output wire DP,
                                                    // InputSelector
                                                    input [3:0] SW,
                                                    input [1:0] in_sel,
                                                    output reg [3:0] digit1,
                                                    output reg [3:0] digit2,
                                                    output reg [3:0] digit3,
                                                    output reg [3:0] digit4
                                                 );
                    
       // 18-bits counter, called clk_div, will repeat its cycle every (10ns*2^18= 2.62ms)
       // Thus we can use the 2 most sig-figs (since we turn on only first 4 digits) in 20-bits counter as the display select signal
       // switching on each segment every (8*2.62=20.96ms)              
       reg [19:0] clk_div = 0;
       wire [1:0] s; assign s = clk_div [19:18];
       wire [3:0] aen; assign aen = 4'b1111;
       assign an1 = 4'b1111; // The last four digits will ramain OFF always
       assign DP = 1'b1; // The decimal point will remain OFF always
       reg [3:0] digit; // register to hold the output value
              
       always @(posedge clk) 
            clk_div <= clk_div + 1; 
       
       // digit select
       always @(aen,s)
        begin
            an = 4'b1111; 
            if (aen[s] == 1)
                an[s] = 0;        
        end     

       always @(*)
        begin 
/* ------------------------------------------------------ */
/*                    4-to-1 MUX                          */
/* ------------------------------------------------------ */              
            case(s)
                0: digit = op[3:0];
                1: digit = op[7:4];
                2: digit = op[11:8];
                3: digit = op[15:12];
                default: digit = 4'bzzzz;  
            endcase
/* ------------------------------------------------------ */
/*            7-segment decoder : hex7seg                 */
/* ------------------------------------------------------ */              
            case(digit) 
                // Common Anodes (0 --> ON) 
                0 : a_to_g = 7'b0000001;
                1 : a_to_g = 7'b1001111;
                2 : a_to_g = 7'b0010010;
                3 : a_to_g = 7'b0000110;
                4 : a_to_g = 7'b1001100;
                5 : a_to_g = 7'b0100100;
                6 : a_to_g = 7'b0100000;
                7 : a_to_g = 7'b0001111;
                8 : a_to_g = 7'b0000000;
                9 : a_to_g = 7'b0000100;
                'hA : a_to_g = 7'b0001000;
                'hB : a_to_g = 7'b1100000;
                'hC : a_to_g = 7'b0110001;
                'hD : a_to_g = 7'b1000010;
                'hE : a_to_g = 7'b0110000;
                'hF : a_to_g = 7'b0111000;
                default : a_to_g = 7'b1111111; // default case --> All will be Off
            endcase        
/* ------------------------------------------------------ */
/*              [[[Input Selector DeMux]]]                */
/*        Using 4 switches only to input 4 digits         */
/* ------------------------------------------------------ */ 
            case(in_sel)
                0:
                    begin
                        digit1 = SW;
                        digit2 = digit2;
                        digit3 = digit3;
                        digit4 = digit4;
                    end 
                1:
                    begin
                        digit1 = digit1;
                        digit2 = SW;
                        digit3 = digit3;
                        digit4 = digit4;
                    end 
                2:
                    begin
                        digit1 = digit1;
                        digit2 = digit2;
                        digit3 = SW;
                        digit4 = digit4;
                    end 
                3:
                    begin
                        digit1 = digit1;
                        digit2 = digit2;
                        digit3 = digit3;
                        digit4 = SW;
                    end
                default:
                    begin
                        digit1 = 0;
                        digit2 = 0;
                        digit3 = 0;
                        digit4 = 0;
                    end                      
            endcase                           
        end             
endmodule
