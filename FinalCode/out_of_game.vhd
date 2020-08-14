library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity out_of_game is
	port
	(
	CLOCK_50   : in std_logic;
	push_start_1 : in std_logic;
	push_start_2 : in std_logic;
	start_game : buffer std_logic := '1';
	
	x_player1 : in integer range 0 to 800;
	y_player1 : in integer range 0 to 600;
	score_1 	  : inout integer range 0 to 3; 
	
	x_player2 : in integer range 0 to 800;
	y_player2 : in integer range 0 to 600;
	score_2 	  : inout integer range 0 to 3
	
	); 
	
end entity out_of_game;

architecture resets of out_of_game is 
	
	
begin

	set_start_game : process
	
		variable score_tmp_1 : integer range 0 to 3;
		variable score_tmp_2 : integer range 0 to 3;

		begin 
		
		wait until rising_edge( CLOCK_50 );
		
		score_tmp_1 := score_1;
		score_tmp_2 := score_2;
		
		if(push_start_1 = '1') OR (push_start_2 = '1') then
				
				start_game <= '0';
				score_1 <= 0;
				score_2 <= 0;
		else
			start_game <= '1';
		end if;
		
		if x_player1 = 85 OR x_player1 = 715 OR y_player1 = 45 OR y_player1 = 555 then
			start_game <= '0' ;
			if(score_tmp_2 = 2) then
				score_2 <= 0 ;
				score_1 <= 0 ; 
			else
				score_2 <= score_tmp_2 +1 ;
			end if; 
		end if;
		
		if x_player2 = 85 OR x_player2 = 715 OR y_player2 = 45 OR y_player2 = 555 then
			start_game <= '0';
			if(score_tmp_1 = 2) then
				score_1 <= 0 ;
				score_2 <= 0;
			else
				score_1 <= score_tmp_1 +1 ;
			end if; 
		end if;
		
	end process set_start_game;
	
end resets;