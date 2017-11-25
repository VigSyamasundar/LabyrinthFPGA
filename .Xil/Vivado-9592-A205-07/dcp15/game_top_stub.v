// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module game_top(clk, ctrBtn, leftBtn, rightBtn, upBtn, downBtn, 
  pix_r, pix_g, pix_b, hsync, vsync);
  input clk;
  input ctrBtn;
  input leftBtn;
  input rightBtn;
  input upBtn;
  input downBtn;
  output [3:0]pix_r;
  output [3:0]pix_g;
  output [3:0]pix_b;
  output hsync;
  output vsync;
endmodule
