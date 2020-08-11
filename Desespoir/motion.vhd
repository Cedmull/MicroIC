library ieee;
use ieee.std_logic_1164.ALL;
use ieee.std_logic_ARITH.ALL;
use ieee.std_logic_UNSIGNED.ALL;

entity motion is 

generic(
	constant collision_radius : natural := 30
	);

port
(
	
	
	CLOCK_50   : in std_logic;
	
	-- Controller
	go_up : in std_logic; -- '1' if up button is pushed
	go_down     : in std_logic; -- 	'1' if down button is pushed
	go_left   : in std_logic; -- 	'1' if left button is pushed	
	go_right  : in std_logic; -- 	'1' if right button is pushed
	push_start : in std_logic; -- 	'1' if start button is pushed
	
	-- Player info
	player_id   	  : in std_logic; -- '0' for player 1 and '1' for player 2
	-- Game init
	start_game	  : in std_logic; -- '0' to start
	
	-- Player position
	x_player     : buffer natural range 0     to 800;
	y_player     : buffer natural range 0     to 600;
	x_player_2   : in natural range 0 	  to 800;
	y_player_2   : in natural range 0	  to 600;
	
	-- Speed counter
	cnt_move     : buffer natural range 0 to 100000
);
end motion;

architecture motion_arch of motion is
	
begin
	
	move: process
			variable tmp_x : integer range 0 	to 800;	-- save the abscissa of player 1	
			variable tmp_y : integer range 0 	to 600; -- save the ordinate of player 1
			variable tmp_x_2 : integer range 0 to 600; -- save the abscissa of player 2
			variable tmp_y_2 : integer range 0 to 600; -- save the ordinate of player 2
			variable counter :integer range 0 	to 100000; -- speed counter to decrease the internal clock
			variable pos_diff_x : integer range -1000  to 1000; -- horizontal distance between players
			variable pos_diff_y : integer range -1000  to 1000; -- vertical distance between players
			variable is_touching_left : std_logic:= '0'; -- variable to check if there is a collision on the left side
			variable is_touching_right : std_logic:='0'; -- variable to check if there is a collision on the right side
			variable is_touching_up : std_logic := '0'; -- variable to check if there is a collision on the upper side
			variable is_touching_down : std_logic := '0'; -- variable to check if there is a collision on the bottom side
	
	begin
		
		wait until rising_edge( CLOCK_50 );
		
		-- Init the game at given position when pushing on start
		if(start_game = '0') then
			if player_id = '0' then
				tmp_x := 200;
				x_player <= tmp_x;
			else
				tmp_x := 600;
				x_player <= tmp_x;
			end if;
			tmp_y := 300;	
			
			
			y_player <= tmp_y;
			
		-- Init speed counter
		counter := cnt_move;
		elsif(counter = 100000) then
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
			
			-- Re-init of collision variables
			is_touching_left := '0'; 
			is_touching_right := '0';
			is_touching_down := '0'; 
			is_touching_up := '0';
			
			-- Posisiton update
			x_player <= tmp_x;
			y_player <= tmp_y; 
		-- Re-init counter
		counter := 0;
		cnt_move <= counter ; 
	
		else
		counter := counter + 1 ;
		cnt_move <= counter ;
		end if;
		
				
	end process move;
	
	
	
end motion_arch;
