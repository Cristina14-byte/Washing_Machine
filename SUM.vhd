library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SUM is
    Port(
        clk : in STD_LOGIC;
        prewash_cancellation : in STD_LOGIC;
        additional_rinsing  : in STD_LOGIC;
        total_time : out STD_LOGIC_VECTOR(7 downto 0)
        );
end SUM;

architecture Behavioral of SUM is
signal temp: STD_LOGIC_VECTOR(7 downto 0);

begin
   process(clk,prewash_cancellation,additional_rinsing)
   begin 
    if rising_edge(clk) then
        if prewash_cancellation = '0' and additional_rinsing = '0' then
            temp <="00110010";
        elsif prewash_cancellation = '0' and additional_rinsing = '1' then
            temp <="00111100";
        elsif prewash_cancellation = '1' and additional_rinsing = '0' then
            temp <="00101000";
        else
            temp <="00110010";
        end if;
    end if;
    
    total_time <= temp;
  
  end process;

end Behavioral;
