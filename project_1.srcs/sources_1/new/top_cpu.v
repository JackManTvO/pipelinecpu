`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 01:53:33 AM
// Design Name:
// Module Name: top_cpu
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


module top_cpu(
           input I_clk,
           input I_rst
       );







wire SignimmD;
wire PCPlus4D;

wire RegWriteD;
wire MemtoRegD;
wire MemWriteD;
wire BranchD;
wire ALUControlD;
wire ALUSrcD;
wire RegDstD;


wire SrcAE;
wire SrcB0E;
wire SrcBE;
wire WriteDataE;
wire RtE;
wire RDE;
wire [4:0] WriteRegE;
wire SignImmE;
wire SignImmL2E;
wire PCPlus4E;
wire ZeroE;
wire ALUOutE;
wire PCBranchE;

wire RegWriteE;
wire MemtoRegE;
wire MemWriteE;
wire BranchE;
wire ALUControlE;
wire ALUSrcE;
wire RegDstE;


wire ZeroM;
wire ALUOutM;
wire WriteDataM;
wire [4:0] WriteRegM;
wire PCBranchM;
wire ReadDataM;

wire RegWriteM;
wire MemtoRegM;
wire MemWriteM;
wire BranchM;
wire PCSrcM;


wire ALUOutW;
wire ReadDataW;


wire RegWriteW;
wire MemtoRegW;



wire [31:0] new_pc;
wire [31:0] c_jnop_pc;
wire [31:0] c_dnop_pc;
wire [31:0] pc_inst;

pc pc(
        .I_clk(I_clk),
        .I_rst(I_rst),
        .I_pc(new_pc),
        //.I_nop_pc(c_jnop_pc),
        .I_pause(c_dnop_pc),

        .O_pc(pc_inst)
     );

wire [31:0] InstrM; //from Mem
wire c_nop_pc;

iMem iMem(
            .I_add(pc_inst[11:2]),
            .I_nop_sig(c_nop_pc),
            .O_instr(InstrM)
        );


wire [31:0]br_offset;
wire [31:0]pc_mux;
wire c_pc_mux;
wire [31:0]mux_npc;

mux_pc mux_pc(
                .I_off(br_offset),
                .I_pc(pc_mux),
                .I_c(c_pc_mux),
                .O_out(new_pc),
                .O_output_npc(mux_npc)
);


jnop jnop(
    .clk(I_clk),
    .rst(I_rst),
    .I_opcode(InstrM[31:26]),
    .I_func(InstrM[5:0]),
    .pause(c_dnop_pc)
);





wire[31:0] if_nnpc;
wire[31:0] if_instr;

IF IF(
        .clk(I_clk),
        .rst(I_rst0),
        .instructions_in(InstrM),
        .I_nnpc(mux_npc),
        .O_nnpc(if_nnpc),
        .O_instruction_out(if_instr)
);

wire [5:0] if_InstrOpcode;
wire [5:0] if_Instrfunc;
wire [4:0] if_InstrRs;
wire [4:0] if_InstrRt;
wire [4:0] if_InstrRd;
wire [15:0] if_InstrImm;
wire [25:0] if_instrImm26;
wire [4:0] if_InstrSa;


assign if_InstrOpcode=if_instr[31:26];
assign if_Instrfunc=if_instr[5:0];
assign if_InstrRs=if_instr[25:21];
assign if_InstrRt=if_instr[20:16];
assign if_InstrRd=if_instr[15:11];
assign if_InstrImm=if_instr[15:0];
assign if_instrImm26=if_instr[26:0];
assign if_InstrSa=if_instr[10:6];

wire [2:0]c_br;
wire [31:0] reg_rd1;
wire [31:0] reg_rd2;


br br(
        .I_imm26(if_instrImm26),
        .I_imm16(if_InstrImm),
        .I_pc(pc_inst),
        .I_cB(c_br),
        .I_rs_data(reg_rd1),
        .O_output_pc(br_offset)
);

wire c_regwrite_en;
wire [4:0] WriteRegW;
wire [31:0] ResultW;

regfile regfile(
            .I_clk(I_clk),

            .I_reg_we(c_regwrite_en),
            .I_rs_addr(if_InstrRs),
            .I_rt_addr(if_InstrRt),
            .I_wb_addr(WriteRegW),
            .I_wb_data(ResultW),

            .O_rFs_data(reg_rd1),
            .O_rt_data(reg_rd2)
        );


wire[1:0] bralu_res;
bralu bralu(
            .I_alu_num1(reg_rd1),
            .I_alu_num2(reg_rd2),
            .O_zero(bralu_res)
);



// module control(
//          input [5:0] I_opcode,
//          input [5:0] I_func,
//          input [1:0] I_br_zero,


//          output O_reg_w,
//          output O_mem_w,
//          output O_alu_mux,//src
//          output [2:0] O_rwd_mux,
//          output O_rwa_mux,//reg_dst
//          output O_pc_mux,
//          output [3:0]O_cA,//alu_op
//          output [2:0]O_cB,
//          output [1:0] O_cE//ext_op
//         output [5:0] O_inst_type
//        );


wire c_reg_w;
wire c_mem_w;
wire c_alu_src;
wire [2:0]c_wrb_mux;
wire c_reg_dst;
wire [3:0] c_alu_op;
wire[1:0] c_ext_op;
wire [5:0] dnop_inst_type;

control control(
        .I_opcode(if_InstrOpcode),
        .I_func(if_Instrfunc),
        .I_br_zero(bralu_res),
        .O_reg_w(c_reg_w),
        .O_mem_v(c_mem_w),
        .O_alu_mux(c_alu_src),
        .O_rwd_mux(c_wrb_mux),
        .O_rwa_mux(c_reg_dst),
        .O_pc_mux(c_pc_mux),
        .O_cA(c_alu_op),
        .O_cB(c_br),
        .O_cE(c_ext_op),
        .O_inst_type(dnop_inst_type)
        );

// module dnop(
//     input clk,
//     input rst,
    
//     input[4:0]I_dst_reg,
//     input[5:0]I_inst_type,
//     input[4:0]I_rs,
//     input[4:0]I_rt,
//     output wire pause
//        );

wire[4:0] dnop_dst_reg;


mux_rwa mux_rwa_dnop(
                    .I_rt(if_InstrRt),
                    .I_rd(if_InstrRd),
                    .I_c(c_reg_dst),
                    .O_out(dnop_dst_reg)
);

wire d_pause;

dnop dnop(
        .clk(I_clk),
        .rst(I_rst),
        .I_dst_reg(dnop_dst_reg),
        .I_inst_type(dnop_inst_type),
        .I_rs(if_InstrRs),
        .I_rt(if_InstrRt),
        .pause(d_pause)
);




wire[31:0] id_nnpc;
wire[31:0] id_reg_rd1;
wire[31:0] id_red_rd2;
wire[15:0] id_instrimm16;
wire[5:0] id_instrRt;
wire[5:0] id_instrRd;
wire[5:0] id_instrSa;

wire id_c_red_dst;
wire[1:0] id_c_ext_op;
wire id_c_alu_src;
wire[4:0] id_c_alu_op;
wire id_c_mem_w;
wire[2:0] id_c_wrb_mux;
wire id_c_reg_w;


ID ID(
.clk(I_rst),
.rst(I_rst),     

.I_nnpc(if_nnpc),
.I_reg1_data(reg_rd1),
.I_reg2_data(reg_rd2),
.I_imm16(if_InstrImm),
.I_rt(if_InstrRt),
.I_rd(if_InstrRd),
.I_sa(if_InstrSa),

.I_reg_write(c_reg_w),
.I_ext_op(c_ext_op),
.I_alu_src(c_alu_src),
.I_alu_op(c_alu_op),
.I_mem_write(c_mem_w),
.I_reg_src(c_wrb_mux),
.I_reg_dst(c_reg_dst),

.I_pause(d_pause),//control

.O_reg1_data(id_reg_rd1),
.O_reg2_data(id_red_rd2),
.O_nnpc(id_nnpc),
.rs_out(id_red_rd2),
.O_rt(id_instrRt),
.O_rd(id_instrRd),
.O_sa(id_instrsa),
.O_imm16(id_instrimm16),

.O_reg_write(id_c_reg_w),
.O_ext_op(id_c_ext_op),
.O_alu_src(id_c_alu_src),
.O_alu_op(id_c_alu_op),
.O_mem_write(id_c_mem_w),
.O_reg_src(id_c_wrb_mux),
.O_reg_dst(id_c_red_dst)


);
 
//  module mux_alu(
//            input [31:0] I_ext,
//            input [31:0] I_rd,

//            input I_c,
//            output [31:0] O_out
//        );

wire[31:0] ext_res;
wire[31:0] alu_input2;


mux_alu mux_alu(
                .I_ext(ext_res),
                .I_rd(id_red_rd2),
                .I_c(id_c_alu_src),
                .O_out(alu_input2)
);


// module extend(
//            input [15:0] I_imm,
//            input [1:0] I_ext_op,

//            output reg[31:0] O_ext
//        );


extend extend(
                .I_imm(id_instrimm16),
                .I_ext_op(id_c_ext_op),
                .O_ext(ext_res)
);


    // module mux_rwa(
    //     input [4:0] I_rt,
    //     input [4:0] I_rd,

    //     input I_c,
    //     output [4:0]O_out
    // );

wire[4:0] muxa_dst_reg;

mux_rwa mux_rwa_exe(
                    .I_rt(id_instrRt),
                    .I_rd(id_instrRd),
                    .I_c(id_c_red_dst),
                    .O_out(muxa_dst_reg)
);


// module alu(
//            input [4:0]  I_cA,
//            input [4:0]  sa,
//            input [31:0] I_alu_num1,
//            input [31:0] I_alu_num2,
//            output [31:0] O_ans,
//            output wire overflow 
//        );

wire[31:0] alu_res;


alu alu(
        .I_cA(id_c_alu_op),
        .sa(id_instrsa),
        .I_alu_num1(id_reg_rd1),
        .I_alu_num2(alu_input2),
        .O_ans(alu_res)
        );


wire[31:0] exe_alu_res;
wire[31:0] exe_reg2_data;
wire[31:0] exe_nnpc;
wire[31:0] exe_ext_res;
wire[4:0] exe_dst_reg;

wire exe_c_mem_w;
wire[2:0] exe_c_wrb_mux;
wire exe_c_reg_w;

EXE EXE(
        .clk(I_clk),
        .rst(I_rst),
        .I_alu_result(alu_res),
        .I_reg2_data(id_red_rd2),
        .I_nnpc(id_nnpc),
        .I_extended_imm(ext_res),
        .I_destination_reg(muxa_dst_reg),

        .I_mem_write(id_c_mem_w),
        .I_reg_src(id_c_wrb_mux),
        .I_reg_write(id_c_reg_w),

        .O_alu_result(exe_alu_res),
        .O_reg2_data(exe_reg2_data),
        .O_nnpc(exe_nnpc),
        .O_extended_imm(exe_ext_res),
        .O_destination_reg(exe_dst_reg),

        .O_mem_write(exe_c_mem_w),
        .O_reg_src(exe_c_reg_src),
        .O_reg_write(exe_c_reg_w)

);


endmodule