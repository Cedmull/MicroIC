library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller is port (
   clk   : in std_logic;
   data  : in std_logic;
   latch : inout std_logic;
   state : out std_logic_vector(15 downto 0)
);
end entity controller;

architecture controller_arch of controller is
   signal phase   : integer range 0 to 15 := 15;
begin
   controller_p : process (clk)
   begin
      if rising_edge(clk) then
         if latch = '0' then
            state(phase) <= data;
            if phase = 15 then
               phase <= 0;
               latch <= '1';
            else
               phase <= phase + 1;
            end if;
         elsif latch = '1'then
            latch <= '0';
         else
            -- When the entity starts, latch = 'U', this is an
            -- init somehow..
            phase <= 0;
            latch <= '1';
         end if;
      end if;
   end process controller_p;
end architecture controller_arch;
