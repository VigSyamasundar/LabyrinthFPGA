-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity game_top is
  Port ( 
    clk : in STD_LOGIC;
    ctrBtn : in STD_LOGIC;
    leftBtn : in STD_LOGIC;
    rightBtn : in STD_LOGIC;
    upBtn : in STD_LOGIC;
    downBtn : in STD_LOGIC;
    pix_r : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pix_g : out STD_LOGIC_VECTOR ( 3 downto 0 );
    pix_b : out STD_LOGIC_VECTOR ( 3 downto 0 );
    hsync : out STD_LOGIC;
    vsync : out STD_LOGIC
  );

end game_top;

architecture stub of game_top is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
begin
end;
