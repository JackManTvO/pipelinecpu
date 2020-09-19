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

wire [31:0] PC0;
wire [31:0] PCF;
wire [31:0] InstrF;
wire PCPlus4F;


wire [31:0] InstrD;
wire [5:0] InstrOpcode;
wire [5:0] Instrfunc;
wire [4:0] InstrRs;
wire [4:0] InstrRt;
wire [4:0] InstrRd;
wire [15:0] InstrImm;
wire [31:0] SrcAD;
wire [31:0] SrcBD;
wire SignimmD;
wire PCPlus4D;

assign InstrOpcode=InstrD[31:26];
assign Instrfunc=InstrD[5:0];
assign InstrRs=InstrD[25:21];
assign InstrRt=InstrD[20:16];
assign InstrRd=InstrD[15:11];
assign InstrImm=InstrD[15:0];

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
wire [4:0] WriteRegW;
wire [31:0] ResultW;

wire RegWriteW;
wire MemtoRegW;
wire MemWriteM;



pc pc(.I_clk(I_clk),
      .I_rst(I_rst),

      .I_pc(PC0),

      .O_pc(PCF)
     );

iMem iMem(.I_add(PCF),

          .O_instr(InstrF)
         );


regfile regfile(
            .I_clk(I_clk),

            .I_reg_we(RegWriteW),
            .I_rs_addr(InstrRs),
            .I_rt_addr(InstrRt),
            .I_wb_addr(WriteRegW),
            .I_wb_data(ResultW),

            .O_rFs_data(SrcAD),
            .O_rt_data(SrcBD)
        );

control control(
        .I_opcode(InstrOpcode),
        .I_func(Instrfunc),

        .O_reg_w(RegWriteD);
.(MemtoRegD);
.O_mem_w(MemWriteD);
wire (BranchD);
wire (ALUControlD);
wire (ALUSrcD);
wire (RegDstD);
    );







endmodule
