`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 01:53:33 AM
// Design Name:
// Module Name: dMem
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


module dMem(
           input I_we,

           input [11:2] I_addr,
           input [31:0] I_wdata,

           output [31:0] O_rdata
       );

reg [31:0] R_dMem[1023:0];
assign O_rdata=R_dMem[I_addr];

always @(*) begin
    if(I_we) begin
        R_dMem[I_addr]<=I_wdata;
    end
end


endmodule
