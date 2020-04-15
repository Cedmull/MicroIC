---------------------------------------------------------------------------------
-- spi_controller.vhd
-- Path: gsensor.vhd -> spi_ee_config.vhd -> spi_controller.vhd
-- sindredit@gmail.com 16 Feb 2012
-- 
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity spi_controller is
  generic (
    -- Data MSB Bit
    IDLE_MSB                       :  integer := 14;    
    SI_DataL                       :  integer := 15;    
    SO_DataL                       :  integer := 7;    
    -- Write/Read Mode 
    WRITE_MODE                     :  std_logic_vector(1 downto 0) := "00";    
    READ_MODE                      :  std_logic_vector(1 downto 0) := "10";    
    -- Initial Reg Number 
    inI_NUMBER                     :  std_logic_vector(3 downto 0) := "1011";    
    -- SPI State 
    IDLE                           :  std_logic := '0';    
    TRANSFER                       :  std_logic := '1';    
    -- Write Reg Address 
    BW_RATE                        :  std_logic_vector(5 downto 0) := "101100";    
    POWER_CONTROL                  :  std_logic_vector(5 downto 0) := "101101";    
    DATA_FORMAT                    :  std_logic_vector(5 downto 0) := "110001";    
    inT_ENABLE                     :  std_logic_vector(5 downto 0) := "101110";    
    inT_MAP                        :  std_logic_vector(5 downto 0) := "101111";    
    THRESH_ACT                     :  std_logic_vector(5 downto 0) := "100100";    
    THRESH_inACT                   :  std_logic_vector(5 downto 0) := "100101";    
    TIME_inACT                     :  std_logic_vector(5 downto 0) := "100110";    
    ACT_inACT_CTL                  :  std_logic_vector(5 downto 0) := "100111";    
    THRESH_FF                      :  std_logic_vector(5 downto 0) := "101000";    
    TIME_FF                        :  std_logic_vector(5 downto 0) := "101001";    
    -- Read Reg Address
    inT_SOURCE                     :  std_logic_vector(5 downto 0) := "110000";    
    X_LB                           :  std_logic_vector(5 downto 0) := "110010";    
    X_HB                           :  std_logic_vector(5 downto 0) := "110011";    
    Y_LB                           :  std_logic_vector(5 downto 0) := "110100";    
    Y_HB                           :  std_logic_vector(5 downto 0) := "110101";    
    Z_LB                           :  std_logic_vector(5 downto 0) := "110110";    
    Z_HB                           :  std_logic_vector(5 downto 0) := "110111"
    );
    
  port (
    iRSTN                          : in std_logic;   
    iSPI_CLK                       : in std_logic;   
    iSPI_CLK_out                   : in std_logic;   
    iP2S_DATA                      : in std_logic_vector(SI_DataL downto 0);   
    iSPI_GO                        : in std_logic;   
    oSPI_end                       : out std_logic;   
    oS2P_DATA                      : out std_logic_vector(SO_DataL downto 0);   
    SPI_SDIO                       : inout std_logic;   
    oSPI_CSN                       : out std_logic;   
    oSPI_CLK                       : out std_logic
    );   
end spi_controller;

architecture translated OF spi_controller is

  signal read_mode_xhdl5           :  std_logic;   
  signal write_address             :  std_logic;   
  signal spi_count_en              :  std_logic;   
  signal spi_count                 :  std_logic_vector(3 downto 0);   
  signal temp_xhdl6                :  std_logic;   
  signal temp_xhdl7                :  std_logic;   
  signal oSPI_end_xhdl1            :  std_logic;   
  signal oS2P_DATA_xhdl2           :  std_logic_vector(SO_DataL downto 0);   
  signal oSPI_CSN_xhdl3            :  std_logic;   
  signal oSPI_CLK_xhdl4            :  std_logic;   

begin
  oSPI_end <= oSPI_end_xhdl1;
  oS2P_DATA <= oS2P_DATA_xhdl2;
  oSPI_CSN <= oSPI_CSN_xhdl3;
  oSPI_CLK <= oSPI_CLK_xhdl4;

  -- Read/Write mode: last bit of the data
  read_mode_xhdl5 <= iP2S_DATA(SI_DataL) ;
  write_address <= spi_count(3) ;

  -- When byte sent, disable output.
  oSPI_end_xhdl1 <= NOR_REDUCE(spi_count) ;
  oSPI_CSN_xhdl3 <= NOT iSPI_GO ;

  -- Clock, only when spi_count enabled
  temp_xhdl6 <= iSPI_CLK_out when spi_count_en = '1' else '1';
  oSPI_CLK_xhdl4 <= temp_xhdl6 ;

  -- Write to output, only when enabled and write mode. Else, High Impedance
  temp_xhdl7 <= iP2S_DATA(conv_integer(spi_count)) when (spi_count_en AND (NOT read_mode_xhdl5 OR write_address)) = '1' else 'Z';
  SPI_SDIO <= temp_xhdl7 ;
  
  process (iRSTN, iSPI_CLK)
  begin
    if (iRSTN = '0') then
      spi_count_en <= '0';    
      spi_count <= "1111";  
		
    elsif rising_edge(iSPI_CLK) then
	
		  -- byte sent, disable output
      if (oSPI_end_xhdl1 = '1') then
        spi_count_en <= '0';

      -- Asked to send a byte
      else
        if (iSPI_GO = '1') then
          spi_count_en <= '1';    
        end if;
      end if;
		 
		  --Count the output bytes
      if (NOT spi_count_en = '1') then
        spi_count <= "1111";    
      else
        spi_count <= spi_count - "0001";    
      end if;
		 
		  --Read mode: concatenate the next byte
      if ((read_mode_xhdl5 AND NOT write_address) = '1') then
        oS2P_DATA_xhdl2 <= oS2P_DATA_xhdl2(SO_DataL - 1 downto 0) & SPI_SDIO;    
      end if;
    end if;
  end process;

end translated;
