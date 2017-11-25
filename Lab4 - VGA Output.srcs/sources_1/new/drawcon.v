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
reg [1:0] cells [yCells:0][xCells:0];

reg [3:0] currCellX;
reg [3:0] currCellY;
reg [1:0] currCell;

integer i;

initial
begin
    for (i=0; i < 16; i = i+1)
    begin
        cells[0][i] = 1;
        cells[15][i] = 1;
    end
    for (i=0; i < 9; i = i+1)
    begin
        cells[0][i] = 1;
        cells[8][i] = 1;
    end

end


always @ *
begin
    currCellX = draw_x / 90;
    currCellY = draw_y / 90;
    currCell = cells[currCellY][currCellX];

    /*if (currCell == 1)
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
    else if (currCell == 2)
    begin
        //Draw Hole
    end
    else if (currCell == 3)
    begin
        //Draw Target
    end
    else
    begin
        draw_r = 0;
        draw_g = 0;
        draw_b = 0;
    end*/
    draw_r = currCellX;
    draw_g = currCellX;
    draw_b = currCellY;
end

endmodule
