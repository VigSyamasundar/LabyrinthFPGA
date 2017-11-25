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

parameter xCells = 16;
parameter yCells = 9;
//TODO: Change the number of cases later
wire [1:0] cells [yCells:0][xCells:0];

reg [3:0] currCellX;
reg [3:0] currCellY;
reg [1:0] currCell;


always @ *
begin
    currCellX = draw_x / 90;
    currCellY = draw_y / 90;
    currCell = cells[currCellY][currCellX];

    if (currCell == 0)
    begin
        //Draw border
        draw_r = 12;
        draw_g = 10;
        draw_b = 3;
    end
    else if (currCell == 0)
    begin
        //Draw Board
    end
    else if (currCell == 1)
    begin
        //Draw Hole
    end
    else if (currCell == 2)
    begin
        //Draw Target
    end
    else
    begin
        draw_r = 0;
        draw_g = 0;
        draw_b = 0;
    end
end

endmodule
