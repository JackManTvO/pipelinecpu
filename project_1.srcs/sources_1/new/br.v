`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 05:11:06 PM
// Design Name:
// Module Name: br
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


module br(
           input [25:0] I_imm26,
           input [15:0] I_imm16,
           input [31:0] I_alu,
           input [31:0] I_pc,

           input I_cB,

           output [31:0] O_jump,
           output [31:0] O_offset
       );

reg [31:0] R_offset;
reg [31:0] R_jump;

always @ (*) begin
    if(I_cB==1'b0) begin
        if(I_alu==0)
            R_offset<={32'h4+{{14{I_imm16[15]}},{I_imm16, 2'b00}}};
        else
            R_offset<=32'h4;
    end
    else if(I_cB==1'b1)
        R_jump<={I_pc[31:28],I_imm26,2'b00};
end

assign O_jump=R_jump;
assign O_offset=R_offset;
endmodule
