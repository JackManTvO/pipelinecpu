`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 09/11/2020 05:06:24 PM
// Design Name:
// Module Name: mux
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


module mux_alu(
           input [31:0] I_ext,
           input [31:0] I_rd,

           input I_c,
           output [31:0] O_out
       );
reg [31:0] R_out;
always @ (*) begin
    case (I_c)
        1:
            R_out<=I_rd;
        0:
            R_out<=I_ext;
    endcase
end
assign O_out=R_out;
endmodule


    module mux_rwd(
        input [31:0] I_ext,
        input [31:0] I_alu,
        input [31:0] I_dm,
        input [31:0] I_nnpc,

        input [2:0] I_c,
        output [31:0]O_out
    );
reg [31:0] R_out;
always @ (*) begin
    case (I_c)
        3'b000:
            R_out<=I_ext;
        3'b001:
            R_out<=I_alu;
        3'b010:
            R_out<=I_dm;
        3'b011:
            R_out<=I_nnpc;
    endcase
end
assign O_out=R_out;
endmodule


    module mux_rwa(
        input [4:0] I_rt,
        input [4:0] I_rd,

        input I_c,
        output [4:0]O_out
    );
wire [4:0] R_out;
// always @ (*) begin
//     case (I_c)
//         1:
//             R_out<=I_rd;
//         0:
//             R_out<=I_rt;
//     endcase
// end
assign R_out=I_c?I_rd:I_rt;
assign O_out=R_out;
endmodule


    module mux_pc(
        input [31:0] I_off,
        //input [31:0] I_j,
        input [31:0] I_pc,
        input I_c,

        output [31:0]O_out,
        output [31:0]O_output_npc
    );
reg [31:0] R_out;
always @ (*) begin
    case (I_c)
        1:
            R_out<=I_off;
        0:
            R_out<=I_off+I_pc;
    endcase
end
assign O_out=R_out;
assign O_output_npc=R_out+4;
endmodule


    module mux_offset(
        input [31:0] I_beq,

        input I_c,
        output [31:0] O_out
    );
reg [31:0] R_out;
always @ (*) begin
    case (I_c)
        1:
            R_out<=I_beq;
        0:
            R_out<=32'h4;
    endcase
end
assign O_out=R_out;
endmodule
