library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is port (
   CLOCK_50   : in std_logic;
   data  : in std_logic;
   latch : out std_logic;
	clk : out std_logic;
	
	-- Buttons
	b : out std_logic :='0';
	y : out std_logic :='0';
	selectt : out std_logic :='0';
	start : out std_logic :='0';
	up : out std_logic :='0';
	down : out std_logic :='0';
	leftt : out std_logic :='0';
	rightt	: out std_logic :='0';
	a : out std_logic :='0';
	x : out std_logic :='0';
	l : out std_logic :='0';
	r : out std_logic :='0'
	

);
end entity controller;


architecture controller_arch of controller is

	signal internal_clock: std_logic := '1';
begin 
	process
		variable cnt: integer range 0 to 600 := 0;
		variable iter: integer range 0 to 32 := 0;
	begin
		
		wait until rising_edge( CLOCK_50 );
	
		if cnt >= 300 then -- Decreases the frequency (down to a 6us periodic one).
			cnt := 0;
			internal_clock <= not internal_clock; 
	
			clk <= '1';
			latch <= '0';
			iter := iter + 1;
			
			-- Latch inpulse
			if iter = 0 OR iter = 1 then
				latch <= '1';
			end if;
			
			-- Reads the value and sends the clock signal.
			if iter = 3 then
				clk <= '0';
				b <= not data;
			end if;
			if iter = 5 then
				clk <= '0';
				y <= not data;
			end if;
			if iter = 7 then
				clk <= '0';
				selectt <= not data;
			end if;
			if iter = 9 then
				clk <= '0';
				start <=  not data;
			end if;
			if iter = 11 then
				clk <= '0';
				down <=  not data;
			end if;			
			if iter = 13 then
				clk <= '0';
				up <=  not data;
			end if;
			if iter = 15 then
				clk <= '0';
				leftt <=  not data;
			end if;
			if iter = 17 then
				clk <= '0';
				rightt <=  not data;
			end if;
			if iter = 19 then
				clk <= '0';
				a <=  not data;
			end if;
			if iter = 21 then
				clk <= '0';
				x <=  not data;
			end if;
			if iter = 23 then
				clk <= '0';
				l <= not data;
			end if;
			if iter = 25 then
				clk <= '0';
				r <=  not data;
			end if;
			if iter = 27 OR iter = 29 OR iter = 31 then
				clk <= '0';
			end if;
			if iter >= 32 then
				iter := 0;
			end if;
		else
			cnt := cnt + 1;
		end if;
	end process;
end architecture controller_arch;
