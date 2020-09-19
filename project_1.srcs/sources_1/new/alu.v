`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 05:01:21 PM
// Design Name:
// Module Name: alu
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


module alu(
           input I_cA,

           input [31:0] I_alu_num1,
           input [31:0] I_alu_num2,

           output [31:0] O_ans
       );

reg [32:0] R_alu;

assign O_ans=R_alu[31:0];

always @ (*) begin
    case (I_cA)
        0:
            R_alu<={I_alu_num1[31],I_alu_num1}+{I_alu_num2[31],I_alu_num2};
        1:
            R_alu<={I_alu_num1[31],I_alu_num1}-{I_alu_num2[31],I_alu_num2};
    endcase
end

endmodule
