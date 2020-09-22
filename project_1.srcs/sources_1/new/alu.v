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
           input [4:0]  I_cA,
           input [4:0]  sa,
           input [31:0] I_alu_num1,
           input [31:0] I_alu_num2,
           output [31:0] O_ans,
           output wire overflow 
       );

reg [32:0] R_alu;
assign O_ans=R_alu[31:0];
wire[4:0] displacement;

assign displacement =
       (I_cA == 7 ||
        I_cA == 9 ||
        I_cA == 28) ? sa : I_alu_num1[4:0];

assign overflow = (R_alu[32]!=R_alu[31])? 1:0;

wire[31:0] diff;
assign diff = (I_alu_num1 < I_alu_num2) ? 32'h00000001 : 32'h00000000;
always @ (*) begin
    case (I_cA)
        0:
            R_alu<={I_alu_num1[31],I_alu_num1}+{I_alu_num2[31],I_alu_num2};//add
        1:
            R_alu<={I_alu_num1[31],I_alu_num1}-{I_alu_num2[31],I_alu_num2};//sub
        2:
            R_alu<=diff;//slt
        3:
            R_alu<={I_alu_num1[31],I_alu_num1}&{I_alu_num2[31],I_alu_num2};//and
        4:
            R_alu<={I_alu_num1[31],I_alu_num1}|{I_alu_num2[31],I_alu_num2};//or
        5:
            R_alu<=(({I_alu_num1[31], I_alu_num1} & ~{I_alu_num2[31], I_alu_num2}) |
            (~{I_alu_num1[31], I_alu_num1} & {I_alu_num2[31], I_alu_num2}));//nor
        6:
            R_alu<={I_alu_num1[31],I_alu_num1}^{I_alu_num2[31],I_alu_num2};//xor
        7:
            R_alu<={I_alu_num2[31],I_alu_num2}<<displacement;//sll
        8:
            R_alu<={I_alu_num2[31],I_alu_num2}<<displacement;//sllv
        9:
            R_alu<={I_alu_num2[31],I_alu_num2}>>displacement;//srl
        10:
            R_alu<={I_alu_num2[31],I_alu_num2}>>displacement;//srlv
        11:
            R_alu<=({{31{I_alu_num2[31]}}, 1'b0} << (~displacement)) | (I_alu_num2 >> displacement);//sra
        12:
            R_alu<=({{31{I_alu_num2[31]}}, 1'b0} << (~displacement)) | (I_alu_num2 >> displacement);//srav
        13:
            R_alu <= {I_alu_num2[31], I_alu_num2};
    endcase
end

endmodule
