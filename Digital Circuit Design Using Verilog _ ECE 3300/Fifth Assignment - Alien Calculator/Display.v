`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2020 03:07:28 PM
// Design Name: 
// Module Name: Display
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


module Display(
    input sys_clk, i_Neg, 
    input [4:0] i_A, i_B, 
    input [7:0] i_Result,
    output reg [7:0] o_enable,
    output reg [6:0] o_CAG
    );

    /* -------------------------------------------------------------------- */
    /*  Selector counter that updates a display every 1.31 ms               */
    /* -------------------------------------------------------------------- */    
        
    reg [19:0] counter = 0;
    wire [2:0] sel; 
    
    always @(posedge sys_clk) begin
        counter <= counter + 1; 
    end
    
    assign sel = counter[19:17]; 

    /* -------------------------------------------------------------------- */
    /*  Portion that uses selector to decide which display to turn on using */
    /*  o_enable.                                                           */
    /*  dispActive is a constant to decide if a display should be active.   */                                                          
    /* -------------------------------------------------------------------- */        
    
    reg [7:0] dispActive = 8'b1110_1111; 
    
    always @(*) begin
        o_enable = 8'b1111_1111; 
        if(dispActive[sel])
            o_enable[sel] = 0; 
    end
    
    /* -------------------------------------------------------------------- */
    /*  Selects which value to set to display by checking sel value. Checks */
    /*  if the sign should be negative or positive.                         */ 
    /* -------------------------------------------------------------------- */ 
    
    reg [3:0] dispValue = 0; 
    reg isNeg = 0; 
       
    always @(*) begin
        case(sel)
            0:  dispValue = i_A[3:0];
            2:  dispValue = i_B[3:0]; 
            5:  dispValue = i_Result[3:0];                 
            6:  dispValue = i_Result [7:4];                
            default: dispValue = 0;
        endcase
    end
    
    always @(*) begin
        case(sel)
            1:  begin
                    if(i_A[4] == 0) isNeg = 1; 
                    else isNeg = 0;  
                end
            3:  begin
                    if(i_B[4] == 0) isNeg = 1; 
                    else isNeg = 0;  
                end
            7:  begin
                    if(i_Neg) isNeg = 1; 
                    else isNeg = 0;
                end                 
            default: isNeg = 0; 
        endcase
    end    
    
    /* -------------------------------------------------------------------- */
    /*  Configure what LEDs to turn on on the display using CAG. Checks if  */
    /*  display should display a value or sign.                             */ 
    /* -------------------------------------------------------------------- */ 
    
    always @(*) begin
        if(sel == 'd1 || sel == 'd3 || sel == 'd7) begin
            if(isNeg) o_CAG = 7'b100_1110;
            else o_CAG = 7'b011_0111; 
        end else begin
            case(dispValue)
                0:  o_CAG = 7'b000_0001; 
                1:  o_CAG = 7'b100_1111;
                2:  o_CAG = 7'b001_0010;
                3:  o_CAG = 7'b000_0110;
                4:  o_CAG = 7'b100_1100;
                5:  o_CAG = 7'b010_0100;
                6:  o_CAG = 7'b010_0000;
                7:  o_CAG = 7'b000_1111;
                8:  o_CAG = 7'b000_0000;
                9:  o_CAG = 7'b000_1100;
                10: o_CAG = 7'b000_1000;
                11: o_CAG = 7'b110_0000;
                12: o_CAG = 7'b011_0001; 
                13: o_CAG = 7'b100_0010;
                14: o_CAG = 7'b011_0000;
                15: o_CAG = 7'b011_1000;
                default: o_CAG = 7'b111_1111; 
            endcase
        end
    end    
        
endmodule

