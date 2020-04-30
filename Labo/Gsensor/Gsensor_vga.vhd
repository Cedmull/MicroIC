---------------------------------------------------------------------------------
-- gsensor.vhd
-- sindredit@gmail.com 16 Feb 2012,
-- modified by mremacle@ulg.ac.be, 24 Jan 2014
-- Top level design
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity Gsensor_vga is
  port (
	CLOCK_50                : in std_logic;	
	LED                     : out std_logic_vector(7 downto 0);   
	KEY                     : in std_logic_vector(1 downto 0);   
	G_SENSOR_CS_N           : out std_logic;   					-- G_Sensor chip select Pin_G5
	G_SENSOR_inT            : in std_logic;  	 					-- G_Sensor Interrupt Pin_M2
	I2C_SCLK                : out std_logic;  					-- EEPROM clock Pin_F2  
	I2C_SDAT                : inout std_logic; 					-- EEPROM data Pin_F1
	GPIO_1    			  : inout std_logic_vector(33 downto 0)
	);
end entity;
    
architecture synth of Gsensor_vga is

  signal dly_rst                  :  std_logic;   
  signal spi_clk                  :  std_logic;   
  signal spi_clk_out              :  std_logic;   
  signal data_x                   :  std_logic_vector(15 downto 0);   
	signal data_y                   :  std_logic_vector(15 downto 0); 
  signal LED_xhdl1                :  std_logic_vector(7 downto 0);   
  signal G_SENSOR_CS_N_xhdl2      :  std_logic;   
  signal I2C_SCLK_xhdl3           :  std_logic;  

begin
  LED <= LED_xhdl1;
  G_SENSOR_CS_N <= G_SENSOR_CS_N_xhdl2;
  I2C_SCLK <= I2C_SCLK_xhdl3;

  -- u_reset_delay
  u_reset_delay : entity work.reset_delay 
    port map (
      iRSTN => KEY(0),
      iCLK => CLOCK_50,
      oRST => dly_rst
    );   
 
  -- u_spiipll
  u_spipll : entity work.spipll 
    port map (
      areset => dly_rst,
      inclk0 => CLOCK_50,
      c0 => spi_clk,
      c1 => spi_clk_out
    );   
   
  -- u_spi_ee_config
  u_spi_ee_config : entity work.spi_ee_config 
    port map (
      iRSTN => NOT dly_rst,
      iSPI_CLK => spi_clk,
      iSPI_CLK_out => spi_clk_out,
      iG_inT2 => G_SENSOR_inT,
      oDATA_Lx => data_x(7 downto 0),
      oDATA_Hx => data_x(15 downto 8),
  	  oDATA_Ly => data_y(7 downto 0),
      oDATA_Hy => data_y(15 downto 8),
      SPI_SDIO => I2C_SDAT,
      oSPI_CSN => G_SENSOR_CS_N_xhdl2,
      oSPI_CLK => I2C_SCLK_xhdl3
    );   
   
  -- u_led_driver
  u_led_driver : entity work.led_driver 
    port map (
      iRSTN => NOT dly_rst,
      iCLK => CLOCK_50,
      iDIG => data_x(9 downto 0),
      iG_inT2 => G_SENSOR_inT,
      oLED => LED_xhdl1
    );
   
  u_vga_driver : entity work.vga_driver
    port map (
    	iCLK => CLOCK_50,
    	iDIGx => data_x(9 downto 0),
    	iDIGy => data_y(9 downto 0),
    	oRed => GPIO_1(5 downto 2),
    	oGreen => GPIO_1( 9 downto 6),
    	oBlue => GPIO_1(13 downto 10),
    	oHsync => GPIO_1(0),
    	oVsync => GPIO_1(1)
    );
	 
	-- u_snes_controller

		u_snes_controller_1 : entity work.controller
			port map(
				clk => GPIO_1(31), 
				data => 	GPIO_1(30),					
				latch => GPIO_1(26)
			);
			
		u_snes_controller_2 : entity work.controller
			port map(
				clk => GPIO_1(33), 
				data => 	GPIO_1(32),					
				latch => GPIO_1(28)
			);
    
    
end synth;
