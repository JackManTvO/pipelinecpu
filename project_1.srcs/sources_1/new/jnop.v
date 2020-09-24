`timescale 1ns / 1ps
module jnop(
    input clk,
    input rst,

    input[5:0]I_opcode,
    input [5:0]I_func,
    //output [4:0]inst_for_csg,
    output wire pause
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

assign pause=(W_inst_type==6||W_inst_type==7||W_inst_type==8||W_inst_type==9||W_inst_type==10||W_inst_type==11||W_inst_type==32||W_inst_type==33)?1:0;
//assign inst_for_csg= pause?5'b11111:W_inst_type;
endmodule
