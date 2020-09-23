`timescale 1ns / 1ps
module br(
    input clk,
    input rst,
    
    input[4:0]I_dst_reg,
    input[5:0]I_inst_type,
    input[4:0]I_rs,
    input[4:0]I_rt,
    output [4:0]inst_for_csg,
    output wire pause
       );

reg [4:0]buff1;
reg [4:0]buff2;
reg [4:0]buff3;
always @ (posedge clk or negedge rst) begin
if(!rst) begin
    buff1<=0;
    buff2<=0;
    buff3<=0;
end
else begin
    buff3<=buff2;
    buff2<=buff1;
    buff1<=I_dst_reg;
end
end
assign pause=(I_inst_type==2||I_inst_type==3||I_inst_type==6||I_inst_type==9||I_inst_type==10||I_inst_type==11||
I_inst_type==13||I_inst_type==14||I_inst_type==29||I_inst_type==30||I_inst_type==31||I_inst_type==34||I_inst_type==35||
I_inst_type==36||I_inst_type==37||I_inst_type==38||I_inst_type==39)?
(((buff1==I_rt||buff2==I_rt||buff3==I_rt)&&(I_rt!=0))?1:
((buff1==I_rs||buff2==I_rs||buff3==I_rs)&&(I_rs!=0))?1:0):
(I_inst_type==0||I_inst_type==26||I_inst_type==27||I_inst_type==28)?
(((buff1==I_rt||buff2==I_rt||buff3==I_rt)&&(I_rt!=0))?1:0):
(I_inst_type==1||I_inst_type==4||I_inst_type==5||I_inst_type==12||I_inst_type==15||
I_inst_type==16||I_inst_type==17||I_inst_type==18||I_inst_type==19||I_inst_type==20||
I_inst_type==21||I_inst_type==22||I_inst_type==23||I_inst_type==24||I_inst_type==25||
I_inst_type==32||I_inst_type==33)?
(((buff1==I_rs||buff2==I_rs||buff3==I_rs)&&(I_rs!=0))?1:0):0;
endmodule
