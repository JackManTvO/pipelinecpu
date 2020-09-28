`timescale 1ns / 1ps


module ID(
            input  wire  clk,
            input  wire  rst,     

            input  wire[31:0]                   I_nnpc,
            input  wire[31:0]                   I_reg1_data,
            input  wire[31:0]                   I_reg2_data,
            input  wire[15:0]                   I_imm16,
            input  wire[4:0]                    I_rt,
            input  wire[4:0]                    I_rd,
            input  wire[4:0]                    I_sa,


            input wire                          I_reg_write,
            //input wire                        en_lw_id_ex_in,
            input wire[1:0]                     I_ext_op,
            input wire                          I_alu_src,
            input wire[3:0]                     I_alu_op,
            input wire                          I_mem_write,
            input wire[2:0]                     I_reg_src,
            input wire                          I_reg_dst,

            input wire                   I_pause,//control
            //input wire[31:0]                    lw_stall_data,
            //input wire[4:0]                     lw_mem_addr,

            output reg [31:0]    O_reg1_data,
            output reg [31:0]    O_reg2_data,
            output reg [31:0]    O_nnpc,
            //output reg[4:0]                   rs_out,
            output reg [4:0]     O_rt,
            output reg [4:0]     O_rd,
            output reg [4:0]     O_sa,
            output reg [15:0]    O_imm16,

            output   reg         O_reg_write,
            
            output reg [1:0]     O_ext_op,
            output reg           O_alu_src,
            output reg [3:0]     O_alu_op,
            output reg           O_mem_write,
            output reg [2:0]     O_reg_src,
            output reg           O_reg_dst
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

reg[31:0]    R_reg1_data;
reg[31:0]    R_reg2_data;
reg[31:0]    R_nnpc;

reg[4:0]     R_rt;
reg[4:0]     R_rd;
reg[4:0]     R_sa;
reg[15:0]    R_imm16;

reg          R_reg_write;

reg[1:0]     R_ext_op;
reg          R_alu_src;
reg[3:0]     R_alu_op;
reg          R_mem_write;
reg[2:0]     R_reg_src;
reg          R_reg_dst;

always @ (posedge clk) begin
    if (rst) begin

        R_reg1_data     <= 32'b0;
        R_reg2_data     <= 32'b0;

        R_nnpc          <= 32'b0;
        R_rt            <= 5'b0;
        R_rd            <= 5'b0;
        R_sa            <= 5'b0;
        R_imm16         <= 16'b0;

        R_reg_write     <= 1'b0;

        R_ext_op        <= 2'b0;
        R_alu_src       <= 1'b0;
        R_alu_op        <= 4'b0;
        R_mem_write     <= 1'b0;
        R_reg_src       <= 3'b0;
        R_reg_dst       <= 1'b0;

        O_reg1_data <= 32'b0;
        O_reg2_data <= 32'b0;

        O_nnpc      <= 32'b0;
        O_rt        <= 5'b0;
        O_rd        <= 5'b0;
        O_sa        <= 5'b0;
        O_imm16     <= 16'b0;

        O_reg_write <= 1'b0;

        O_ext_op    <= 2'b0;
        O_alu_src   <= 1'b0;
        O_alu_op    <= 4'b0;
        O_mem_write <= 1'b0;
        O_reg_src   <= 3'b0;
        O_reg_dst   <= 1'b0;
    end
    else begin
        if(I_pause == 1'b0) begin
            
            /////////////////////////////////////////////////////////////////////////////////////////////
            R_reg1_data <= I_reg1_data;
            R_reg2_data <= I_reg2_data;
            //end

            R_nnpc         <= I_nnpc;
            R_rt           <= I_rt;
            R_rd           <= I_rd;
            R_sa           <= I_sa;
            R_imm16        <= I_imm16;

            R_reg_write<= I_reg_write;

            R_ext_op    <= I_ext_op;
            R_alu_src   <= I_alu_src;
            R_alu_op    <= I_alu_op;
            R_mem_write <= I_mem_write;
            R_reg_src   <= I_reg_src;
            R_reg_dst   <= I_reg_dst;

            O_reg1_data <= R_reg1_data;
            O_reg2_data <= R_reg2_data;

            O_nnpc      <= R_nnpc;
            O_rt        <= R_rt;
            O_rd        <= R_rd;
            O_sa        <= R_sa;
            O_imm16     <= R_imm16;

            O_reg_write <= R_reg_write;
            O_ext_op    <= R_ext_op;
            O_alu_src   <= R_alu_src;
            O_alu_op    <= R_alu_op;
            O_mem_write <= R_mem_write;
            O_reg_src   <= R_reg_src;
            O_reg_dst   <= R_reg_dst;

            ///////////////////////////////////////////////////////////////////////////////////////////////
        end
        else begin
            R_reg1_data    <= R_reg1_data;
            R_reg2_data    <= R_reg2_data;

            R_nnpc         <= R_nnpc;
            R_rt           <= R_rt;
            R_rd           <= R_rd;
            R_sa           <= R_sa;
            R_imm16        <= R_imm16;

            R_reg_write <= R_reg_write;

            R_ext_op    <= R_ext_op;
            R_alu_src   <= R_alu_src;
            R_alu_op    <= R_alu_op;
            R_mem_write <= R_mem_write;
            R_reg_src   <= R_reg_src;
            R_reg_dst   <= R_reg_dst;

            O_reg1_data <= 32'b0;
            O_reg2_data <= 32'b0;

            O_nnpc      <= 32'b0;
            O_rt        <= 5'b0;
            O_rd        <= 5'b0;
            O_sa        <= 5'b0;
            O_imm16     <= 16'b0;

            O_reg_write <= 1'b0;
            O_ext_op    <= 2'b0;
            O_alu_src   <= 1'b0;
            O_alu_op    <= 4'b0;
            O_mem_write <= 1'b0;
            O_reg_src   <= 3'b0;
            O_reg_dst   <= 1'b0;
        end
    end
    
end


endmodule