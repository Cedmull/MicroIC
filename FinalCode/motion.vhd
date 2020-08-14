library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_ARITH.ALL;
use ieee.std_logic_UNSIGNED.ALL;

entity motion is 

port
(
CLOCK_50   : in std_logic; -- 50 MHz
	
	-- Controller
	go_up : in std_logic; -- '1' if up button is pushed
	go_down     : in std_logic; -- '1' if down button is pushed
	go_left   : in std_logic; -- '1' if left button is pushed	
	go_right  : in std_logic; -- '1' if right button is pushed
	push_start : in std_logic; -- '1' if start button is pushed
	push_b : in std_logic; -- '1' if b button is pushed
	
	-- Player info
	player_id   : in std_logic; -- '0' for player 1 and '1' if player 2
	-- Game init
	start_game	: in std_logic; -- '0' to start
	-- Interractions 
	is_pushed   : in std_logic; -- '1' if a player is pushed
	pushed_down : in std_logic; 
	pushed_up 	: in std_logic;
	pushed_left : in std_logic;
	pushed_right : in std_logic;
	
	-- Player position
	x_player     : buffer natural range 0     to 800;
	y_player     : buffer natural range 0     to 600;
	x_player_2 	 : in natural 		range 0 		to 800;
	y_player_2	 : in natural 		range 0 		to 600;
	-- Speed and motion counter
	cnt_move  	 : buffer natural range 0 		to 100000;
	cnt_push		 : buffer natural range 0 		to 50000;
	cnt_push_2   : buffer natural range 0 		to 202;
	-- Player state
	player_tp 	 : inout std_logic;
	touching_down: out std_logic;
	touching_up	 : out std_logic;
	touching_left: out std_logic;
	touching_right:out std_logic;
	end_push		 : buffer std_logic;
	-- Scores
	score_1 		 : in integer range 0 to 3;
	score_2 		 : in integer range 0 to 3
	
	
);
end motion;

architecture motion_arch of motion is
	
begin
	
	move: process
		   
			variable tmp_x : integer range 0 	to 800; -- save the abscissa of player 1
			variable tmp_y : integer range 0 	to 600; -- save the ordinate of player 1
			variable tmp_x_2 : integer range 0 to 600; -- save the abscissa of player 2
			variable tmp_y_2 : integer range 0 to 600; -- save the ordinate of player 2
			variable counter :integer range 0 	to 100000; -- speed counter to decrease the internal clock
			variable counter_push : integer range 0 to 20000 := 0;
			variable counter_push_2 : integer range 0 to 202 := 0;
			variable pos_diff_x : integer range -1000  to 1000;
			variable pos_diff_y : integer range -1000  to 1000;
			variable is_touching_left : std_logic:= '0'; -- variable to check if there is a collision on the left side
			variable is_touching_right : std_logic:='0'; -- variable to check if there is a collision on the right side
			variable is_touching_up : std_logic := '0'; -- variable to check if there is a collision on the upper side
			variable is_touching_down : std_logic := '0'; -- variable to check if there is a collision on the bottom side
			variable pushed : std_logic; -- variable related to the pushing motion
	
	begin
		
		wait until rising_edge( CLOCK_50 );
		
		-- Init y position
		tmp_y := 300;	
		-- Init speed and motion counter
		counter := cnt_move;
		counter_push := cnt_push;
		counter_push_2 := cnt_push_2;
		
		-- Init the game at given position when pushing on start
		
		if(start_game = '0' AND score_1 = 0 AND score_2 = 0) then
			if player_id = '0' then
				tmp_x := 200;
				x_player <= tmp_x;
				y_player <= tmp_y;
			else
				tmp_x := 600;
				x_player <= tmp_x;
				y_player <= tmp_y;
			end if;
			player_tp <= '1';
			
		else
			--Save the players positions
			tmp_x := x_player;
			tmp_y := y_player;
			tmp_x_2 := x_player_2;
			tmp_y_2 := y_player_2;
			pos_diff_x := tmp_x - tmp_x_2 ;
			pos_diff_y := tmp_y - tmp_y_2 ;
			
			-- Left collision between players
			if pos_diff_x > 30 OR pos_diff_x < -29 OR pos_diff_y > 29 OR pos_diff_y < -29 then 
				is_touching_left := '1' ;
			end if;
			
			-- Right collision between players
			if pos_diff_x < -30 OR pos_diff_x > 29 OR pos_diff_y > 29 OR pos_diff_y < -29 then
				is_touching_right := '1' ;	
			end if;
			
			-- Top collision between players
			if pos_diff_y < -30 OR pos_diff_y > 29 OR pos_diff_x > 29 OR pos_diff_x < -29 then
				is_touching_up := '1';
			elsif ( is_touching_left ='0' OR is_touching_right ='0' ) then
				is_touching_up := '1' ;
			end if;
			
			-- Bottom collision between players
			if pos_diff_y > 30 OR pos_diff_y < -29 OR pos_diff_x > 29 OR pos_diff_x < -29 then
				is_touching_down := '1' ;
			elsif is_touching_left ='0' OR is_touching_right ='0' then
				is_touching_down := '1' ;
			end if;
			
			-- Bottom interraction between players
			if pos_diff_y = 30 AND pos_diff_x < 29 AND pos_diff_x > -29 then 
				touching_down <= '1';
			else
				touching_down <= '0';
			end if;
			
			-- Top interraction between players	
			if pos_diff_y = -30 AND pos_diff_x < 29 AND pos_diff_x > -29 then 
				touching_up <= '1' ;
			else
				touching_up <= '0';
			end if;
			
			-- Left interraction between players
			if pos_diff_x = 30 AND pos_diff_y < 29 AND pos_diff_y > -29 then 
				touching_left <= '1' ;
			else
				touching_left <= '0';
			end if;
			
			-- Right interraction between players
			if pos_diff_x = -30 AND pos_diff_y < 29 AND pos_diff_y > -29 then 
				touching_right <= '1' ;
			else
				touching_right <= '0' ;
			end if; 
			
			-- TP action
			if push_b = '1' AND player_tp = '1' AND (tmp_x_2 - 400 > 32 OR tmp_x_2 - 400 < -32 OR tmp_y_2 -300 > 32 OR tmp_y_2 -300 < -32) then
				tmp_x := 400;
				tmp_y := 300;
				player_tp <= '0';	
		
			elsif is_pushed = '1' then

				
				-- End of the pushing motion
				if cnt_push_2 = 200 then
					end_push <= '1';
					cnt_push_2 <= 201;
				elsif cnt_push_2 = 201 then
					cnt_push_2 <= 202;
				elsif cnt_push_2 = 202 then
					end_push <= '0';
					cnt_push_2 <= 0;
					
				-- speed of the pushing motion
				elsif cnt_push = 20000 then 
					
					if pushed_left = '1' then
						tmp_x := tmp_x - 1;
					elsif pushed_right = '1' then
						tmp_x := tmp_x + 1;
					elsif pushed_up = '1' then
						tmp_y := tmp_y + 1;
					elsif pushed_down = '1' then
						tmp_y := tmp_y - 1;
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
			
				
				-- Left border collision on the ring
				if go_left = '1' AND is_touching_left = '1' AND tmp_x > 85 then
					tmp_x := tmp_x - 1;
				end if; 
				
				-- Right border collision on the ring
				if go_right = '1' AND is_touching_right = '1' AND tmp_x < 715 then 
					tmp_x := tmp_x + 1 ;
				end if;
				
				-- Top border collision on the ring
				if go_up = '1' AND is_touching_up = '1' AND tmp_y < 555 then 
					tmp_y := tmp_y + 1;
				end if;
				
				-- Bottom border collision on the ring
				if go_down = '1' AND is_touching_down = '1' AND tmp_y > 45 then
					tmp_y := tmp_y - 1;
				end if;
			
				counter := 0;
				cnt_move <= counter ; 
	
			else
				counter := counter + 1 ;
				cnt_move <= counter ;
			end if;
			
			-- Re-init of collision variables
			is_touching_left := '0'; 
			is_touching_right := '0';
			is_touching_down := '0'; 
			is_touching_up := '0';
			
			-- Posisiton update
			x_player <= tmp_x;
			y_player <= tmp_y;
		end if;
				
	end process move;
	
end motion_arch;
