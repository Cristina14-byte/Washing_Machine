library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_Temperature is
    Port (
        Temp_Manual_inp: in STD_LOGIC_VECTOR(1 downto 0);
        Temp_Auto: in STD_LOGIC_VECTOR(7 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(7 downto 0)
    );
end MUX_Temperature;

architecture Behavioral of MUX_Temperature is
signal Temp_Manual: STD_LOGIC_VECTOR(7 downto 0); 
begin
    process(Temp_Manual_inp) 
    begin
        case Temp_Manual_inp is
            when "00" => Temp_Manual <= "00011110";
            when "01" => Temp_Manual <= "00110010";
            when "10" => Temp_Manual <= "01011010";
            when "11" => Temp_Manual <= "10010110";
            when others => Temp_Manual <= "00000000";
        end case;
    end process;
 
    process (S,Temp_Manual,Temp_Auto)
    begin
        case S is
            when '0' =>
                Y <= Temp_Manual;
            when '1' =>
                Y <= Temp_Auto;
            when others =>
                Y <= "00000000";
        end case;
    end process;
end Behavioral;
