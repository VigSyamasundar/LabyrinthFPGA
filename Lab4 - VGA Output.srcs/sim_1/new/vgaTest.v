`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.11.2017 15:09:36
// Design Name: 
// Module Name: vgaTest
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


module vgaTest();
    reg clk;
    initial clk = 0;
    always #5 clk = ~clk;
    vga_out vgaI ( .clk(clk)); 
endmodule
