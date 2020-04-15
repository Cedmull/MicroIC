---------------------------------------------------------------------------------
-- led_driver.vhd
-- Path: gsensor.vhd -> led_driver.vhd
-- sindredit@gmail.com 16 Feb 2012
-- modified by mremacle@ulg.ac.be, 24 Jan 2014
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity led_driver is
  port (
    iRSTN                   : in std_logic;   
    iCLK                    : in std_logic;   
    iDIG                    : in std_logic_vector(9 downto 0);   
    iG_inT2                 : in std_logic;   
    oLED                    : out std_logic_vector(7 downto 0)
  );   
end led_driver;

architecture translated OF led_driver is

   signal select_data              :  std_logic_vector(4 downto 0);   
   signal signed_bit               :  std_logic;   
   signal abs_select_high          :  std_logic_vector(3 downto 0);   
   signal int2_d                   :  std_logic_vector(1 downto 0);   
   signal int2_count               :  std_logic_vector(23 downto 0);
   signal int2_count_en				     :  std_logic;
 
   -- +-2g resolution : 10-bit
   signal temp_xhdl2               :  std_logic_vector(8 downto 4);   
   signal temp_xhdl3               :  std_logic_vector(4 downto 0);   
   signal temp_xhdl4               :  std_logic_vector(8 downto 4);   
   signal temp_xhdl5               :  std_logic_vector(9 downto 5);   
   signal temp_xhdl6               :  std_logic_vector(3 downto 0);   
   signal temp_xhdl7               :  std_logic_vector(7 downto 0);   
   signal temp_xhdl8               :  std_logic_vector(7 downto 0);   
   signal temp_xhdl9               :  std_logic_vector(7 downto 0);   
   signal temp_xhdl10              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl11              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl12              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl13              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl14              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl15              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl16              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl17              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl18              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl19              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl20              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl21              :  std_logic_vector(7 downto 0);   
   signal temp_xhdl22              :  std_logic_vector(7 downto 0);   
   signal oLED_xhdl1               :  std_logic_vector(7 downto 0);   

begin
  oLED <= oLED_xhdl1;
  temp_xhdl2 <= iDIG(8 downto 4) when iDIG(8) = '1' else "10000";
  temp_xhdl3 <= "01111" when iDIG(8) = '1' else iDIG(8 downto 4);
  temp_xhdl4 <= (temp_xhdl2) when iDIG(9) = '1' else (temp_xhdl3);
  temp_xhdl5 <= iDIG(9 downto 5) when iG_inT2 = '1' else (temp_xhdl4);
  select_data <= temp_xhdl5 ;
  signed_bit <= select_data(4) ;
  temp_xhdl6 <= NOT select_data(3 downto 0) when signed_bit = '1' else select_data(3 downto 0);
  abs_select_high <= temp_xhdl6 ;
  temp_xhdl7 <= "00001000" when signed_bit = '1' else "00010000";
  temp_xhdl8 <= "00001100" when signed_bit = '1' else "00110000";
  temp_xhdl9 <= "00000100" when signed_bit = '1' else "00100000";
  temp_xhdl10 <= "00000110" when signed_bit = '1' else "01100000";
  temp_xhdl11 <= "00000010" when signed_bit = '1' else "01000000";
  temp_xhdl12 <= "00000011" when signed_bit = '1' else "11000000";
  temp_xhdl13 <= "00000001" when signed_bit = '1' else "10000000";
  temp_xhdl14 <= (temp_xhdl12) when (abs_select_high(3 downto 1) = "110") else (temp_xhdl13);
  temp_xhdl15 <= (temp_xhdl11) when (abs_select_high(3 downto 1) = "101") else temp_xhdl14;
  temp_xhdl16 <= (temp_xhdl10) when (abs_select_high(3 downto 1) = "100") else temp_xhdl15;
  temp_xhdl17 <= (temp_xhdl9) when (abs_select_high(3 downto 1) = "011") else temp_xhdl16;
  temp_xhdl18 <= (temp_xhdl8) when (abs_select_high(3 downto 1) = "010") else temp_xhdl17;
  temp_xhdl19 <= (temp_xhdl7) when (abs_select_high(3 downto 1) = "001") else temp_xhdl18;
  temp_xhdl20 <= "00011000" when (abs_select_high(3 downto 1) = "000") else temp_xhdl19;
  temp_xhdl21 <= "00000000" when int2_count(20) = '1' else "11111111";
  temp_xhdl22 <= (temp_xhdl20) when int2_count(23) = '1' else (temp_xhdl21);
  oLED_xhdl1 <= temp_xhdl22 ;

  process (iRSTN, iCLK)
  begin
    if (iRSTN = '0') then   
      int2_count <= "100000000000000000000000";
	
    elsif rising_edge(iCLK) then
      int2_d <= int2_d(0) & iG_inT2;    
      if ((NOT int2_d(1) AND int2_d(0)) = '1') then   
        int2_count <= "000000000000000000000000";    
      else
        if (int2_count(23) = '0') then
          int2_count <= int2_count + "000000000000000000000001";    
        end if;
      end if;
    end if;
  end process;

end translated;
