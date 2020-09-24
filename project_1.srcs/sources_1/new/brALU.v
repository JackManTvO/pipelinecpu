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


module brALU(
           input [31:0] I_alu_num1,
           input [31:0] I_alu_num2,
           output [2:0] O_zero
           //output wire overflow 
       );

reg signed [32:0] ans;

always @ (*) begin
    ans <= I_alu_num1 - I_alu_num2;
end

assign O_zero =(ans>0)?2:
            (ans==0)?1:
            0;

endmodule