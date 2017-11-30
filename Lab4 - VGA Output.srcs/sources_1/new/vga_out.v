`timescale 1ns / 1ps

module vga_out(
    input clk,
    output frameclk,
    output moveclk,
    input [3:0] in_R,
    input [3:0] in_G,
    input [3:0] in_B,
    output [3:0] pix_r,
    output [3:0] pix_g,
    output [3:0] pix_b,
    output hsync,
    output vsync,
    output reg [10:0] curr_x,
    output reg [9:0] curr_y
    );
reg [10:0] hcount = 0;
reg [9:0] vcount = 0;

reg [3:0] R_pix_r;
reg [3:0] R_pix_g;
reg [3:0] R_pix_b;

always@(posedge clk)
    begin
    R_pix_r <= in_R;
    R_pix_g <= in_G;
    R_pix_b <= in_B;

    if (hcount == 11'd1903)
        begin
        hcount <= 0;
        if (vcount == 931)
            vcount <= 0;
        else
            vcount <= vcount + 10'd1;
        end
    else
        hcount <= hcount + 11'd1;
    if ((384<=hcount) & (hcount<=1823) & (31<= vcount) & (vcount<=930))
       begin
       curr_x <= hcount - 11'd384;
       curr_y <= vcount - 10'd31;
       end
    end

assign hsync = (hcount > 151)? 1:0;
assign vsync = (vcount >2)? 0:1;
assign frameclk = (vcount==0 | vcount ==482 )?1:0;
assign moveclk = (vcount==0 | vcount ==321 | vcount ==642)? 1:0;

assign pix_r = (((384<=hcount) & (hcount<=1823))&((31<= vcount)&(vcount<=930)))? R_pix_r:0;
assign pix_g = (((384<=hcount) & (hcount<=1823))&((31<= vcount)&(vcount<=930)))? R_pix_g:0;
assign pix_b = (((384<=hcount) & (hcount<=1823))&((31<= vcount)&(vcount<=930)))? R_pix_b:0;

endmodule
