--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:33:09 10/23/2020
-- Design Name:   
-- Module Name:   C:/Users/waten/Desktop/New Documents/COE758/Lab1/Project1/TBCPU.vhd
-- Project Name:  Project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CPU
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
 
ENTITY TBCPU IS
END TBCPU;
 
ARCHITECTURE behavior OF TBCPU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    PORT(
         clk : IN  std_logic;
         debReg0 : OUT  std_logic_vector(9 downto 0);
         debReg1 : OUT  std_logic_vector(9 downto 0);
         debReg2 : OUT  std_logic_vector(9 downto 0);
         debReg3 : OUT  std_logic_vector(9 downto 0);
         debReg4 : OUT  std_logic_vector(9 downto 0);
         debReg5 : OUT  std_logic_vector(9 downto 0);
         debReg6 : OUT  std_logic_vector(9 downto 0);
         debReg7 : OUT  std_logic_vector(9 downto 0);
         debtrig : OUT  std_logic;
         debHit_Miss : OUT  std_logic;
         debAddr_SRAM : OUT  std_logic_vector(7 downto 0);
         debAddr_SDRAM : OUT  std_logic_vector(15 downto 0);
         debmstrb : OUT  std_logic;
         debM32 : OUT  std_logic;
         debRstC : OUT  std_logic;
         debCachest1 : OUT  std_logic_vector(2 downto 0);
         debpatCtrl : OUT  std_logic_vector(2 downto 0);
         debCPU_out : OUT  std_logic_vector(24 downto 0);
         debCPU_Din : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';

 	--Outputs
   signal debReg0 : std_logic_vector(9 downto 0);
   signal debReg1 : std_logic_vector(9 downto 0);
   signal debReg2 : std_logic_vector(9 downto 0);
   signal debReg3 : std_logic_vector(9 downto 0);
   signal debReg4 : std_logic_vector(9 downto 0);
   signal debReg5 : std_logic_vector(9 downto 0);
   signal debReg6 : std_logic_vector(9 downto 0);
   signal debReg7 : std_logic_vector(9 downto 0);
   signal debtrig : std_logic;
   signal debHit_Miss : std_logic;
   signal debAddr_SRAM : std_logic_vector(7 downto 0);
   signal debAddr_SDRAM : std_logic_vector(15 downto 0);
   signal debmstrb : std_logic;
   signal debM32 : std_logic;
   signal debRstC : std_logic;
   signal debCachest1 : std_logic_vector(2 downto 0);
   signal debpatCtrl : std_logic_vector(2 downto 0);
   signal debCPU_out : std_logic_vector(24 downto 0);
   signal debCPU_Din : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (
          clk => clk,
          debReg0 => debReg0,
          debReg1 => debReg1,
          debReg2 => debReg2,
          debReg3 => debReg3,
          debReg4 => debReg4,
          debReg5 => debReg5,
          debReg6 => debReg6,
          debReg7 => debReg7,
          debtrig => debtrig,
          debHit_Miss => debHit_Miss,
          debAddr_SRAM => debAddr_SRAM,
          debAddr_SDRAM => debAddr_SDRAM,
          debmstrb => debmstrb,
          debM32 => debM32,
          debRstC => debRstC,
          debCachest1 => debCachest1,
          debpatCtrl => debpatCtrl,
          debCPU_out => debCPU_out,
          debCPU_Din => debCPU_Din
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
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
