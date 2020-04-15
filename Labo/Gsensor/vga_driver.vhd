---------------------------------------------------------------------------------
-- vga_driver.vhd
-- Path: gsensor.vhd -> vga_driver.vhd
-- mremacle@ulg.ac.be  23/01/2014
-- 
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_misc.all;

entity vga_driver is
  port (  
    iCLK                    : in std_logic;   
    iDIGx                   : in std_logic_vector(9 downto 0); 
    iDIGy                   : in std_logic_vector(9 downto 0); 		
    oRed							      : out std_logic_vector( 3 downto 0);
    oBlue							      : out std_logic_vector( 3 downto 0);
    oGreen 						      : out std_logic_vector( 3 downto 0);
    oHsync						      : out std_logic;
    oVsync                  : out std_logic
	);
end vga_driver;

architecture behavior OF vga_driver is

			--Sync Signals
  signal h_sync	          :	std_logic;
  signal v_sync           : std_logic;
			
      --Video Enables
  signal video_en         :	std_logic;
	signal horizontal_en    :	std_logic; 
	signal vertical_en	    : std_logic;
			--Color Signals
  signal red_signal       :	std_logic;
	signal green_signal     :	std_logic;
	signal blue_signal	    : std_logic;
			--Sync Counters 
  signal h_cnt            : std_logic_vector(10 downto 0);
	signal v_cnt            : std_logic_vector(10 downto 0);
			
  signal signed_bitx      :	std_logic;
	signal signed_bity      : std_logic;
	signal color : std_logic_vector(11 downto 0);
			
begin

	signed_bitx <= iDIGx(9);
	signed_bity <= iDIGy(9);
	video_en <= horizontal_en AND vertical_en;	

	process	
	begin
	
	wait until(iCLK'EVENT) AND (iCLK = '1');
	
		-- Generate Screen display
		if(v_cnt >= 0) AND (v_cnt <= 799) then
			color <= "000000000000";
			
			if(signed_bity = '1') then
				if((v_cnt >= (257 - conv_integer(not(iDIGy(8 downto 0))))) AND (v_cnt <= (343 - conv_integer(not(iDIGy(8 downto 0)))))) then		
					if(signed_bitx = '1') then
						if((h_cnt >= (257 + conv_integer(not(iDIGx(8 downto 0))))) AND (h_cnt <= (543 + conv_integer(not(iDIGx(8 downto 0)))))) then
							color <= "111100001111";
						end if;
					else
						if((h_cnt >= (257 - conv_integer(iDIGx(8 downto 0)))) AND (h_cnt <= (543 - conv_integer(iDIGx(8 downto 0))))) then 
							color <= "111100001111";
						end if;
					end if;			
				end if;
			else
			   if((v_cnt >= (257 + conv_integer(iDIGy(8 downto 0)))) AND (v_cnt <= (343 + conv_integer(iDIGy(8 downto 0))))) then		
					if(signed_bitx = '1') then
						if((h_cnt >= (257 + conv_integer(not(iDIGx(8 downto 0))))) AND (h_cnt <= (543 + conv_integer(not(iDIGx(8 downto 0)))))) then
							color <= "111100001111";
						end if;
					else
						if((h_cnt >= (257 - conv_integer(iDIGx(8 downto 0)))) AND (h_cnt <= (543 - conv_integer(iDIGx(8 downto 0))))) then 
							color <= "111100001111";
						end if;
					end if;			
				end if;
			end if;
		end if;
		
	--Horizontal Sync
			--Generate Horizontal Sync
			if (h_cnt <= 975) AND (h_cnt >= 855) then
				h_sync <= '0';
			else
				h_sync <= '1';
			end if;
			
				--Reset Horizontal Counter
			if (h_cnt = 1039) then
				h_cnt <= "00000000000";
			else
				h_cnt <= h_cnt + 1;
			end if;			
		
		--Vertical Sync
			--Reset Vertical Counter
			if (v_cnt >= 665) AND (h_cnt >= 1039) then
				v_cnt <= "00000000000";
			elsif (h_cnt = 1039) then
				v_cnt <= v_cnt + 1;
			end if;
			
				--Generate Vertical Sync
			if (v_cnt <= 642) AND (v_cnt >= 636) then
				v_sync <= '0';	
			else
				v_sync <= '1';
			end if;
		
		--Generate Horizontal Data
		if (h_cnt <= 799) then
			horizontal_en <= '1';
		else
			horizontal_en <= '0';
		end if;
		
		--Generate Vertical Data
		if (v_cnt <= 599) then
			vertical_en <= '1';
		else
			vertical_en <= '0';
		end if;
		
		--Assign Physical Signals To VGA
		oRed(0) <= color(0) AND video_en; --Red LSB
		oRed(1) <= color(1) AND video_en; --Red LSB
		oRed(2) <= color(2) AND video_en; --Red LSB
		oRed(3) <= color(3) AND video_en; --Red LSB
		oGreen(0) <= color(4) AND video_en; --Red LSB
		oGreen(1) <= color(5) AND video_en; --Red LSB
		oGreen(2) <= color(6) AND video_en; --Red LSB
		oGreen(3) <= color(7) AND video_en; --Red LSB
		oBlue(0) <= color(8) AND video_en; --Red LSB
		oBlue(1) <= color(9) AND video_en; --Red LSB
		oBlue(2) <= color(10) AND video_en; --Red LSB
		oBlue(3) <= color(11) AND video_en; --Red LSB
		
		oHsync <= h_sync;
		oVsync <= v_sync;	
	
	end process;
	
end behavior;