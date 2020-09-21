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
           output [2:0] O_rwd_mux,
           output O_rwa_mux,
           output [1:0]O_pc_mux,
           output [2:0]O_offset_mux,
           output [3:0]O_cA,
           output [1:0]O_cB,
           output [1:0] O_cE,
           output wire O_jumprs
       );

wire [5:0] W_inst_type;
//0-lui,1-addiu,2-add,3-subu,4-lw,5-sw,6-beq,7-j,8-reserved

assign W_inst_type=
       (I_opcode==6'b001111)?0:
       (I_opcode==6'b001001)?1:
       (I_opcode==6'b100011)?4:
       (I_opcode==6'b101011)?5:
       (I_opcode==6'b000100)?6:
       (I_opcode==6'b000010)?7:
       (I_opcode==6'b000011)?8:
       (I_opcode==6'b000101)?9:
       (I_opcode==6'b000110)?10:
       (I_opcode==6'b000111)?11:
       (I_opcode==6'b001000)?12:
       (I_opcode==6'b001100)?15:
       (I_opcode==6'b001101)?16:
       (I_opcode==6'b001110)?17:
       (I_opcode==6'b100000)?18:
       (I_opcode==6'b100001)?19:
       (I_opcode==6'b100010)?20:
       (I_opcode==6'b100110)?21:
       (I_opcode==6'b101000)?22:
       (I_opcode==6'b101001)?23:
       (I_opcode==6'b101010)?24:
       (I_opcode==6'b101110)?25:
       (I_opcode==6'b000000)?(
        (I_func==6'b100000)?2:
        (I_func==6'b100011)?3:
        (I_func==6'b101010)?13:
        (I_func==6'b101011)?14:
           (I_func==6'b000000)?26:
           (I_func==6'b000010)?27:
           (I_func==6'b000011)?28:
           (I_func==6'b000100)?29:
           (I_func==6'b000110)?30:
           (I_func==6'b000111)?31:
           (I_func==6'b001000)?32:
           (I_func==6'b001001)?33:
           (I_func==6'b100000)?34:
           (I_func==6'b100010)?35:
           (I_func==6'b100100)?36:
           (I_func==6'b100101)?37:
           (I_func==6'b100110)?38:
           39):
           40;

assign O_mem_w=(W_inst_type==5||
W_inst_type==22||
W_inst_type==23||
W_inst_type==24||
W_inst_type==25)?1:0;

assign O_reg_w=(
           W_inst_type==0||
           W_inst_type==1||
           W_inst_type==2||
           W_inst_type==3||
           W_inst_type==4||
           W_inst_type==12||
           W_inst_type==14||
           W_inst_type==15||
           W_inst_type==16||
           W_inst_type==17||
           W_inst_type==18||
           W_inst_type==19||
           W_inst_type==20||
           W_inst_type==21||
           W_inst_type==34||
           W_inst_type==35||
           W_inst_type==13||
           W_inst_type==36||
           W_inst_type==37||
           W_inst_type==38||
           W_inst_type==39||
           W_inst_type==26||
           W_inst_type==27||
           W_inst_type==28||
           W_inst_type==29||
           W_inst_type==30||
           W_inst_type==31||
           W_inst_type==8||
           W_inst_type==33
           )?1:0;

assign O_alu_mux=(
           W_inst_type==12||
           W_inst_type==1||
           W_inst_type==15||
           W_inst_type==16||
           W_inst_type==17||
           W_inst_type==4||
           W_inst_type==5||
           W_inst_type==18||
           W_inst_type==19||
           W_inst_type==20||
           W_inst_type==21||
           W_inst_type==22||
           W_inst_type==23||
           W_inst_type==24||
           W_inst_type==25)?0:1;


assign O_rwd_mux=(
              W_inst_type==0)?3'b000:
           (W_inst_type==12||
           W_inst_type==1||
           W_inst_type==15||
           W_inst_type==16||
           W_inst_type==17||
           W_inst_type==2||
           W_inst_type==37||
           W_inst_type==35||
           W_inst_type==3||
           W_inst_type==13||
           W_inst_type==14||
           W_inst_type==15||
           W_inst_type==36||
           W_inst_type==37||
           W_inst_type==38||
           W_inst_type==39||
           W_inst_type==26||
           W_inst_type==27||
           W_inst_type==28||
           W_inst_type==29||
           W_inst_type==30||
           W_inst_type==31
           )?3'b001:
           (W_inst_type==4||
           W_inst_type==18||
           W_inst_type==19||
           W_inst_type==20||
           W_inst_type==21)?3'b010:
           (W_inst_type==8||
           W_inst_type==33)?3'b011:3'b111;

assign O_rwa_mux=(
           W_inst_type==2||
           W_inst_type==34||
           W_inst_type==35||
           W_inst_type==13||
           W_inst_type==14||
           W_inst_type==36||
           W_inst_type==37||
           W_inst_type==38||
           W_inst_type==39||
           W_inst_type==26||
           W_inst_type==27||
           W_inst_type==28||
           W_inst_type==29||
           W_inst_type==30||
           W_inst_type==31||
           W_inst_type==33)?1:0;

assign O_pc_mux=(W_inst_type==7||
            W_inst_type==8||
            W_inst_type==32||
            W_inst_type==33)?1:0;


assign O_offset_mux=(W_inst_type==6)?3'b001:(W_inst_type==9)?3'b010:(W_inst_type==10)?3'b011:(W_inst_type==11)?3'b100:3'b000;

assign O_cA=(
              W_inst_type==1||
              W_inst_type==2||
              W_inst_type==12||
              W_inst_type==34||
              W_inst_type==18||
              W_inst_type==19||
              W_inst_type==20||
              W_inst_type==21||
              W_inst_type==22||
              W_inst_type==23||
              W_inst_type==24||
              W_inst_type==25
)?0:
           (
           W_inst_type==3||
           W_inst_type==6||
           W_inst_type==35||
           W_inst_type==9||
           W_inst_type==10||
           W_inst_type==11)?1:
              (
           W_inst_type==13||   
           W_inst_type==14)?2:
              (
           W_inst_type==36||
           W_inst_type==15
           )?3:
            (
           W_inst_type==16||
           W_inst_type==37)?4:
            (
           W_inst_type==39)?5:
            (
           W_inst_type==17||
           W_inst_type==38)?6:
            (
           W_inst_type==26)?7:
            (
           W_inst_type==29)?8:
            (
           W_inst_type==27)?9:
            (
           W_inst_type==30)?10:
            (
           W_inst_type==28)?11:
            (
           W_inst_type==31)?12:13;


assign O_cB=(W_inst_type==7||
            W_inst_type==8)?2'b01:
            (W_inst_type==32||
            W_inst_type==33)?2'b10:2'b00;
assign O_cE=(
        W_inst_type==0
        )?2'b00:
        (
        W_inst_type==1||
        W_inst_type==2||
        W_inst_type==14
        )?2'b01:
        (
        W_inst_type==4||
        W_inst_type==5||
        W_inst_type==15||
        W_inst_type==16||
        W_inst_type==17||
        W_inst_type==18||
        W_inst_type==19||
        W_inst_type==20||
        W_inst_type==21||
        W_inst_type==22||
        W_inst_type==23||
        W_inst_type==24||
        W_inst_type==25
        )?2'b10:2'b11;
endmodule
