---------------------------------------------------------------------------------
-- reset_delay.vhd
-- Path: gsensor.vhd -> reset_delay.vhd
-- sindredit@gmail.com 16 Feb 2012
-- modified by mremacle@ulg.ac.be, 24 Jan 2014
-- Reset delay
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reset_delay is
  port (
    iRSTN                   : in std_logic;   
    iCLK                    : in std_logic;   
    oRST                    : out std_logic
    );   
end reset_delay;

architecture translated OF reset_delay is

   signal cont              :  std_logic_vector(20 downto 0);   
   signal oRST_xhdl1        :  std_logic;   

begin
  oRST <= oRST_xhdl1;

  process (iCLK,iRSTN)
  begin
    if (iRSTN = '0') then
      cont <= "000000000000000000000";    
      oRST_xhdl1 <= '1';    
    elsif rising_edge(iCLK) then
      if (NOT cont(20) = '1') then
        cont <= cont + "000000000000000000001";    
        oRST_xhdl1 <= '1';    
      else
        oRST_xhdl1 <= '0';    
      end if;
    end if;
  end process;

end translated;
