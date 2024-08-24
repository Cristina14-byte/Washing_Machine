library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main is
  Port (
        start: in STD_LOGIC;
        lock_door: in STD_LOGIC;
        mode: in STD_LOGIC;
        auto_mode_setting: in STD_LOGIC_VECTOR(2 downto 0);
        temperature: in STD_LOGIC_VECTOR(1 downto 0);
        speed: in STD_LOGIC_VECTOR(1 downto 0);
        prewash_cancelling: in STD_LOGIC;
        bonus_rinsing: in STD_LOGIC;
        reset: in STD_LOGIC;
        clk: in STD_LOGIC;
        finish: out STD_LOGIC;
        door_can_unlock: out STD_LOGIC;
        AN : out STD_LOGIC_VECTOR (3 downto 0);
        CAT : out STD_LOGIC_VECTOR (6 downto 0)
        );
end main;

architecture Behavioral of main is

component Execution_Unit is
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
            finish_water_heating: out STD_LOGIC;
            finish_main_wash : out STD_LOGIC;
            finish_1min : out STD_LOGIC;
            start_water_heating: in STD_LOGIC;
            start_main_wash: in STD_LOGIC;
            start_1min : in STD_LOGIC;
            door_can_unlock      : out STD_LOGIC;
            AN : out STD_LOGIC_VECTOR (3 downto 0);
            CAT : out STD_LOGIC_VECTOR (6 downto 0)
           );
end component;

component Control_Unit is
    Port ( 
               start: in STD_LOGIC;
               clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               lock_door: in STD_LOGIC;
               mode: in STD_LOGIC;
               finish_water_heating: in STD_LOGIC;
               finish_main_wash: in STD_LOGIC;
               finish_1min : in STD_LOGIC;
               start_water_heating: out STD_LOGIC;
               start_main_wash: out STD_LOGIC;
               start_1min: out STD_LOGIC;
               finish: out STD_LOGIC;
               door_can_unlock: out STD_LOGIC
           );
end component;

signal finish_water_heating : STD_LOGIC;
signal finish_main_wash : STD_LOGIC;
signal finish_1min : STD_LOGIC;
signal start_water_heating : STD_LOGIC;
signal start_main_wash : STD_LOGIC;
signal start_1min : STD_LOGIC;

begin

EU : Execution_Unit port map(
            start,
            clk,
            reset,
            mode,
            auto_mode_setting,
            temperature,
            speed,
            prewash_cancelling,
            bonus_rinsing,
            finish_water_heating,
            finish_main_wash,
            finish_1min,
            start_water_heating,
            start_main_wash,
            start_1min,
            door_can_unlock,
            AN,
            CAT
       );
                                        
CU : Control_Unit port map(
               start,
               clk,
               reset,
               lock_door,
               mode,
               finish_water_heating,
               finish_main_wash,
               finish_1min,
               start_water_heating,
               start_main_wash,
               start_1min,
               finish,
               door_can_unlock
);

end Behavioral;
