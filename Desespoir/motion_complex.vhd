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
	push_start : in std_logic; -- if start lololol
	push_b : in std_logic; 
	
	-- Control and initialization variables
	player_id   : in std_logic; -- '0' for player 1, '1' if player 2
	start_game	: in std_logic; -- '0' to start
	is_pushed   : in std_logic;
	pushed_down : in std_logic;
	pushed_up 	: in std_logic;
	pushed_left : in std_logic;
	pushed_right : in std_logic;
	-- OUTPUTs:
	-- Player position and orientation
	x_player     : buffer natural range 0 		to 800;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                buffer natural range 0     to 800;
	y_player     : buffer natural range 0     to 600;
	x_player_2 	 : in natural 		range 0 		to 800;
	y_player_2	 : in natural 		range 0 		to 600;
	cnt_move  	 : buffer natural range 0 		to 100000;
	cnt_push		 : buffer natural range 0 		to 50000;
	cnt_push_2   : buffer natural range 0 		to 200;
	player_tp 	 : inout std_logic;
	touching_down: out std_logic;
	touching_up	 : out std_logic;
	touching_left: out std_logic;
	touching_right:out std_logic
	
	-- Players tates
);
end motion;

architecture motion_arch of motion is
	
begin
	
	move: process
		                  -- These variables are used in order to avoid moving the player while being 
			variable tmp_x : integer range 0 	to 800;		-- displayed and also prevents the player to "enter" in a wall
			variable tmp_y : integer range 0 	to 600;
			variable tmp_x_2 : integer range 0 to 600;
			variable tmp_y_2 : integer range 0 to 600;
			variable counter :integer range 0 	to 100000;
			variable counter_push : integer range 0 to 50000 := 0;
			variable counter_push_2 : integer range 0 to 200 := 0;
			variable pos_diff_x : integer range -1000  to 1000;
			variable pos_diff_y : integer range -1000  to 1000;
			variable is_touching_left : std_logic:= '0';
			variable is_touching_right : std_logic:='0';
			variable is_touching_up : std_logic := '0';
			variable is_touching_down : std_logic := '0';
			variable pushed : std_logic;
	
	begin
		
		wait until rising_edge( CLOCK_50 );
		
		
		tmp_y := 300;	
		counter := cnt_move;
		counter_push := cnt_push;
		counter_push_2 := cnt_push_2;
		
		
		
		if(start_game = '0') then
			if player_id = '0' then
				tmp_x := 200;
				x_player <= tmp_x;
				y_player <= tmp_y;
			else
				tmp_x := 600;
				x_player <= tmp_x;
				y_player <= tmp_y;
			end if;

		else
			tmp_x := x_player;
			tmp_y := y_player;
			tmp_x_2 := x_player_2;
			tmp_y_2 := y_player_2;
			pos_diff_x := tmp_x - tmp_x_2 ;
			pos_diff_y := tmp_y - tmp_y_2 ;
			
			
			if pos_diff_x > 30 OR pos_diff_x < -29 OR pos_diff_y > 29 OR pos_diff_y < -29 then 
				is_touching_left := '1' ;
			else
				touching_left <= '1' ;
			end if;
			
			if pos_diff_x < -30 OR pos_diff_x > 29 OR pos_diff_y > 29 OR pos_diff_y < -29 then
				is_touching_right := '1' ;	
			else
				touching_right <= '1' ;
			end if;
			
			if pos_diff_y < -30 OR pos_diff_y > 29 OR pos_diff_x > 29 OR pos_diff_x < -29 then
				is_touching_up := '1';
			elsif ( is_touching_left ='0' OR is_touching_right ='0' ) then
				is_touching_up := '1' ;
			else
				touching_up <= '1' ;
			end if;
			
			if pos_diff_y > 30 OR pos_diff_y < -29 OR pos_diff_x > 29 OR pos_diff_x < -29 then
				is_touching_down := '1' ;
			elsif is_touching_left ='0' OR is_touching_right ='0' then
				is_touching_down := '1' ;
			else
				touching_down <= '1' ;
			end if;
			
			if push_b = '1' AND player_tp = '1' AND tmp_x_2 - 400 > 32 AND tmp_x_2 - 400 < -32 AND tmp_y_2 -300 > 32 AND tmp_y_2 -300 < -32 then
				tmp_x := 400;
				tmp_y := 300;
				player_tp <= '0';	
		
			elsif is_pushed = '1' then
	
				if cnt_push_2 = 200 then
					is_pushed <= '0';
					pushed_down <= '0';
					pushed_up <= '0';
					pushed_left <= '0';
					pushed_right <= '0';
				
				elsif cnt_push = 50000 then 
					
					if pushed_left = '1' then
						tmp_x := tmp_x - 1;
					elsif pushed_right = '1' then
						tmp_x := tmp_x + 1;
					elsif pushed_up = '1' then
						tmp_x := tmp_x + 1;
					elsif pushed_down = '1' then
						tmp_x := tmp_x - 1;
					end if;
					
					counter_push_2 := counter_push_2 +1;
					cnt_push_2 <= counter_push_2;
					counter_push := 0;
					cnt_push <= counter_push;
				
				else
					counter_push := counter_push + 1 ; 
					cnt_push <= counter_push; 
				end if;
				
				
			
			elsif(counter = 100000) then
			
				
			
				if go_left = '1' AND is_touching_left = '1' AND tmp_x > 85 then
					tmp_x := tmp_x - 1;
				end if; 
			
				if go_right = '1' AND is_touching_right = '1' AND tmp_x < 715 then 
					tmp_x := tmp_x + 1 ;
				end if;
			
				if go_up = '1' AND is_touching_up = '1' AND tmp_y < 555 then 
					tmp_y := tmp_y + 1;
				end if;
			
				if go_down = '1' AND is_touching_down = '1' AND tmp_y > 45 then
					tmp_y := tmp_y - 1;
				end if;
			
				counter := 0;
				cnt_move <= counter ; 
	
			else
				counter := counter + 1 ;
				cnt_move <= counter ;
			end if;
			
			is_touching_left := '0'; 
			is_touching_right := '0';
			is_touching_down := '0'; 
			is_touching_up := '0';
			
			x_player <= tmp_x;
			y_player <= tmp_y;
		end if;
				
	end process move;
	
end motion_arch;
