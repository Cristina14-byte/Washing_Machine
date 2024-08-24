LIBRARY ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.std_logic_arith.all;
use ieee.numeric_std.all;

entity Execution_Unit is
 Port ( 
           start                : in  STD_LOGIC;
           clk                  : in  STD_LOGIC;
           reset                : in  STD_LOGIC;
           mode                 : in  STD_LOGIC;
           auto_mode_setting    : in  STD_LOGIC_VECTOR(2 downto 0);
           temperature          : in  STD_LOGIC_VECTOR(1 downto 0);
           speed                : in  STD_LOGIC_VECTOR(1 downto 0);
           prewash_cancelling   : in  STD_LOGIC;
           bonus_rinsing        : in  STD_LOGIC;
           finish_water_heating : out STD_LOGIC;
           finish_main_wash     : out STD_LOGIC;
           finish_1min          : out STD_LOGIC;
           start_water_heating  : in STD_LOGIC;
           start_main_wash      : in STD_LOGIC;
           start_1min           : in STD_LOGIC;
           door_can_unlock      : out STD_LOGIC;
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           CAT : out STD_LOGIC_VECTOR (6 downto 0)
          );
end Execution_Unit;

architecture Behavioral of Execution_Unit is

component SSD is
    Port ( CLK : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           CAT : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component Frequency_Divider is
    Port (
        clock_in : in STD_LOGIC;
        clock_out : out STD_LOGIC
        );
end component;

component Counter_water_heating is
    Port (
  		enable:in std_logic;
  		clk:in std_logic;
  		reset:in std_logic;
  		temp:in std_logic_vector( 7 downto 0);
  		stop_count: out std_logic
  		);
end component;

component Counter_main_wash is
    Port ( 
          enable : IN std_logic;
          clk : IN std_logic;
          start_count : IN std_logic_vector(7 downto 0);
          reset : IN std_logic;
          timp : OUT std_logic_vector(7 downto 0);
          stop_count : OUT std_logic
      );
end component;

component Counter1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           door : out STD_LOGIC);
end component;

component MUX_Temperature is
    Port (
        Temp_Manual_inp: in STD_LOGIC_VECTOR(1 downto 0);
        Temp_Auto: in STD_LOGIC_VECTOR(7 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;

component MUX_Speed is
    Port (
        Speed_Manual: in STD_LOGIC_VECTOR(1 downto 0);
        Speed_Auto: in STD_LOGIC_VECTOR(1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(1 downto 0)
    );
end component;

component MUX_Rinsing is
    Port (
        Rinsing_Manual: in STD_LOGIC;
        Rinsing_Auto: in STD_LOGIC;
        S : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end component;

component MUX_Prewash is
    Port (
        Prewash_Manual: in STD_LOGIC;
        Prewash_Auto: in STD_LOGIC;
        S : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end component;

component ROM_temperature is
 Port ( Addr_temperature : in STD_LOGIC_VECTOR (2 downto 0);
           Data_temperature : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component ROM_speed is
 Port ( Addr_speed : in STD_LOGIC_VECTOR (2 downto 0);
           Data_speed : out STD_LOGIC_VECTOR (1 downto 0));
end component;

component ROM_Rinsing is
 Port ( Addr_Rinsing : in STD_LOGIC_VECTOR (2 downto 0);
        Data_Rinsing : out STD_LOGIC);
end component;

component ROM_Prewash is
 Port ( Addr_Prewash : in STD_LOGIC_VECTOR (2 downto 0);
        Data_Prewash : out STD_LOGIC
        );
end component;

component SUM is
    Port(
        clk : in STD_LOGIC;
        prewash_cancellation : in STD_LOGIC;
        additional_rinsing  : in STD_LOGIC;
        total_time : out STD_LOGIC_VECTOR(7 downto 0)
        );
end component;


-- Clk delay signal
signal clk_delay : STD_LOGIC;

-- Data signals
signal data_prewash      : STD_LOGIC;
signal data_rinsing      : STD_LOGIC;
signal data_speed        : STD_LOGIC_VECTOR (1 downto 0);
signal data_temperature  : STD_LOGIC_VECTOR (7 downto 0);

-- Data signals for auto mode
signal data_auto_speed        : STD_LOGIC_VECTOR (1 downto 0);
signal data_auto_temperature  : STD_LOGIC_VECTOR (7 downto 0);
signal data_auto_prewash      : STD_LOGIC;
signal data_auto_rinsing      : STD_LOGIC;

signal total_time : STD_LOGIC_VECTOR(7 downto 0);
signal remaining_time : STD_LOGIC_VECTOR(7 downto 0); --rem_time

signal finish_water_heating_s : STD_LOGIC := '0';
signal finish_main_wash_s     : STD_LOGIC := '0';
signal finish_1min_s          : STD_LOGIC := '0';

begin

--Frequency Divider
Freq_Divider : Frequency_Divider port map (clk,clk_delay);

--SSD
SSD1 : SSD port map(
    CLK  => clk,
    digit0 => total_time(3 downto 0),
    digit1 => total_time(7 downto 4),
    digit2 =>"0000",
    digit3 =>"0000",
    AN => AN,
    CAT => CAT
) ;

--ROM Mappings
ROM_temp : ROM_temperature port map(auto_mode_setting,data_auto_temperature);
ROM_spd  : ROM_speed port map(auto_mode_setting,data_auto_speed);
Rom_pr   : Rom_Prewash port map(auto_mode_setting,data_auto_prewash); 
Rom_rsn  : Rom_Rinsing port map(auto_mode_setting,data_auto_rinsing);

--MUX Mappings
MUX_temp : MUX_temperature port map(temperature,data_auto_temperature,mode,data_temperature);
MUX_spd  : MUX_speed port map(speed,data_auto_speed,mode,data_speed);
MUX_pr   : MUX_Prewash port map(prewash_cancelling,data_auto_prewash,mode,data_prewash);
MUX_rsn  : MUX_Rinsing port map(bonus_rinsing,data_auto_rinsing,mode,data_rinsing);

--Total time Mapping
TotalTime : SUM port map(clk,data_prewash,data_rinsing,total_time);

--Counter Mappings
WaterHeating : Counter_water_heating port map( 
        enable => start_water_heating,
  		clk    => clk_delay,
  		reset  => reset,
  		temp   => data_temperature,
  		stop_count  => finish_water_heating_s
  		); 

MainWash : Counter_main_wash port map(
    enable => start_water_heating,
  	clk => clk_delay,
  	start_count => total_time,
  	reset => reset,
  	timp => remaining_time,
  	stop_count =>finish_main_wash_s
    );

OneMin : Counter1 port map (
           clk => clk_delay,
           rst => reset,
           enable => start_1min,
           door => finish_1min_s
           );

finish_water_heating <= finish_water_heating_s;
finish_main_wash <= finish_main_wash_s;
finish_1min <= finish_1min_s;

end Behavioral;
