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
	GPIO_1    				   : inout std_logic_vector(33 downto 0);
	
	
	-- snes1
	clk_snes1	: out std_logic;
	latch_snes1	: out std_logic;
	data_snes1	: in std_logic;
		
	-- snes2
	clk_snes2	: out std_logic;
	latch_snes2	: out std_logic;
	data_snes2	: in std_logic
	
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

-- Snes1
	signal b_1      : std_logic;
	signal y_1      : std_logic;
	signal select_1 : std_logic;
	signal start_1  : std_logic;
	signal up_1     : std_logic;
	signal down_1   : std_logic;
	signal left_1   : std_logic;
	signal right_1  : std_logic;
	signal a_1      : std_logic;
	signal x_1      : std_logic;
	signal l_1      : std_logic;
	signal r_1      : std_logic;
	
	-- Snes2
	signal b_2      : std_logic;
	signal y_2      : std_logic;
	signal select_2 : std_logic;
	signal start_2  : std_logic;
	signal up_2     : std_logic;
	signal down_2   : std_logic;
	signal left_2   : std_logic;
	signal right_2  : std_logic;
	signal a_2      : std_logic;
	signal x_2      : std_logic;
	signal l_2      : std_logic;
	signal r_2      : std_logic;  
	
	-- Player 1 position
	signal x_player1            : INTEGER range 0 to 800;
	signal y_player1            : INTEGER range 0 to 600;                 
	                                              
	-- Player 2 position
	signal x_player2            : INTEGER range 0 to 800;
	signal y_player2            : INTEGER range 0 to 600;
	

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
    	oVsync => GPIO_1(1),
		
		xx_player1 => x_player1,
		xx_player2 => x_player2,
		yy_player1 => y_player1,
		yy_player2 => y_player2
    );
	 
	u_snes1: entity work.controller
		
		port map(
			CLOCK_50     => CLOCK_50,
			latch        => latch_snes1,
			clk			 => clk_snes1,
			data         => data_snes1,
			b            => b_1,
			y            => y_1,
			selectt	    => select_1,
			start        => start_1,
			up    		 => up_1,
			down 		    => down_1,
			leftt		    => left_1,
			rightt	    => right_1,
			a            => a_1,
			x            => x_1,
			l            => l_1,
			r            => r_1
		);
		
	u_snes2: entity work.controller
		
		port map(
			CLOCK_50     => CLOCK_50,
			latch        => latch_snes2,
			clk			 => clk_snes2,
			data         => data_snes2,
			b            => b_2,
			y            => y_2,
			selectt      => select_2,
			start        => start_2,
			up    		 => up_2,
			down  		 => down_2,
			leftt  		 => left_2,
			rightt	    => right_2,
			a            => a_2,
			x            => x_2,
			l            => l_2,
			r            => r_2
		);
		
	player1_motion: entity work.motion
	
		port map(
			-- INPUTS
			CLOCK_50     => CLOCK_50,
			go_up			 => up_1,
			go_down      => down_1,
			go_left   	 => left_1,
			go_right  	 => right_1,
			player_flag  => '0',
			
			-- OUTPUTS
			x_player     => x_player1,
			y_player     => y_player1
		);
				
	player_2_motion: entity work.motion
		-- idem than for player 1
		
		port map(
			-- INPUTS
			CLOCK_50     => CLOCK_50,
			go_up  		=> up_2,
			go_down      => down_2,
			go_left    => left_2,
			go_right   => right_2,
			player_flag  => '1',
			-- OUTPUTS
			x_player     => x_player2,
			y_player     => y_player2	
		);
    
end synth;