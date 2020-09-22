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
            //input wire[3:0]                   stall_C,
            //input wire[31:0]                    lw_stall_data,
            //input wire[4:0]                     lw_mem_addr,

            output reg[31:0]    O_reg1_data,
            output reg[31:0]    O_reg2_data,
            output reg[31:0]    O_nnpc,
            //output reg[4:0]                   rs_out,
            output reg[4:0]     O_rt,
            output reg[4:0]     O_rd,
            output reg[4:0]     O_sa,
            output reg[15:0]    O_imm16,

            output reg          O_reg_write,
            //output reg                        en_lw_id_ex_out,
            output reg[1:0]     O_ext_op,
            output reg          O_alu_src,
            output reg[3:0]     O_alu_op,
            output reg          O_mem_write,
            output reg[2:0]     O_reg_src,
            output reg[1:0]     O_reg_dst
       );

// if rst/halt, zeroize all registers
wire zeroize;
assign zeroize = rst;

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
        O_reg1_data    <= 32'b0;
        O_reg2_data    <= 32'b0;
        O_nnpc      <= 32'b0;
        //rs_out           <= 5'b0;
        O_rt           <= 5'b0;
        O_rd           <= 5'b0;
        O_sa           <= 5'b0;
        O_imm16        <= 16'b0;

        O_reg_write <= 0;

        O_ext_op    <= 2'b0;
        O_alu_src   <= 1'b0;
        O_alu_op    <= 0;
        O_mem_write <= 0;
        O_reg_src   <= 0;
        O_reg_dst   <= 0;
        //tempdata_1       <= 32'b0;
        //tempdata_2       <= 32'b0;
        //temp_state       <= 2'b00;
    end
    else  begin
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
        O_reg1_data <= I_reg1_data;
        O_reg2_data <= I_reg2_data;
        //end

        O_nnpc      <= I_nnpc;
        //O_rs           <= I_rs;
        O_rt           <= I_rt;
        O_rd           <= I_rd;
        O_sa           <= I_sa;
        O_imm16        <= I_imm16;

        O_reg_write<= I_reg_write;
        //en_lw_id_ex_out  <= en_lw_id_ex_in;
        O_ext_op    <= I_ext_op;
        O_alu_src   <= I_alu_src;
        O_alu_op    <= I_alu_op;
        O_mem_write <= I_mem_write;
        O_reg_src   <= I_reg_src;
        O_reg_dst   <= I_reg_dst;
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

endmodule