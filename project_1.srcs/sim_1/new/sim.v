`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/09/12 23:41:16
// Design Name: 
// Module Name: testbench
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
reg reset;
top_cpu TOPFUNC(clk, reset);

initial begin
    // Load instructions
    $readmemh("D:/instructions.txt", TOPFUNC.iMem.I_addr);
    // Load register initial values
    $readmemh("D:/registers.txt", TOPFUNC.regfile.I_wb_addr);
    // Load memory data initial values
    $readmemh("D:/datamemory.txt", TOPFUNC.dMem.I_addr);
    
    reset = 1;
    clk = 0;
    #15 reset = 0; // 15ns开始运行
    #1000 $stop;  // 1000ns停止
end
always
    #10 clk = ~clk; // 每隔10nsclk翻转
endmodule