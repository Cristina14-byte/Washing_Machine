
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_Speed is
    Port (
        Speed_Manual: in STD_LOGIC_VECTOR(1 downto 0);
        Speed_Auto: in STD_LOGIC_VECTOR(1 downto 0);
        S : in STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(1 downto 0)
    );
end MUX_Speed;

architecture Behavioral of MUX_Speed is
begin
    process (S,Speed_Manual,Speed_Auto)
    begin
        case S is
                when '0' =>
                    Y <= Speed_Manual;
                when '1' =>
                    Y <= Speed_Auto;
                 when others =>
                    Y <= "00";
            end case;
    end process;
end Behavioral;
