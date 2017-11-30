`timescale 1ns / 1ps
module drawcon(
    input [10:0] draw_x,
    input [9:0] draw_y,
    input ctrBtn,
    input leftBtn,
    input rightBtn,
    input upBtn,
    input downBtn,
    input frameclk,
    input moveclk,
    input pixclk,
    output reg [3:0] draw_r,
    output reg [3:0] draw_g,
    output reg [3:0] draw_b
    );
reg [10:0] holeCenterX;
reg [9:0] holeCenterY;
parameter holeRad = 20;
reg [10:0] blkpos_x = 200;
reg [9:0] blkpos_y = 200;
parameter xCells = 32;
parameter yCells = 20;
parameter cellWidth = 45;
parameter ballRad = 15;
reg [3:0] bkg_r = 0, bkg_g=6, bkg_b=0;

//TODO: Change the number of cases later
reg [1:0] cells [yCells:0][xCells:0];
reg [5:0] currCellX;
reg [4:0] currCellY;
reg [1:0] currCell;
integer i;

reg [10:0] LHoleCenterX;
reg [9:0] LHoleCenterY;
reg [5:0] LCurrCellX;
reg [4:0] LCurrCellY;
reg [1:0] LCurrCell;
reg drawGrids = 1;

initial
begin
//border start
    for (i=0; i < yCells; i = i+1)
    begin
        cells[i][0] = 1;
        cells[i][xCells - 1] = 1;
    end
    for (i=0; i < xCells; i = i+1)
    begin
        cells[0][i] = 1;
        cells[yCells - 1][i] = 1;
    end
//border end
    for (i=0; i < 16; i = i+1)
    begin
        cells[i][8] = 1;
        cells[i][24] = 1;
    end

    for (i=0; i < 7; i = i+1)
    begin
        cells[i][16] = 1;
    end

    for (i=10; i < yCells-1; i = i+1)
    begin
        cells[i][16] = 1;
    end

    cells[2][29] = 3; //Finish Hole

    //Holes
    cells[yCells - 3][2] = 2;
    cells[3][10] = 2;
    cells[3][22] = 2;
    cells[yCells - 3][12] = 2;
    cells[14][26] = 2;
end


always @ (posedge frameclk)
begin
    LCurrCellX = blkpos_x / cellWidth;
    LCurrCellY = blkpos_y / cellWidth;
    LCurrCell = cells[LCurrCellY][LCurrCellX];
    if (LCurrCell == 2)
    begin
        LHoleCenterX = ((currCellX * cellWidth)+((currCellX+1) * cellWidth))/2;
        LHoleCenterY = ((currCellY * cellWidth)+((currCellY+1) * cellWidth))/2;
        if (((LHoleCenterX - blkpos_x)**2 + (LHoleCenterY - blkpos_y)**2) <= (ballRad) ** 2)
        begin
            blkpos_x = 200;
            blkpos_y = 200;
        end
    end
    if (ctrBtn)
    begin
        blkpos_x = 200;
        blkpos_y = 200;
    end
    else
    begin
        if (leftBtn)
        begin
            if (cells[blkpos_y/cellWidth][(blkpos_x/cellWidth)-1]!=1)
                blkpos_x = blkpos_x - 1;
            else if ((cells[blkpos_y/cellWidth][(blkpos_x/cellWidth)-1]==1) && ((blkpos_x - ((blkpos_x/cellWidth)*cellWidth)) > ballRad))
                blkpos_x = blkpos_x - 1;
        end

        if (rightBtn)
        begin
            if (cells[blkpos_y/cellWidth][(blkpos_x/cellWidth+1)]!=1)
                blkpos_x = blkpos_x + 1;
            else if ((cells[blkpos_y/cellWidth][(blkpos_x/cellWidth+1)]==1) && (((((blkpos_x/cellWidth) + 1)*cellWidth) - blkpos_x) > ballRad))
                blkpos_x = blkpos_x + 1;
        end
        if (upBtn)
        begin
            if (cells[(blkpos_y/cellWidth)-1][blkpos_x/cellWidth]!=1)
                blkpos_y = blkpos_y - 1;
            else if ((cells[(blkpos_y/cellWidth)-1][blkpos_x/cellWidth]==1) && ((blkpos_y - ((blkpos_y/cellWidth)*cellWidth)) > ballRad))
                blkpos_y = blkpos_y - 1;
        end
        if (downBtn)
        begin
            if (cells[(blkpos_y/cellWidth)+1][blkpos_x/cellWidth]!=1)
                blkpos_y = blkpos_y + 1;
            else if ((cells[(blkpos_y/cellWidth)+1][blkpos_x/cellWidth]==1) && (((((blkpos_y/cellWidth) + 1)*cellWidth) - blkpos_y) > ballRad))
                blkpos_y = blkpos_y + 1;
        end
    end
end

always @ *
begin
    currCellX = draw_x / cellWidth;
    currCellY = draw_y / cellWidth;
    currCell = cells[currCellY][currCellX];

    if (drawGrids && (draw_x/cellWidth)*cellWidth == draw_x || (draw_y/cellWidth)*cellWidth == draw_y)
    begin
        draw_r = 15;
        draw_g = 15;
        draw_b = 15;
    end

    //Draw the ball
    if (((draw_x - blkpos_x)**2 + (draw_y - blkpos_y)**2) <= (ballRad) ** 2)
    begin
        if (((draw_x - blkpos_x)**2 + (draw_y - blkpos_y)**2) <= (ballRad-3) ** 2)
        begin
            draw_r = 15;
            draw_g = 15;
            draw_b = 15;
        end
        else
        begin
            draw_r = 10;
            draw_g = 0;
            draw_b = 0;
        end
    end
    else
    begin
        if (currCell == 0)
        begin
            //Draw Board
            draw_r = bkg_r;
            draw_g = bkg_g;
            draw_b = bkg_b;
        end
        else if (currCell == 1)
        begin
            //Draw wallls
            draw_r = 8;
            draw_g = 4;
            draw_b = 1;
        end
        else if (currCell == 2)
        begin
            //Draw Hole
            holeCenterX = ((currCellX * cellWidth)+((currCellX+1) * cellWidth))/2;
            holeCenterY = ((currCellY * cellWidth)+((currCellY+1) * cellWidth))/2;
            if (((draw_x - holeCenterX)**2 + (draw_y - holeCenterY)**2) > (holeRad**2))
            begin
                draw_r = 15;
                draw_g = 15;
                draw_b = 15;
            end
            else
            begin
                draw_r = 0;
                draw_g = 0;
                draw_b = 0;
            end
        end
        else if (currCell == 3)
        begin
            //Draw Target
            draw_r = 15;
            draw_g = 15;
            draw_b = 15;
        end
        else
        begin
            draw_r = 0;
            draw_g = 0;
            draw_b = 0;
        end
    end
end

endmodule
