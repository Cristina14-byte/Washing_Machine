
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_Prewash is
    Port (
        Prewash_Manual: in STD_LOGIC;
        Prewash_Auto: in STD_LOGIC;
        S : in STD_LOGIC;
        Y : out STD_LOGIC
    );
end MUX_Prewash;

architecture Behavioral of MUX_Prewash is
begin
    process (S,Prewash_Manual,Prewash_Auto)
    begin
        case S is
            when '0' =>
                Y <= Prewash_Manual;
            when '1' =>
                y <= Prewash_Auto;
             when others =>
                Y <= '0';
        end case;
    end process;
end Behavioral;