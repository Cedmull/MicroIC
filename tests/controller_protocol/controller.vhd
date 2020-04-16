library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is port (
	clk   : in std_logic;
	data  : in std_logic;
	latch : out std_logic;
	state : out std_logic_vector(15 downto 0)
);
end entity controller;

architecture controller_arch of controller is
   signal ready   : std_logic             := '0';
   signal writing : std_logic             := '0';
   signal phase   : integer range 0 to 15 := 15;
begin
	controller_p : process (clk)
	begin
		if rising_edge(clk) then
			ready <= '1';

			if (phase = 15) and (writing = '0') then
				latch <= '1';
				writing <= '1';
			else
				latch <= '0';
				writing <= '0';
         end if;

			if (phase = 15) and (writing = '1') then
            phase <= 0;
         elsif phase /= 15 then
            phase <= phase + 1;
         end if;

         if (ready = '1') and (writing = '0') then
            state(phase) <= data;
         end if;
		end if;
	end process controller_p;
end architecture controller_arch;
