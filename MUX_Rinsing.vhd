
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_Rinsing is
    Port (
        Rinsing_Manual: in STD_LOGIC;
        Rinsing_Auto: in STD_LOGIC;
        S : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end MUX_Rinsing;

architecture Behavioral of MUX_Rinsing is
begin
    process (S,Rinsing_Manual,Rinsing_Auto)
    begin
        case S is
             when '0' =>
                 Y <= Rinsing_Manual;
             when '1' =>
                 Y <= Rinsing_Auto;
             when others => 
                Y <= '1';
             end case;
    end process;
end Behavioral;
