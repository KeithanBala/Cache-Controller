--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:33:29 10/20/2020
-- Design Name:   
-- Module Name:   C:/Users/waten/Desktop/New Documents/COE758/Lab1/Project1/TB_SDRAMController.vhd
-- Project Name:  Project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SDRAMController
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_SDRAMController IS
END TB_SDRAMController;
 
ARCHITECTURE behavior OF TB_SDRAMController IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT SDRAMController
    PORT(
         clk : IN  std_logic;
         addr : IN  std_logic_vector(15 downto 0);
         wr_rd : IN  std_logic;
         memstrb : IN  std_logic;
         din : IN  std_logic_vector(7 downto 0);
         dout : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addr : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_rd : std_logic := '0';
   signal memstrb : std_logic := '0';
   signal din : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal dout : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: SDRAMController PORT MAP (
          clk => clk,
          addr => addr,
          wr_rd => wr_rd,
          memstrb => memstrb,
          din => din,
          dout => dout
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for a clk period.
      wait for clk_period;	
		
		addr <= "0100110001101010";
		din <= "10011100";
		wr_rd <= '1';
		
		wait for clk_period;
		memstrb <= '1';
		
		wait for clk_period;
		memstrb <= '0';
		wr_rd <= '0';
		
		wait for clk_period;
		memstrb <= '1';

      -- insert stimulus here 

      wait;
   end process;

END;
