`timescale 1ns / 1ps
module jnop(
    input clk,
    input rst,

    input[5:0]I_inst_type,
    output [4:0]inst_for_csg,
    output wire pause
       );

assign pause=(I_inst_type==6||I_inst_type==7||I_inst_type==8||I_inst_type==9||I_inst_type==10||I_inst_type==11||I_inst_type==32||I_inst_type==33)?1:0;
assign inst_for_csg= pause?5'b11111:I_inst_type;
endmodule
