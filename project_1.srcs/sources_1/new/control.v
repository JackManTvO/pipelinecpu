`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 01:38:48 AM
// Design Name:
// Module Name: control
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


module control(
           input [5:0] I_opcode,
           input [5:0] I_func,

           output O_reg_w,
           output O_mem_w,           
           output O_alu_mux,
           output [1:0] O_rwd_mux,
           output O_rwa_mux,
           output O_pc_mux,
           output O_offset_mux,
           output O_cA,
           output O_cB,
           output [1:0] O_cE
       );

wire [2:0] W_inst_type;
//0-lui,1-addiu,2-add,3-subu,4-lw,5-sw,6-beq,7-j,8-reserved

assign W_inst_type=
       (I_opcode==6'b001111)?0:
       (I_opcode==6'b001001)?1:
       (I_opcode==6'b100011)?4:
       (I_opcode==6'b101011)?5:
       (I_opcode==6'b000100)?6:
       (I_opcode==6'b000010)?7:
       (I_opcode==6'b000000)?(
           (I_func==6'b100000)?2:
           (I_func==6'b100011)?3:8
       ):8;

assign O_mem_w=(W_inst_type==5)?1:0;

assign O_reg_w=(
           W_inst_type==0||
           W_inst_type==1||
           W_inst_type==2||
           W_inst_type==3||
           W_inst_type==4)?1:0;

assign O_alu_mux=(
           W_inst_type==2||
           W_inst_type==3||
           W_inst_type==6)?1:0;

assign O_rwd_mux=(
           W_inst_type==1||
           W_inst_type==2||
           W_inst_type==3)?2'b01:
       W_inst_type==4?2'b10:2'b00;

assign O_rwa_mux=(
           W_inst_type==2||
           W_inst_type==3)?1:0;

assign O_pc_mux=W_inst_type==7?1:0;

assign O_offset_mux=W_inst_type==6?1:0;

assign O_cA=(
           W_inst_type==3||
           W_inst_type==6)?1:0;

assign O_cB=W_inst_type==7?1:0;

assign O_cE=W_inst_type==1?2'b01:(
           W_inst_type==4||
           W_inst_type==5)?2'b10:2'b00;

endmodule
