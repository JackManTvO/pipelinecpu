`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 11:56:01 PM
// Design Name:
// Module Name: regfile
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


module regfile(
           input I_clk,

           input I_reg_we,
           input [4:0] I_rs_addr,
           input [4:0] I_rt_addr,
           input [4:0] I_wb_addr,
           input [31:0] I_wb_data,

           output [31:0] O_rs_data,
           output [31:0] O_rt_data
       );

reg [31:0] R_gpr[31:0];

always @(posedge I_clk) begin
    if(I_reg_we) begin
        R_gpr[I_wb_addr]<=I_wb_data;
    end
end

assign O_rs_data=(I_rs_addr==0)?32'h0:R_gpr[I_rs_addr];
assign O_rt_data=(I_rt_addr==0)?32'h0:R_gpr[I_rt_addr];

endmodule
