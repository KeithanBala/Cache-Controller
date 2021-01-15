----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:21:52 10/20/2020 
-- Design Name: 
-- Module Name:    SDRAMController - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SDRAMController is
    Port ( clk : in  STD_LOGIC;
           addr : in  STD_LOGIC_VECTOR (15 downto 0);
           wr_rd : in  STD_LOGIC;
           memstrb : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end SDRAMController;

architecture Behavioral of SDRAMController is
	
	type RAM is array(0 to 65535) of STD_LOGIC_VECTOR(7 downto 0);
	signal Memory: RAM;
	
	begin
		-- Array of the Blocks
		
		
		process(clk)
		begin
			if (clk'event and clk = '1' and memstrb = '1') then
				if (wr_rd = '1') then
					Memory(to_integer(unsigned(addr))) <= din;
				elsif (wr_rd = '0') then
					dout <= Memory(to_integer(unsigned(addr)));
				end if;
			end if;
		end process;

	end Behavioral;

