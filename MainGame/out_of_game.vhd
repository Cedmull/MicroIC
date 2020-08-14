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
	
	
begin

	process
	
		begin 
		
		wait until rising_edge( CLOCK_50 );
		
		if(push_start_1 = '1') OR (push_start_2 = '1') then
				
				start_game <= '0';
		else
			start_game <= '1';
		end if;
	end process;
	
end be_cool;