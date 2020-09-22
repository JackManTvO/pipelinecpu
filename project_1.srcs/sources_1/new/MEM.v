`timescale 1ns / 1ps

module reg_mem_wb(
            input wire                        clk,
            input wire                        rst,
            input wire[31:0]                  I_alu_result,
            input wire[31:0]                  I_read_mem_data,
            input wire[31:0]                  I_nnpc,
            input wire[31:0]                  I_extended_imm,
            input wire[4:0]                   I_dst_reg,

            input wire[2:0]                   I_reg_src,
            input wire                        I_reg_write,
            //input wire                        en_lw_mem_wb_in,

            output reg[31:0]                  O_alu_result,
            output reg[31:0]                  O_read_mem_data,
            output reg[31:0]                  O_nnpc,
            output reg[31:0]                  O_extended_imm,
            output reg[4:0]                   O_dst_reg,

            output reg[2:0]                     O_reg_src,
            output reg                        O_reg_write
       );


// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

always @ (posedge clk) begin
    if (zeroize) begin
        O_alu_result      <= 32'b0;
        O_read_mem_data   <= 32'b0;
        O_nnpc         <= 32'b0;
        O_extended_imm    <= 32'b0;
        O_dst_reg <= 32'b0;
        O_reg_src      <= 3'b0;
        O_reg_write    <= 1'b0;
        //en_lw_mem_wb_out    <= `EN_LW_DEFAULT;
    end
    else begin
        O_alu_result      <= I_alu_result;
        O_read_mem_data   <= I_read_mem_data;
        O_nnpc         <= I_nnpc;
        O_extended_imm    <= I_extended_imm;
        O_dst_reg <= I_dst_reg;
        O_reg_src      <= I_reg_src;
        O_reg_write    <= I_reg_write;
        //en_lw_mem_wb_out    <= en_lw_mem_wb_in;
    end
end
endmodule