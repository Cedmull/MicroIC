library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_ARITH.ALL;
use ieee.std_logic_UNSIGNED.ALL;

entity motion is 

port
(
	-- INPUTS:
	-- Clocks
	CLOCK_50   : in std_logic; -- 50 GHz clock (The FPGA frequency)
	
	-- Gamepad
	go_up : in std_logic; -- '1' if upper arrow pressed on gamepad
	go_down     : in std_logic; -- 	"	" below arrow	"	"	"	"	"	"
	go_left   : in std_logic; -- 	"	" left arrow	"	"	"	"	"	"	
	go_right  : in std_logic; -- 	"	" right arrow	"	"	"	"	"	"
	
	-- Control and initialization variables
	player_flag   : in std_logic; -- '0' for player 1, '1' if player 2
	
	-- OUTPUTs:
	-- Player position and orientation
	x_player     : buffer natural range 0     to 800;
	y_player     : buffer natural range 0     to 600
);
end motion;

architecture motion_arch of motion is
	
begin
	
	get_player_position: process
		 
		variable memo_x          : natural range 0 to 400;                 -- Memorizes and keep up to date the position of the player at any single time.
		variable memo_y          : natural range 0 to 600;                 -- These variables are used in order to avoid moving the player while being 
										     							                   -- displayed and also prevents the player to "enter" in a wall
	begin
	
		wait until rising_edge( CLOCK_50 );
		
			if player_flag = '0' then 
				memo_x := 125; -- if player 1
			else 
				memo_x := 325; -- if player 2
			end if;
			memo_y := 300;
							
				if go_up = '1' then
					memo_y := memo_y + 1;
				end if;				
				if go_down = '1' then
					memo_y := memo_y - 1;
				end if;
				if go_left = '1' then
					memo_x := memo_x - 1;
				end if;
				if go_right = '1' then 
					memo_x := memo_x + 1;
				end if;
				
	end process get_player_position;
	
	
	
end motion_arch;