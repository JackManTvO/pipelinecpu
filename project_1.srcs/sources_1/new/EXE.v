`timescale 1ns / 1ps



module EXE(
            input wire                        clk,
            input wire                        rst,
            input wire[31:0]                  I_alu_result,
            input wire[31:0]                  I_reg2_data,
            input wire[31:0]                  I_nnpc,
            input wire[31:0]                  I_extended_imm,
            input wire[4:0]                   I_destination_reg,

            input wire                        I_mem_write,
            input wire[2:0]                  I_reg_src,
            input wire                        I_reg_write,
            //input wire                        en_lw_ex_mem_in,
            //input wire[3:0]                   stall_C,

            output reg[31:0]                  O_alu_result,
            output reg[31:0]                  O_reg2_data,
            output reg[31:0]                  O_nnpc,
            output reg[31:0]                  O_extended_imm,
            output reg[4:0]                   O_destination_reg,

            output reg                       O_mem_write,
            output reg[2:0]                  O_reg_src,
            output reg                        O_reg_write
            //output reg                        en_lw_ex_mem_out
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

always @ (posedge clk) begin
    if (zeroize) begin
        O_alu_result     <= 32'b0;
        O_reg2_data       <= 32'b0;
        O_nnpc         <= 32'b0;
        O_extended_imm    <= 32'b0;
        O_destination_reg <= 5'b0;
        O_mem_write    <= 0;
        O_reg_src      <= 3'b0;
        O_reg_write   <= 1'b0;
        //en_lw_ex_mem_out    <= `EN_LW_DEFAULT;
    end
    else begin
        O_alu_result     <= I_alu_result;
        O_reg2_data       <= I_reg2_data;
        O_nnpc         <= I_nnpc;
        O_extended_imm    <= I_extended_imm;
        O_destination_reg <= I_destination_reg;
        O_mem_write    <= I_mem_write;
        O_reg_src      <=  I_reg_src;
        O_reg_write   <= I_reg_write;
        //en_lw_ex_mem_out    <= en_lw_ex_mem_in;
    end
    // else begin
    //     O_alu_result,     <= 32'b0;
    //     O_reg2_data       <= 32'b0;
    //     O_nnpc         <= 32'b0;
    //     O_extended_imm    <= 32'b0;
    //     O_destination_reg <= 5'b0;
    //     O_mem_write    <= `MEM_WRITE_DIS;
    //     O_reg_src      <= `REG_SRC_DEFAULT;
    //     O_reg_write   <= `REG_WRITE_DIS;
    //     en_lw_ex_mem_out    <= `EN_LW_DEFAULT;
    // end
end


endmodule