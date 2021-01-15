----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:00:14 09/29/2020 
-- Design Name: 
-- Module Name:    mux2to1 - Behavioral 
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

entity mux2to1 is
    Port ( s : in  STD_LOGIC;
           w0 : in  STD_LOGIC_VECTOR (7 downto 0);
           w1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  f  : out  STD_LOGIC_VECTOR (7 downto 0));
end mux2to1;

architecture Behavioral of mux2to1 is

begin
	with s select
		f <= w0 when '0',
			  w1 when others;


end Behavioral;

