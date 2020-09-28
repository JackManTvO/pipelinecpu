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
           input [31:0] I_pc,
           //
           //input [1:0]  I_cB,
           input [2:0] I_cB,
           //
           input [31:0] I_rs_data, 
           //output [31:0] O_jump,
           //output [31:0] O_offset,
           output reg [31:0] O_output_pc
       );

reg [31:0] R_offset;
reg [31:0] R_jump;


always @ (*) begin
    if(I_cB<=3'b100) begin
        if(&I_cB==3'b001||I_cB==3'b010||I_cB==3'b011||I_cB==3'b100)
            R_offset<={32'h4+{{14{I_imm16[15]}},{I_imm16, 2'b00}}};
        else
            R_offset<=32'h4;
    end
    else if(I_cB==3'b101)
        R_jump<={I_pc[31:28],I_imm26,2'b00};
    else if(I_cB==3'b110)
        R_jump<=I_rs_data;
    else
        R_offset<=32'h4;
end

always @(*) begin
    if(I_cB==3'b101||I_cB==3'b110) begin
        O_output_pc<=R_jump;

    end
    else
        O_output_pc<=R_offset;
end
endmodule
