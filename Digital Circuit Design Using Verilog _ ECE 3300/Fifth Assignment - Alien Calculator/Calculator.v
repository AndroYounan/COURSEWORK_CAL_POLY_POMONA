`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2020 03:06:15 PM
// Design Name: 
// Module Name: Calculator
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


/*
*   Module: Calculator
*   Inputs: 5-bit i_A, 5-bit i_B, 2-bit i_Calc
*   Outputs: 9-bit o_Result
*   Description: Takes signed inputs A and B, and depending on the configuration
*               of i_Calc, will either add, subtract, or multiply. Result is sent
*               through o_Result. 
*/ 

/* -------------------------------------------------------------------------------- */
/*  Module: Calculator                                                              */
/*  Inputs: 5-bit i_A, 5-bit i_B, 2-bit i_Calc                                      */
/*  Outputs: 8-bit o_Result, 1-bit o_Neg                                            */
/*  Description: Takes signed inputs A and B, and mode of operation changes based   */
/*              on i_Calc, will either add, subtract, or multiply. Data value is    */
/*              sent through o_Result, and if negative o_Neg will be high           */
/* -------------------------------------------------------------------------------- */  

module Calculator(
    input [4:0] i_A, i_B,
    input [1:0] i_Calc,
    output reg [7:0] o_Result,
    output reg o_Neg = 0
    );   

    /* -------------------------------------------------------------------- */
    /*  Segment assigns temp_A and temp_B the appropriate values based on   */
    /*  the inputs of i_A and i_B using signed registers.                   */
    /* -------------------------------------------------------------------- */     

    //Important to note temp_A and temp_B are given the same size as temp_Result, 
    //this makes it so that when calculating using subtraction and addition that
    //the sign carries over appropriately. 
    reg signed [8:0] temp_A = 0, temp_B = 0;
   
    //First check if A or B are 0
    //Then, if MSB is 0 value should be negative, make sure it is translated
    //appropriately into temp variable using leading 1s or 0s. 
    always @(*) begin
        if(i_A[3:0] == 0) temp_A = 0; 
        else if(i_A[4] == 0) temp_A = {5'b11111, -i_A[3:0]}; 
        else temp_A = {5'b0, i_A[3:0]}; 
            
        if(i_B[3:0] == 0) temp_B = 0; 
        else if(i_B[4] == 0) temp_B = {5'b11111, -i_B[3:0]}; 
        else temp_B = {5'b0, i_B[3:0]}; 
    end   
 
    /* -------------------------------------------------------------------- */
    /*  Segment looks at input, i_Calc, to determine math function and      */
    /*  output to o_Result.                                                 */
    /* -------------------------------------------------------------------- */ 
    
    //temp_Result is 9 bits since we need the extra bit to hold the sign
    reg signed [8:0] temp_Result = 0;
    
    //i_Calc to determine the mode of operation
    always @(*) begin
        case(i_Calc)
            0:  temp_Result = temp_A + temp_B; 
            1:  temp_Result = temp_A - temp_B; 
            2:  temp_Result = temp_A * temp_B; 
            3:  temp_Result = 8'hFF; 
        endcase
        
        //If MSB (sign) of temp_Result is 1, raise o_Neg flag and set 
        //temp_Result back to a positive value, else o_Neg flag low
        if(temp_Result[8] == 1) begin
            temp_Result = {1'b0, -temp_Result[7:0]};
            o_Neg = 1;  
        end else begin
            o_Neg = 0;
        end

        //Catch to make sure o_Neg is off if value is 0
        if(temp_Result == 0) begin
            o_Neg = 0; 
        end
        
        //o_Reuslt only holds the data value, do not take MSB of temp_Result
        o_Result = temp_Result[7:0];   
    end
    
endmodule

