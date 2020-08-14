library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

entity interactions is

	port(
	
		CLOCK50 : in std_logic; 
		touching_up : in std_logic;
		touching_down : in std_logic ;
		touching_left : in std_logic ;
		touching_right : in std_logic;
		is_pushed : inout std_logic ;
		state_a : in std_logic ;
		state_down : in std_logic ;
		state_up : in std_logic ;
		state_left : in std_logic ;
		state_right : in std_logic ;
		pushed_down : out std_logic ;
		pushed_up : out std_logic ; 
		pushed_left : out std_logic ;
		pushed_right : out std_logic;
		end_push : in std_logic
		
		
	);
	
end entity;

architecture inter_arch of interactions is 

begin 

	push : process
		
		
		begin  
		
			wait until rising_edge( CLOCK50 ) ;
			-- Init
			if (end_push <= '1') then
					is_pushed <= '0';
					pushed_down <= '0';
					pushed_up <= '0';
					pushed_left <= '0';
					pushed_right <= '0';
			end if;
			
			if(is_pushed = '0') then 
			
				-- Checking if a player is pushed for all directions
				if  touching_down = '1' AND state_a = '1' AND state_down = '1' then
					pushed_down <= '1' ;
					is_pushed <= '1';
				end if;
				
				if  touching_up = '1' AND state_a = '1' AND state_up = '1' then 
					pushed_up <= '1' ;
					is_pushed <= '1';
				end if;
				
				if  touching_left = '1' AND state_a = '1' AND state_left = '1' then
					pushed_left <= '1' ;
					is_pushed <= '1';
				end if;
				
				if  touching_right = '1' AND state_a = '1' AND state_right = '1' then
					pushed_right <= '1' ;
					is_pushed <= '1' ;
				end if;	
			
			end if; 
			
			
		end process push;

end inter_arch;
