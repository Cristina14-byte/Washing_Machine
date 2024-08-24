library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Control_Unit is
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
end Control_Unit;

architecture Behavioral of Control_Unit is
    type state_t is (Idle,Lock_DoorS,Choose_Mode,Characteristics_Manual,Auto_Mode_SettingS,
                     Water_Heating,Main_Wash,OneMin,Final_State);
    signal state, next_state: state_t;
begin

    act_state: process(clk, reset, lock_door)
    begin
        if reset = '1' then
            state <= Idle;
        elsif rising_edge(clk) then
            state <= next_state;
        end if;
    end process;

    transitions: process(state, finish_water_heating, start)
    begin
        start_water_heating <= '0';
        start_main_wash <= '0';
        start_1min <='0';
        finish <= '0';
        door_can_unlock <= '0';   

        case state is
            when Idle =>
                if start = '1' then
                    next_state <= Lock_DoorS;
                else
                    next_state <= Idle;
                end if;
            when Lock_DoorS =>
                if lock_door = '1' then
                    next_state <= Choose_Mode;
                else
                    next_state <= Lock_DoorS;
                end if;
            when Choose_Mode =>
             if start = '1' then   
                if mode = '0' then
                    next_state <= Characteristics_Manual;
                else
                    next_state <= Auto_Mode_SettingS;
                end if;
             else next_state <= Choose_Mode; 
             end if;
            when Characteristics_Manual =>
                if start = '1' then
                    next_state <= Water_Heating;
                else
                    next_state <= Characteristics_Manual;
                end if;
            when Auto_Mode_SettingS =>
                if start = '1' then
                    next_state <= Water_Heating;
                else
                    next_state <= Auto_Mode_SettingS;
                end if;
            when Water_Heating =>
                start_water_heating <= '1';
                if finish_water_heating = '1' then
                    next_state <= Main_Wash;
                else
                    next_state <= Water_Heating;
                end if;
            when Main_Wash =>
                start_main_wash <= '1';
                if finish_main_wash = '1' then
                    next_state <= OneMin;
                else
                    next_state <= Main_Wash;
                end if;
            when OneMin =>
                finish <= '1';
                start_1min <= '1';
                if finish_1min <= '1' then
                    next_state <= Final_State;
                else
                    next_state <= OneMin;
                end if;
            when Final_State =>
                door_can_unlock <= '1'; 
                next_state <= Idle;
        end case;
    end process;
    
end Behavioral;