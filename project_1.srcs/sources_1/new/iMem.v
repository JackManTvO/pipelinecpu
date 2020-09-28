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
           input wire[11:2] I_addr,
           output wire[31:0] O_idata
       );
reg [31:0] R_imem[1023:0];

assign O_idata=R_imem[I_addr];
endmodule
