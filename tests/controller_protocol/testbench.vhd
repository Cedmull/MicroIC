library ieee;
use ieee.std_logic_1164.all;
library work;

entity testbench is end testbench;

architecture testbench_arch of testbench is
   signal clk   : std_logic := '0';
   signal data  : std_logic := '1'; -- Forced to 1
   signal latch : std_logic;
   signal state : std_logic_vector(15 downto 0);
begin
   controller : entity work.controller(controller_arch)
      port map(clk => clk, data => data, latch => latch, state => state);

   -- Updates the clock
   clk <= '1' after 0.5 ns when clk = '0' else
          '0' after 0.5 ns when clk = '1';
end testbench_arch;
