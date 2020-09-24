`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 01:42:35 AM
// Design Name:
// Module Name: iMem
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


module iMem(
           input [11:2] I_addr,
            input I_nop_sig,
           output [31:0] O_idata
       );
reg [31:0] R_imem[1023:0];

assign O_idata=(!I_nop_sig)?R_imem[I_addr]:32'b0;
endmodule
