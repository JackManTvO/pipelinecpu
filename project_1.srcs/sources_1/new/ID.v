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
            input wire[1:0]                     I_reg_dst,

            input wire                   I_pause,//control
            //input wire[31:0]                    lw_stall_data,
            //input wire[4:0]                     lw_mem_addr,

            output [31:0]    O_reg1_data,
            output [31:0]    O_reg2_data,
            output [31:0]    O_nnpc,
            //output reg[4:0]                   rs_out,
            output [4:0]     O_rt,
            output [4:0]     O_rd,
            output [4:0]     O_sa,
            output [15:0]    O_imm16,

            output           O_reg_write,
            //output reg                        en_lw_id_ex_out,
            output [1:0]     O_ext_op,
            output           O_alu_src,
            output [3:0]     O_alu_op,
            output           O_mem_write,
            output [2:0]     O_reg_src,
            output [1:0]     O_reg_dst
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

reg[31:0]    R_reg1_data;
reg[31:0]    R_reg2_data;
reg[31:0]    R_nnpc;
//output reg[4:0]                   rs_out,
reg[4:0]     R_rt;
reg[4:0]     R_rd;
reg[4:0]     R_sa;
reg[15:0]    R_imm16;

reg          R_reg_write;
//output reg                        en_lw_id_ex_out,
reg[1:0]     R_ext_op;
reg          R_alu_src;
reg[3:0]     R_alu_op;
reg          R_mem_write;
reg[2:0]     R_reg_src;
reg[1:0]     R_reg_dst;

// state machine for stalling
//reg[1:0] temp_state;
//reg[31:0] tempdata_1;
//reg[31:0] tempdata_2;

always @ (posedge clk) begin
    /*
    if (stall_C[2] == 1 && stall_C[3] == 1 && lw_mem_addr == rs_in) begin
        tempdata_1 <= lw_stall_data;
        temp_state <= 2'b01;
    end
    if (stall_C[2] == 1 && stall_C[3] == 1 && lw_mem_addr == I_rt) begin
        tempdata_2 <= lw_stall_data;
        temp_state <= 2'b10;
    end
    */

    if (zeroize) begin
        R_reg1_data    <= 32'b0;
        R_reg2_data    <= 32'b0;
        R_nnpc      <= 32'b0;
        //rs_out           <= 5'b0;
        R_rt           <= 5'b0;
        R_rd           <= 5'b0;
        R_sa           <= 5'b0;
        R_imm16        <= 16'b0;

        R_reg_write <= 0;

        R_ext_op    <= 2'b0;
        R_alu_src   <= 1'b0;
        R_alu_op    <= 0;
        R_mem_write <= 0;
        R_reg_src   <= 3'b0;
        R_reg_dst   <= 2'b0;
        //tempdata_1       <= 32'b0;
        //tempdata_2       <= 32'b0;
        //temp_state       <= 2'b00;
    end
    else begin
        // if (temp_state == 2'b01) begin
        //     O_reg1_data <= tempdata_1;
        //     O_reg2_data <= I_reg2_data;
        //     temp_state    <= 2'b00;
        // end
        // else if(temp_state == 2'b10) begin
        //     O_reg1_data <= I_reg1_data;
        //     O_reg2_data <= tempdata_2;
        //     temp_state    <= 2'b00;
        // end
        //else begin
        R_reg1_data <= I_reg1_data;
        R_reg2_data <= I_reg2_data;
        //end

        R_nnpc      <= I_nnpc;
        //O_rs           <= I_rs;
        R_rt           <= I_rt;
        R_rd           <= I_rd;
        R_sa           <= I_sa;
        R_imm16        <= I_imm16;

        R_reg_write<= I_reg_write;
        //en_lw_id_ex_out  <= en_lw_id_ex_in;
        R_ext_op    <= I_ext_op;
        R_alu_src   <= I_alu_src;
        R_alu_op    <= I_alu_op;
        R_mem_write <= I_mem_write;
        R_reg_src   <= I_reg_src;
        R_reg_dst   <= I_reg_dst;
        /////////////////////////////////////////////////////////////////////////////////////////////
        //
        ///////////////////////////////////////////////////////////////////////////////////////////////
    end
    // else if(stall_C[2] == 1 && stall_C[3] == 0) begin
    //     O_reg1_data    <= 32'b0;
    //     O_reg2_data    <= 32'b0;
    //     O_jmp_dst      <= 32'b0;
    //     rs_out           <= 5'b0;
    //     O_rt           <= 5'b0;
    //     O_rd           <= 5'b0;
    //     O_sa           <= 5'b0;
    //     O_imm16        <= 16'b0;

    //     O_reg_write,<= `REG_WRITE_DIS;
    //     en_lw_id_ex_out  <= `EN_LW_DEFAULT;
    //     O_ext_op    <= `EXT_OP_DEFAULT;
    //     O_alu_src   <= `ALU_SRC_REG;
    //     O_alu_op    <= `ALU_OP_DEFAULT;
    //     O_mem_write <= `MEM_WRITE_DIS;
    //     O_reg_src   <= `REG_SRC_DEFAULT;
    //     O_reg_dst   <= `REG_DST_DEFAULT;
    // end
    //else begin
        // do nothing
    //end
end

assign    O_reg1_data =(I_pause)?32'b0: R_reg1_data;
assign    O_reg2_data =(I_pause)?32'b0: R_reg2_data;
        //end

assign    O_nnpc      =(I_pause)?32'b0: R_nnpc;
assign    O_rt        =(I_pause)?5'b0: R_rt;
assign    O_rd        =(I_pause)?5'b0: R_rd;
assign    O_sa        =(I_pause)?5'b0: R_sa;
assign    O_imm16     =(I_pause)?16'b0: R_imm16;

assign    O_reg_write =(I_pause)?0: R_reg_write;
assign    O_ext_op    =(I_pause)?2'b0: R_ext_op;
assign    O_alu_src   =(I_pause)?1'b0: R_alu_src;
assign    O_alu_op    =(I_pause)?0: R_alu_op;
assign    O_mem_write =(I_pause)?0: R_mem_write;
assign    O_reg_src   =(I_pause)?0: R_reg_src;
assign    O_reg_dst   =(I_pause)?0: R_reg_dst;

endmodule