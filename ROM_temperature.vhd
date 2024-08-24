library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;


entity ROM_temperature is
 Port ( Addr_temperature : in STD_LOGIC_VECTOR (2 downto 0);
           Data_temperature : out STD_LOGIC_VECTOR (7 downto 0));
end ROM_temperature;

architecture Structural of ROM_temperature is
type ROM_vector_t is array(0 to 4) of std_logic_vector(7 downto 0);
constant content: ROM_vector_t:= (

0=>"00011110", --quick wash
1=>"01011010", --shirts
2=>"00110010", --dark colours
3=>"00110010", --dirty laundry
4=>"10010110" --antiallergic

);

begin
process (Addr_temperature)
begin
case Addr_temperature is 
   when "000" =>
   Data_temperature <= content(0);
   when "001" =>
   Data_temperature <= content(1);
   when "010" =>
   Data_temperature <= content(2);
   when "011" =>
   Data_temperature <= content(3);
   when "100" =>
   Data_temperature <= content(4);
   when others =>
   Data_temperature <= "00000000"; 
   
end case;
end process;
end Structural;