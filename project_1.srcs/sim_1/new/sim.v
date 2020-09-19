`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2020 06:53:42 PM
// Design Name: 
// Module Name: sim
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


module testbench();
reg clk;
reg rst;
top_cpu top_cpu(clk, rst);

initial begin
    $readmemh("D:/instr.txt", top_cpu.imem.R_imem);
    // Load register initial values
    $readmemh("D:/register.txt", top_cpu.regfile.R_gpr);
    // Load memory data initial values
    $readmemh("D:/data_memory.txt", top_cpu.dMem.R_dMem);
    rst = 1;
    clk = 0;

    #30 rst = 0;
    #500 $stop;
end

always
    #20 clk = ~clk;
endmodule
