LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Counter_main_wash IS
  PORT (
  	enable : IN std_logic;
  	clk : IN std_logic;
  	start_count : IN std_logic_vector(7 downto 0);
  	reset : IN std_logic;
  	timp : OUT std_logic_vector(7 downto 0);
  	stop_count : OUT std_logic
  );
end Counter_main_wash;

architecture Behavioral of Counter_main_wash is
  signal counter : std_logic_vector(7 downto 0) := start_count;
  signal reset_done: std_logic := '0';
begin
  process(enable, clk, reset)
  begin
  if rising_edge(clk) then
  if reset = '1' and reset_done = '0' then
       counter <= start_count;
       stop_count<='0';
       reset_done <= '1';
    else
    if enable='1'then
          if counter = "00000000" then
              stop_count <= '1';
           else
              counter <= counter - '1';
           end if;
        end if;
      end if;
    end if;
  end process;
  timp <= counter;
end Behavioral;