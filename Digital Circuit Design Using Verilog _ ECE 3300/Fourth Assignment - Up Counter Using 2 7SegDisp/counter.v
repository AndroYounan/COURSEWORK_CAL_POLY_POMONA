`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Cal State University Polytechnic Pomona
// Engineer: Andro Younan
// 
// Create Date: 07/06/2020 10:51:51 PM
// Design Name: Up Counter using 2 7SegDisplay 
// Module Name: counter
// Project Name: Up Counter using 2 7SegDisplay 
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


module UpCounter7Seg(mclk, clr, a_to_g, AN, dp, pause);
input mclk;                 //master clock
input clr;                  //clear(reset)
input pause;
output reg [6:0] a_to_g;    //7 segments parts
output reg [7:0] AN;        //individual 7 segments
output dp;                  //decimal point

reg [19:0] counter=20'b0;   //counter for 7 seg // This is the clock divider 
reg [29:0] upcounter1=4'b0; //first upcounter(right side)
reg [3:0] upcounter2=4'b0; //second upcounter(left side)
reg [5:0] dout;             //register for 7 seg outputs
reg [29:0] pausecount1;
reg [3:0] pausecount2;
reg [29:0] countout1;
reg [3:0]  countout2;

always @ (posedge mclk) //20 bit counter for 7 seg display select
begin        
       counter <= counter + 1; //for 7 seg display
end

always @ (posedge mclk) //31 bit counter for upcounter timing
begin
   if(pause)
     begin
       pausecount1 <= upcounter1;
       pausecount2 <= upcounter2;
       countout1 <= pausecount1;
       countout2 <= pausecount2;
     end
   else
     begin 
       if(clr)
        begin
          upcounter1 <= 'b0;    //reset upcounters
          upcounter2 <= 'b0;
        end
       else
         begin
           if(upcounter1[29:26] == 4'b1010)
             begin
               upcounter1 <= 'b0;  //resets upcounter1 to zero after nine
               upcounter2 <= upcounter2 + 1'b1;  //uptick upcounter2
             end
           else
               upcounter1 <= upcounter1 + 1'b1; //uptick upcounter1
         end
        countout1<=upcounter1;
        countout2<=upcounter2;
    end
   if(upcounter2[3:0] == 4'b1010)
             upcounter2 <= 'b0;  //resets upcounter2 to zero after nine
end 

always @ (*)    //3x8 decoder selects which 7 segs is displayed with timing counter
begin       
       case (counter[19:17])
           3'b000: AN <= 8'b11111110;
           3'b001: AN <= 8'b11111101;
           3'b010: AN <= 8'b11111011;
           3'b011: AN <= 8'b11110111;
           3'b100: AN <= 8'b11101111;
           3'b101: AN <= 8'b11011111;
           3'b110: AN <= 8'b10111111;
           3'b111: AN <= 8'b01111111;
           default:AN <= 8'b11111111;
       endcase
end


always @ (*) begin       //multiplexer used with timing counter to multiplexer 7 seg outputs

   case (counter[19:17])
       3'b000: dout <= {1'b1,countout1[29:26],1'b1};
       3'b001: dout <= {1'b0,4'd0,1'b1};
       3'b010: dout <= {1'b0,4'd0,1'b1};
       3'b011: dout <= {1'b0,4'd0,1'b1};
       3'b100: dout <= {1'b0,4'd0,1'b1};
       3'b101: dout <= {1'b0,4'd0,1'b1};
       3'b110: dout <= {1'b0,4'd0,1'b1};
       3'b111: dout <= {1'b1,countout2[3:0],1'b1};
       default : dout <= {1'b0, 4'd0,1'b1};
   endcase
end

assign dp = dout[0]; // turning off the decimal point all the time

always @ (*) begin          // common anode seven segment
   if (dout[5])             // bit #5 in dout functions as enable
       case(dout[4:1])      // countout 1[29:26] or 2
           4'b0000: a_to_g <= 7'b0000001;
           4'b0001: a_to_g <= 7'b1001111;
           4'b0010: a_to_g <= 7'b0010010;
           4'b0011: a_to_g <= 7'b0000110;
           4'b0100: a_to_g <= 7'b1001100;
           4'b0101: a_to_g <= 7'b0100100;
           4'b0110: a_to_g <= 7'b0100000;
           4'b0111: a_to_g <= 7'b0001111;
           4'b1000: a_to_g <= 7'b0000000;
           4'b1001: a_to_g <= 7'b0000100;
           4'b1010: a_to_g <= 7'b0000010;
           4'b1011: a_to_g <= 7'b1100000;
           4'b1100: a_to_g <= 7'b0110001;
           4'b1101: a_to_g <= 7'b1000010;
           4'b1110: a_to_g <= 7'b0110000;
           4'b1111: a_to_g <= 7'b0111000;
           default: a_to_g <= 7'b1111111;
       endcase
   else a_to_g <=7'hFF;  // default case will result in having the 7seg being off
end


endmodule
