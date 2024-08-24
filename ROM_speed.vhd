library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

entity ROM_speed is
 Port ( Addr_speed : in STD_LOGIC_VECTOR (2 downto 0);
           Data_speed : out STD_LOGIC_VECTOR (1 downto 0));
end ROM_speed;

architecture Structural of ROM_speed is
type ROM_vector_t is array(0 to 4) of std_logic_vector(1 downto 0);
constant content: ROM_vector_t:= (

0=>"10", --quick wash
1=>"00", --shirts
2=>"01", --dark colours
3=>"01", --dirty laundry
4=>"10" --antiallergic

--10 = 10010110000 = 1200
--00 = 01100100000 = 800
--10 = 01111101000 = 1000
);


begin
process (Addr_speed)
begin
case Addr_speed is 
   when "000" =>
   Data_speed <= content(0);
   when "001" =>
   Data_speed <= content(1);
   when "010" =>
   Data_speed <= content(2);
   when "011" =>
   Data_speed <= content(3);
   when "100" =>
   Data_speed <= content(4);
   when others =>
   Data_speed <= "11";  
     
end case;
end process;
end Structural;