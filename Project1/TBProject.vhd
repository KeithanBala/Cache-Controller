--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:19:16 10/20/2020
-- Design Name:   
-- Module Name:   C:/Users/waten/Desktop/New Documents/COE758/Lab1/Project1/TBProject.vhd
-- Project Name:  Project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Project
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
 
ENTITY TBProject IS
END TBProject;
 
ARCHITECTURE behavior OF TBProject IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Project
    PORT(
         clk : IN  std_logic;
         addrIn : IN  std_logic_vector(15 downto 0);
         wr_rd : IN  std_logic;
         cs : IN  std_logic;
         cpu_dout : IN  std_logic_vector(7 downto 0);
         cpu_din : OUT  std_logic_vector(7 downto 0);
         rdy : OUT  std_logic;
         debReg0 : OUT  std_logic_vector(9 downto 0);
         debReg1 : OUT  std_logic_vector(9 downto 0);
         debReg2 : OUT  std_logic_vector(9 downto 0);
         debReg3 : OUT  std_logic_vector(9 downto 0);
         debReg4 : OUT  std_logic_vector(9 downto 0);
         debReg5 : OUT  std_logic_vector(9 downto 0);
         debReg6 : OUT  std_logic_vector(9 downto 0);
         debReg7 : OUT  std_logic_vector(9 downto 0);
         debHit_Miss : OUT std_logic;
			debAddr_SRAM : OUT std_logic_vector(7 downto 0);
			debAddr_SDRAM : OUT std_logic_vector(15 downto 0);
			debmstrb : OUT std_logic;
			debM32 : OUT std_logic;
			debRstC : OUT std_logic;
			debst1 : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addrIn : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_rd : std_logic := '0';
   signal cs : std_logic := '0';
   signal cpu_dout : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal cpu_din : std_logic_vector(7 downto 0);
   signal rdy : std_logic;
   signal debReg0 : std_logic_vector(9 downto 0);
   signal debReg1 : std_logic_vector(9 downto 0);
   signal debReg2 : std_logic_vector(9 downto 0);
   signal debReg3 : std_logic_vector(9 downto 0);
   signal debReg4 : std_logic_vector(9 downto 0);
   signal debReg5 : std_logic_vector(9 downto 0);
   signal debReg6 : std_logic_vector(9 downto 0);
   signal debReg7 : std_logic_vector(9 downto 0);
   signal debHit_Miss : std_logic;
	signal debAddr_SRAM : std_logic_vector(7 downto 0);
	signal debAddr_SDRAM : std_logic_vector(15 downto 0);
	signal debmstrb : std_logic;
	signal debM32 : std_logic;
   signal debRstC : std_logic;
   signal debst1 : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Project PORT MAP (
          clk => clk,
          addrIn => addrIn,
          wr_rd => wr_rd,
          cs => cs,
          cpu_dout => cpu_dout,
          cpu_din => cpu_din,
          rdy => rdy,
          debReg0 => debReg0,
          debReg1 => debReg1,
          debReg2 => debReg2,
          debReg3 => debReg3,
          debReg4 => debReg4,
          debReg5 => debReg5,
          debReg6 => debReg6,
          debReg7 => debReg7,
          debHit_Miss => debHit_Miss,
			 debAddr_SRAM => debAddr_SRAM,
			 debAddr_SDRAM => debAddr_SDRAM,
			 debmstrb => debmstrb,
			 debM32 => debM32,
          debRstC => debRstC,
          debst1 => debst1
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
      wait for clk_period*2;
		addrIn <= "1001100110101111";
		wr_rd <= '1';
		cs <= '1';
		cpu_dout <= "10011011";
		
      wait for clk_period*4;
		cpu_dout <= "00000000";
		cs <= '0';
		
		wait for (640 ns + clk_period);
		--addrIn <= "1001100110100101";
		addrIn <= "1001100110101111";
		wr_rd <= '0';
		cs <= '1';
		
		wait for clk_period*4;
		cs <= '0';
		
		wait for clk_period*2;
		addrIn <= "1011100110100101";
		wr_rd <= '1';
		cs <= '1';
		cpu_dout <= "10011011";
		
      wait for clk_period*4;
		cpu_dout <= "00000000";
		cs <= '0';

      -- insert stimulus here 

      wait;
   end process;

END;
