library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity ROM_Prewash is
 Port ( Addr_Prewash : in STD_LOGIC_VECTOR (2 downto 0);
        Data_Prewash : out STD_LOGIC
        );
end ROM_Prewash;


--negative logic (because it is prewash cancelling)

architecture Structural of ROM_Prewash is
type ROM_vector_t is array(0 to 4) of STD_LOGIC;
constant content: ROM_vector_t:= (
0=>'1', --quick wash
1=>'1', --shirts
2=>'1', --dark colours
3=>'0', --dirty laundry
4=>'1' --antiallergic
);

begin
process (Addr_Prewash)
begin
case Addr_Prewash is 
   when "000" =>
   Data_Prewash <= content(0);
   when "001" =>
   Data_Prewash <= content(1);
   when "010" =>
   Data_Prewash <= content(2);
   when "011" =>
   Data_Prewash <= content(3);
   when "100" =>
   Data_Prewash <= content(4);
   when others =>
   Data_Prewash <= '1';
end case;
end process;
end Structural;