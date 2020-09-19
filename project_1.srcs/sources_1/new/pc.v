`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 05:06:24 PM
// Design Name:
// Module Name: pc
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


module pc(

           input I_clk,
           input I_rst,
           input [31:0] I_pc,
           output [31:0] O_pc
       );

reg [31:0] R_pc;

always @ (posedge I_clk) begin
    if (I_rst) begin
        R_pc <= 32'h0;
    end
    else begin
        R_pc<= I_pc;
    end
end
assign O_pc=R_pc;
endmodule
