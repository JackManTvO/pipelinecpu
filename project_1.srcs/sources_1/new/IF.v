`timescale 1ns / 1ps

module IF(
            input         clk,
            input         rst,
            input  [31:0] instructions_in,
            input  [31:0] I_nnpc,
            //input         I_pause,

            output [31:0]  O_nnpc,
            output [31:0]  O_instructions_out
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

reg[31:0] R_nnpc;
reg[31:0] R_instruction_out;

assign O_nnpc=R_nnpc;
assign O_instructions_out=R_instruction_out;

always @ (posedge clk) begin
    if (zeroize) begin
        R_instruction_out <= 32'b0;
    end
    else begin
        R_instruction_out <= instructions_in;
        R_nnpc<= I_nnpc;
    end
end 

endmodule