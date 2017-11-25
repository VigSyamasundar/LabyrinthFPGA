`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.11.2017 18:49:18
// Design Name: 
// Module Name: drawcon
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


module drawcon(
    input [10:0] blkpos_x,
    input [9:0] blkpos_y,
    input [10:0] draw_x,
    input [9:0] draw_y,
    output reg [3:0] draw_r,
    output reg [3:0] draw_g,
    output reg [3:0] draw_b
    );
    
reg [3:0] bg_r = 0;
reg [3:0] bg_g = 0;
reg [3:0] bg_b = 0;     

reg [3:0] blk_r = 0;
reg [3:0] blk_g = 0;
reg [3:0] blk_b = 0;    

always @ *
begin
//    if ((draw_x > blkpos_x) & (draw_x < blkpos_x+32) & (draw_y > blkpos_y) & (draw_y < blkpos_y+32))    Square 32x32
    if (((draw_x - blkpos_x)**2 + (draw_y - blkpos_y)**2) <= 15**2)  // Circle Radius 15
    begin
        blk_r = 4'd15;
        blk_g = 4'd0;
        blk_b = 4'd0; 
    end
    else
    begin
        blk_r = 4'd0;
        blk_g = 4'd0;
        blk_b = 4'd0;
    end    
end
    
always @ * 
    if ((draw_x < 8) | (draw_x > 1429) | (draw_y <9) | (draw_y > 890))
    begin
        bg_r = 4'd12;
        bg_g = 4'd10;
        bg_b = 4'd3; 
    end
    else
    begin
        bg_r = 4'd0;
        bg_g = 4'd0;
        bg_b = 4'd0; 
    end

always @ *
begin
    draw_r = ((blk_r == 0) & (blk_g == 0) & (blk_b == 0))?bg_r:blk_r;
    draw_g = ((blk_r == 0) & (blk_g == 0) & (blk_b == 0))?bg_g:blk_g;
    draw_b = ((blk_r == 0) & (blk_g == 0) & (blk_b == 0))?bg_b:blk_b;
end 

        
endmodule
