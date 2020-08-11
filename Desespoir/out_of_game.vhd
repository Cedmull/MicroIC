library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity out_of_game is
	port
	(
	CLOCK_50   : in std_logic;
	push_start_1 : in std_logic;
	push_start_2 : in std_logic;
	start_game : buffer std_logic := '1'
	); 
	
end entity out_of_game;

architecture be_cool of out_of_game is 
	
	signal is_pushed_1 : std_logic := '0';
	signal is_pushed_2 : std_logic := '0';
	signal launch : std_logic;
	
begin

	process
	
		begin 
		
		wait until rising_edge( CLOCK_50 );
		
		if(start_game = '1') then
		
			is_pushed_1 <= push_start_1 ;
			is_pushed_2 <= push_start_2 ; 
		
			if(is_pushed_1 = '1') OR (is_pushed_2 = '1') then
				launch <= '0';
				start_game <= launch;
			end if;
		end if;
	end process;
	
end be_cool;
	
end be_cool;
