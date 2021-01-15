----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:07:51 09/29/2020 
-- Design Name: 
-- Module Name:    demux2to1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux2to1 is
    Port ( s : in  STD_LOGIC;
           w : in  STD_LOGIC_VECTOR (7 downto 0);
           f0 : out  STD_LOGIC_VECTOR (7 downto 0);
           f1 : out  STD_LOGIC_VECTOR (7 downto 0));
end demux2to1;

architecture Behavioral of demux2to1 is

begin
	process(w,s) is
		begin
		if (s = '0') then
			f0 <= w;
			f1 <= "00000000";
		elsif (s = '1') then
			f0 <= "00000000";
			f1 <= w;
		end if;
	end process;

end Behavioral;

