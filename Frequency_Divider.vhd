library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Frequency_Divider is
    Port (
        clock_in : in STD_LOGIC;
        clock_out : out STD_LOGIC
    );
end Frequency_Divider;

architecture Behavioral of Frequency_Divider is
    constant DIVISOR : integer := 50000000;  -- 50 million for 100 MHz clock
    signal nr: integer := 0;
    signal clock_reg: std_logic := '0';
begin
    process(clock_in)
    begin
        if rising_edge(clock_in) then
            if nr = DIVISOR-1 then
                nr <= 0;
                clock_reg <= not clock_reg;
            else
                nr <= nr + 1;
            end if;
        end if;
    end process;

    clock_out <= clock_reg;
end Behavioral;
