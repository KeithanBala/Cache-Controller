--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:11:29 10/19/2020
-- Design Name:   
-- Module Name:   /home/student1/gwatenya/COE758/Project1/TBCacheController.vhd
-- Project Name:  Project1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: cacheController
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
 
ENTITY TBCacheController IS
END TBCacheController;
 
ARCHITECTURE behavior OF TBCacheController IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT cacheController
    PORT(
         clk : IN  std_logic;
         addrIn : IN  std_logic_vector(15 downto 0);
         wr_rd : IN  std_logic;
         cs : IN  std_logic;
         rdy : OUT  std_logic;
         addr_SDRAM : OUT  std_logic_vector(15 downto 0);
         wr_rd_SDRAM : OUT  std_logic;
         mstrb_SDRAM : OUT  std_logic;
         addr_SRAM : OUT  std_logic_vector(7 downto 0);
         wen_SRAM : OUT  std_logic_vector(0 downto 0);
         muxSel : OUT  std_logic;
         demuxSel : OUT  std_logic;
         debReg0 : OUT  std_logic_vector(9 downto 0);
         debReg1 : OUT  std_logic_vector(9 downto 0);
         debReg2 : OUT  std_logic_vector(9 downto 0);
         debReg3 : OUT  std_logic_vector(9 downto 0);
         debReg4 : OUT  std_logic_vector(9 downto 0);
         debReg5 : OUT  std_logic_vector(9 downto 0);
         debReg6 : OUT  std_logic_vector(9 downto 0);
         debReg7 : OUT  std_logic_vector(9 downto 0);
         debM32 : OUT  std_logic;
         debIncC : OUT  std_logic;
         debHit_Miss : OUT  std_logic;
         debC : OUT  std_logic_vector(6 downto 0);
			debRstC	: out  STD_LOGIC;
         debst1 : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal addrIn : std_logic_vector(15 downto 0) := (others => '0');
   signal wr_rd : std_logic := '0';
   signal cs : std_logic := '0';

 	--Outputs
   signal rdy : std_logic;
   signal addr_SDRAM : std_logic_vector(15 downto 0);
   signal wr_rd_SDRAM : std_logic;
   signal mstrb_SDRAM : std_logic;
   signal addr_SRAM : std_logic_vector(7 downto 0);
   signal wen_SRAM : std_logic_vector(0 downto 0);
   signal muxSel : std_logic;
   signal demuxSel : std_logic;
   signal debReg0 : std_logic_vector(9 downto 0);
   signal debReg1 : std_logic_vector(9 downto 0);
   signal debReg2 : std_logic_vector(9 downto 0);
   signal debReg3 : std_logic_vector(9 downto 0);
   signal debReg4 : std_logic_vector(9 downto 0);
   signal debReg5 : std_logic_vector(9 downto 0);
   signal debReg6 : std_logic_vector(9 downto 0);
   signal debReg7 : std_logic_vector(9 downto 0);
   signal debM32 : std_logic;
   signal debIncC : std_logic;
   signal debHit_Miss : std_logic;
   signal debC : std_logic_vector(6 downto 0);
	signal debRstC	: STD_LOGIC;
   signal debst1 : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: cacheController PORT MAP (
          clk => clk,
          addrIn => addrIn,
          wr_rd => wr_rd,
          cs => cs,
          rdy => rdy,
          addr_SDRAM => addr_SDRAM,
          wr_rd_SDRAM => wr_rd_SDRAM,
          mstrb_SDRAM => mstrb_SDRAM,
          addr_SRAM => addr_SRAM,
          wen_SRAM => wen_SRAM,
          muxSel => muxSel,
          demuxSel => demuxSel,
          debReg0 => debReg0,
          debReg1 => debReg1,
          debReg2 => debReg2,
          debReg3 => debReg3,
          debReg4 => debReg4,
          debReg5 => debReg5,
          debReg6 => debReg6,
          debReg7 => debReg7,
          debM32 => debM32,
          debIncC => debIncC,
          debHit_Miss => debHit_Miss,
          debC => debC,
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
		--cpu_dout <= "10011011";
		
      wait for clk_period*4;
		--cpu_dout <= "00000000";
		cs <= '0';
		
		wait for 640 ns;
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
		--cpu_dout <= "10011011";
		
      wait for clk_period*4;
		--cpu_dout <= "00000000";
		cs <= '0';
      -- insert stimulus here 

      wait;
   end process;

END;
