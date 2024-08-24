library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter1 is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           enable: in STD_LOGIC;
           door : out STD_LOGIC);
end Counter1;

architecture Behavioral of Counter1 is
    signal nr: std_logic_vector(5 downto 0) := "111011"; --de la 59 la 0 (60 de secunde)
    signal reset_done: std_logic := '0';
begin
    
    process(clk, rst, enable)
    begin
       
       if rising_edge(clk) then
           if rst = '1' and reset_done = '0' then
                nr <= "111011";
                door <= '0';
                reset_done <= '1';
            else
                if enable = '1' then
                    if nr = "000000" then
                        door <= '1';
                    else
                        nr <= nr - 1;
                    end if;
                end if;
          end if;
       end if;
    end process;
    
end Behavioral;