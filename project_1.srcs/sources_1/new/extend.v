`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/13/2020 12:41:28 PM
// Design Name:
// Module Name: extend
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


module extend(
           input [15:0] I_imm,
           input [1:0] I_ext_op,

           output reg[31:0] O_ext
       );

always @(*) begin
    case(I_ext_op)
        2'b00:
            O_ext<={I_imm,16'b0};
        2'b01:
            O_ext<={{16{I_imm[15]}},I_imm};
        2'b10:
            O_ext<={16'b0,I_imm};
    endcase
end
endmodule
