
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ROM_Rinsing is
 Port ( Addr_Rinsing : in STD_LOGIC_VECTOR (2 downto 0);
        Data_Rinsing : out STD_LOGIC);
end ROM_Rinsing;

architecture Structural of ROM_Rinsing is
type ROM_vector_t is array(0 to 4) of STD_LOGIC;
constant content: ROM_vector_t:= (
0=>'0', --quick wash
1=>'0', --shirts
2=>'1', --dark colours
3=>'0', --dirty laundry
4=>'1' --antiallergic
);

begin
process (Addr_Rinsing)
begin
case Addr_Rinsing is 
   when "000" =>
   Data_Rinsing <= content(0);
   when "001" =>
   Data_Rinsing <= content(1);
   when "010" =>
   Data_Rinsing <= content(2);
   when "011" =>
   Data_Rinsing <= content(3);
   when "100" =>
   Data_Rinsing <= content(4);
   when others =>
   Data_Rinsing <= '0'; 
end case;
end process;
end Structural;
