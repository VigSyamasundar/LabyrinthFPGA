`timescale 1ns / 1ps
`define 
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 24.11.2017 13:54:27
// Design Name:
// Module Name: game_top
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


module game_top(
    input clk,
    /*input [3:0] SW_R,
    input [3:0] SW_G,
    input [3:0] SW_B,*/
    input ctrBtn,
    input leftBtn,
    input rightBtn,
    input upBtn,
    input downBtn,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output hsync,
    output vsync
    );


parameter xCells = 16;
parameter yCells = 9;
//TODO: Change the number of cases later
wire [1:0] cells [yCells:0][xCells:0];


wire currCell

wire [10:0] curr_x;
wire [9:0] curr_y;
wire pixclk;
wire frameclk;

reg [10:0] blkpos_x = 715;
reg [9:0] blkpos_y = 445;
reg [10:0] draw_x = 0;
reg [9:0] draw_y = 0;

clk_wiz_0 disp_clk(.clk_out1(pixclk),.clk_in1(clk));

wire [3:0] tmpR;
wire [3:0] tmpG;
wire [3:0] tmpB;

vga_out display (.clk(pixclk), .frameclk(frameclk), .in_R(tmpR), .in_G(tmpG), .in_B(tmpB), .hsync(hsync), .vsync(vsync), .curr_x(curr_x), .curr_y(curr_y), .pix_r(pix_r), .pix_g(pix_g), .pix_b(pix_b));
drawcon draw_mod (.draw_r(tmpR), .draw_g(tmpG), .draw_b(tmpB), .draw_x(curr_x), .draw_y(curr_y),.blkpos_x(blkpos_x),.blkpos_y(blkpos_y));

always @ (posedge frameclk)
begin
    /*Square 32x32
    if (ctrBtn)
    begin
        blkpos_x = 715;
        blkpos_y = 445;
    end
    if (leftBtn && (blkpos_x > 7))
    begin
        blkpos_x = blkpos_x - 1;
    end
    if (rightBtn && (blkpos_x < 1398))
    begin
        blkpos_x = blkpos_x + 1;
    end
    if (upBtn && (blkpos_y > 8))
    begin
        blkpos_y = blkpos_y - 1;
    end
    if (downBtn  && (blkpos_y < 859))
    begin
        blkpos_y = blkpos_y + 1;
    end*/

//  Circle Radius 15
    if (ctrBtn)
    begin
        blkpos_x = 715;
        blkpos_y = 445;
    end
    if (leftBtn && (blkpos_x > 22))
    begin
        blkpos_x = blkpos_x - 1;
    end
    if (rightBtn && (blkpos_x < 1414))
    begin
        blkpos_x = blkpos_x + 1;
    end
    if (upBtn && (blkpos_y > 23))
    begin
        blkpos_y = blkpos_y - 1;
    end
    if (downBtn  && (blkpos_y < 875))
    begin
        blkpos_y = blkpos_y + 1;
    end
end

endmodule
