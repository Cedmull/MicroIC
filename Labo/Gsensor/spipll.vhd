---------------------------------------------------------------------------------
-- spipll.vhd
-- Path: gsensor.vhd -> spipll.vhd
-- sindredit@gmail.com 16 Feb 2012
-- 
---------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.all;

entity spipll is
	port
	(
		areset		              : in std_logic  := '0';
		inclk0		              : in std_logic  := '0';
		c0		                  : out std_logic ;
		c1		                  : out std_logic 
	);
end spipll;


architecture SYN OF spipll is

	signal sub_wire0	        : std_logic_vector (4 downto 0);
	signal sub_wire1	        : std_logic ;
	signal sub_wire2	        : std_logic ;
	signal sub_wire3	        : std_logic ;
	signal sub_wire4	        : std_logic_vector (1 downto 0);
	signal sub_wire5_bv	      : BIT_vector (0 downto 0);
	signal sub_wire5	        : std_logic_vector (0 downto 0);



	component altpll
	generic (
		bandwidth_type		      : STRING;
		clk0_divide_by		      : NATURAL;
		clk0_duty_cycle		      : NATURAL;
		clk0_multiply_by	      : NATURAL;
		clk0_phase_shift	      : STRING;
		clk1_divide_by		      : NATURAL;
		clk1_duty_cycle		      : NATURAL;
		clk1_multiply_by	      : NATURAL;
		clk1_phase_shift	      : STRING;
		compensate_clock	      : STRING;
		inclk0_input_frequency	: NATURAL;
		intended_device_family	: STRING;
		lpm_hint		            : STRING;
		lpm_type		            : STRING;
		operation_mode		      : STRING;
		pll_type		            : STRING;
		port_activeclock		    : STRING;
		port_areset		          : STRING;
		port_clkbad0		        : STRING;
		port_clkbad1		        : STRING;
		port_clkloss		        : STRING;
		port_clkswitch	        : STRING;
		port_configupdate		    : STRING;
		port_fbin		            : STRING;
		port_inclk0		          : STRING;
		port_inclk1		          : STRING;
		port_locked		          : STRING;
		port_pfdena		          : STRING;
		port_phasecounterselect	: STRING;
		port_phasedone		      : STRING;
		port_phasestep		      : STRING;
		port_phaseupdown	      : STRING;
		port_pllena		          : STRING;
		port_scanaclr	          : STRING;
		port_scanclk	          : STRING;
		port_scanclkena		      : STRING;
		port_scandata		        : STRING;
		port_scandataout		    : STRING;
		port_scandone		        : STRING;
		port_scanread		        : STRING;
		port_scanwrite		      : STRING;
		port_clk0		            : STRING;
		port_clk1		            : STRING;
		port_clk2		            : STRING;
		port_clk3		            : STRING;
		port_clk4		            : STRING;
		port_clk5		            : STRING;
		port_clkena0		        : STRING;
		port_clkena1		        : STRING;
		port_clkena2		        : STRING;
		port_clkena3		        : STRING;
		port_clkena4		        : STRING;
		port_clkena5		        : STRING;
		port_extclk0		        : STRING;
		port_extclk1		        : STRING;
		port_extclk2		        : STRING;
		port_extclk3		        : STRING;
		width_clock		          : NATURAL
	);
	port (
			areset	              : in std_logic ;
			clk	                  : out std_logic_vector (4 downto 0);
			inclk	                : in std_logic_vector (1 downto 0)
	);
	end component;

begin
	sub_wire5_bv(0 downto 0)  <= "0";
	sub_wire5                 <= To_stdlogicvector(sub_wire5_bv);
	sub_wire2                 <= sub_wire0(0);
	sub_wire1                 <= sub_wire0(1);
	c1                        <= sub_wire1;
	c0                        <= sub_wire2;
	sub_wire3                 <= inclk0;
	sub_wire4                 <= sub_wire5(0 downto 0) & sub_wire3;

	altpll_component : altpll
	generic MAP (
		bandwidth_type => "AUTO",
		clk0_divide_by => 25,
		clk0_duty_cycle => 50,
		clk0_multiply_by => 1,
		clk0_phase_shift => "200000",
		clk1_divide_by => 25,
		clk1_duty_cycle => 50,
		clk1_multiply_by => 1,
		clk1_phase_shift => "166667",
		compensate_clock => "CLK0",
		inclk0_input_frequency => 20000,
		intended_device_family => "Cyclone IV E",
		lpm_hint => "CBX_MODULE_PREFIX=spipll",
		lpm_type => "altpll",
		operation_mode => "NORMAL",
		pll_type => "AUTO",
		port_activeclock => "port_UNuseD",
		port_areset => "port_useD",
		port_clkbad0 => "port_UNuseD",
		port_clkbad1 => "port_UNuseD",
		port_clkloss => "port_UNuseD",
		port_clkswitch => "port_UNuseD",
		port_configupdate => "port_UNuseD",
		port_fbin => "port_UNuseD",
		port_inclk0 => "port_useD",
		port_inclk1 => "port_UNuseD",
		port_locked => "port_UNuseD",
		port_pfdena => "port_UNuseD",
		port_phasecounterselect => "port_UNuseD",
		port_phasedone => "port_UNuseD",
		port_phasestep => "port_UNuseD",
		port_phaseupdown => "port_UNuseD",
		port_pllena => "port_UNuseD",
		port_scanaclr => "port_UNuseD",
		port_scanclk => "port_UNuseD",
		port_scanclkena => "port_UNuseD",
		port_scandata => "port_UNuseD",
		port_scandataout => "port_UNuseD",
		port_scandone => "port_UNuseD",
		port_scanread => "port_UNuseD",
		port_scanwrite => "port_UNuseD",
		port_clk0 => "port_useD",
		port_clk1 => "port_useD",
		port_clk2 => "port_UNuseD",
		port_clk3 => "port_UNuseD",
		port_clk4 => "port_UNuseD",
		port_clk5 => "port_UNuseD",
		port_clkena0 => "port_UNuseD",
		port_clkena1 => "port_UNuseD",
		port_clkena2 => "port_UNuseD",
		port_clkena3 => "port_UNuseD",
		port_clkena4 => "port_UNuseD",
		port_clkena5 => "port_UNuseD",
		port_extclk0 => "port_UNuseD",
		port_extclk1 => "port_UNuseD",
		port_extclk2 => "port_UNuseD",
		port_extclk3 => "port_UNuseD",
		width_clock => 5
	)
	port map (
		areset => areset,
		inclk => sub_wire4,
		clk => sub_wire0
	);
end SYN;
