----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:57:38 09/29/2020 
-- Design Name: 
-- Module Name:    cachController - Behavioral 
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

entity cacheController is
    Port ( clk				: in	 STD_LOGIC;
			  addrIn 		: in  STD_LOGIC_VECTOR (15 downto 0);
           wr_rd 			: in  STD_LOGIC;
           cs 				: in  STD_LOGIC;
           rdy 			: out  STD_LOGIC;
           addr_SDRAM 	: out  STD_LOGIC_VECTOR (15 downto 0);
           wr_rd_SDRAM 	: out  STD_LOGIC;
           mstrb_SDRAM 	: out  STD_LOGIC;
           addr_SRAM 	: out  STD_LOGIC_VECTOR (7 downto 0);
           wen_SRAM 		: out  STD_LOGIC_VECTOR (0 downto 0);
           muxSel 		: out  STD_LOGIC;
			  demuxSel 		: out  STD_LOGIC;
			  
			  --debug registers
			  debReg0		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg1		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg2		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg3		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg4		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg5		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg6		: out STD_LOGIC_VECTOR(9 downto 0);
			  debReg7		: out STD_LOGIC_VECTOR(9 downto 0);
			  
			  --debug outputs
			  debM32, debIncC	: out  STD_LOGIC;
			  debHit_Miss		: out  STD_LOGIC;
			  debRstC			: out  STD_LOGIC;
			  debst1				: out  STD_LOGIC_VECTOR(2 downto 0));
			  
			  
			  
end cacheController;

architecture Behavioral of cacheController is

	-- Array of the Blocks
	type Reg is array(0 to 7) of STD_LOGIC_VECTOR(9 downto 0);
	signal CacheReg: Reg := (others=>(others=>'0'));
	--Bit 9 = V-bit, Bit 8 = D-bit, Bits 7-0 = Tag
	
	-- Common Cache Controller Signals
	signal Tag 			: STD_LOGIC_VECTOR (7 downto 0);
	signal Index		: STD_LOGIC_VECTOR (2 downto 0);
	signal Offset		: STD_LOGIC_VECTOR (4 downto 0);
	signal Hit_Miss	: STD_LOGIC;
	signal CPU_wr_rd	: STD_LOGIC;
	
	--UpCounter
	signal rstC, incC : STD_LOGIC := '0';
	signal SD_Offset	: STD_LOGIC_VECTOR (6 downto 0) := (others => '0');
	-- Bit 6 = indicator when done
	-- Bits 5 downto 1 = offset
	-- Bit 0 = memstrobe
	
	--Comparators
	signal match32	: STD_LOGIC; -- Technichally it match 64, but its when the offset matches 32
	
	--FSM control Unit
	signal st1 	: STD_LOGIC_VECTOR(2 downto 0) := "000";
	signal st1N : STD_LOGIC_VECTOR(2 downto 0);
	signal st1NN: STD_LOGIC_VECTOR(2 downto 0); -- state to be set to st1N after buffer st7
	
	
	begin
		Tag <= addrIn(15 downto 8);
		Index <= addrIn(7 downto 5);
		Offset <= addrIn(4 downto 0);
					
		--UpCounter: Based of the Digital Design Tutorial
		upCounter: process(clk, rstC)
		begin
			if(rstC = '1')then
				SD_Offset <= "0000000";
			else
				if(clk'event and clk = '1' and incC = '1')then
					SD_Offset <= SD_Offset + "0000001";
				end if;
			end if;
		end process;
		
		
		--Comparators, used to flag specific counter values.
		comparator32 : process(SD_Offset)
		begin
			if(SD_Offset = "1000000")then
				match32 <= '1';
			else
				match32 <= '0';
			end if;
		end process;
		
		debM32 <= match32;

		-- FMS Control Unit
		-- State storage.
		stateStorage: process(clk, st1N)
		begin
			if(clk'event and clk = '1')then
				st1 <= st1N;
			end if;
		end process;
		
		debst1 <= st1;

		
		--Next State Generation
		nextStateGen: process(st1, cs, Hit_Miss, SD_Offset, match32)
		begin
			if (st1 = "000") then -- S0: Rest State
				if (cs = '1') then
					--Storing inputs from cpu
					CPU_wr_rd <= wr_rd;
					--
					st1N <= "001";
				else
					rstC <= '0';
					Hit_Miss <= '0';
					st1N <= "000";
				end if;
			
			elsif (st1 = "001") then -- S1: Hit or Miss Check
				if (CacheReg(to_integer(unsigned(Index)))(7 downto 0) = Tag) then
					Hit_Miss <= '1' and CacheReg(to_integer(unsigned(Index)))(9); -- Hit; data requested is in the cache
				else
					Hit_Miss <= '0' and CacheReg(to_integer(unsigned(Index)))(9); -- Miss; data requested wasn't in the cache
				end if;
				if (Hit_Miss = '1') then          -- If data requested is in the cache then 
					if (CPU_wr_rd = '1') then      -- If write mode is on, go into write operation state
						st1N <= "010";              -- S2: Write Operation State
					elsif (CPU_wr_rd = '0') then   -- If read mode is on, go into read operation state
						st1N <= "011";              -- S3: Read Operation State
					end if;
				else
					if (CacheReg(to_integer(unsigned(Index)))(9) = '1') then    --V-bit = 1
						if (CacheReg(to_integer(unsigned(Index)))(8) = '1') then --D-bit = 1
							st1N <= "100"; --State 4: Load Block to SDRAM controller
						else              --D-bit = 0
							st1N <= "101"; --State 5: Fetch Block from SDRAM controller
						end if;
					else                 --V-bit = 0
						st1N <= "101";    --State 5: Fetch Block from SDRAM controller
					end if;
				end if;
			
			elsif (st1 = "010") then -- S2: Write Operation
			CacheReg(to_integer(unsigned(Index)))(8) <= '1'; -- D-bit = 1
			rstC <= '1'; -- Reset counter before going back to rest state.
			st1N <= "000"; -- Back to state 0
			
			
			elsif (st1 = "011") then -- S3: Read Operation
			rstC <= '1'; -- Reset counter before going back to rest state
			st1N <= "111"; -- Give the Cache SRAM and extra clock to read.
			st1NN <= "000"; -- Back to state 0
			
			
			elsif (st1 = "100") then -- S4: Load Operation
				if (match32 = '1') then -- Completed 32 operations
					st1N <= "111";
					st1NN <= "101"; -- S5: Fetch Operation
				else
					rstC <= '0';
					st1N <= "100";
				end if;
			
			elsif (st1 = "111") then -- S7: Buffer State to reset counter when going from load to fetch
				rstC <= '1';
				st1N <= st1NN;
			
			elsif (st1 = "101") then -- S5: Fetch Operation
				if (match32 = '1') then -- Completed 32 operations
					CacheReg(to_integer(unsigned(Index)))(9) <= '1'; -- V-bit = 1
					CacheReg(to_integer(unsigned(Index)))(8) <= '0'; -- D-bit = 0
					CacheReg(to_integer(unsigned(Index)))(7 downto 0) <= Tag; -- New Tag for the Register Block;
					if (CPU_wr_rd = '1') then
						st1N <= "010"; -- S2: Write Operation
					elsif (CPU_wr_rd = '0') then
						st1N <= "011"; -- S3: Read Operation
					end if;
				else
					rstC <= '0';
					st1N <= "101";
				end if;
			end if;
		end process;
		
		--Output Generation
		outGen: process(st1, SD_Offset)
		begin
			if(st1 = "000")then		--S0: Rest state.
				rdy 			<= '1';
				wr_rd_SDRAM <= '0';
				mstrb_SDRAM <= '0';
				wen_SRAM(0) <= '0';
				muxSel 		<= '0';
				demuxSel    <= '1'; -- Select cpu as the output for data when in rest
				incC 			<= '0';
				
			elsif(st1 = "001")then		--S1: Hit_Miss Check state.
				rdy 			<= '0';
				wr_rd_SDRAM <= '0';
				mstrb_SDRAM <= '0';
				wen_SRAM(0) 	<= '0';
				muxSel 		<= '0';
				demuxSel    <= '0';
				incC 			<= '0';
			
			elsif(st1 = "010")then		--S2: Write to SRAM Block state.
				rdy 			<= '0';
				addr_SRAM 	<= Index & Offset;
				mstrb_SDRAM <= '0';
				wr_rd_SDRAM <= '0';
				wen_SRAM(0) 	<= '1';
				muxSel 		<= '0';  -- Selecting CPU as DIN
				demuxSel    <= '1'; -- Selecting CPU as DOUT
				incC 			<= '0';
			
			elsif(st1 = "011")then		--S3: Read from SRAM Block state.
				rdy 			<= '0';
				addr_SRAM 	<= Index & Offset;
				mstrb_SDRAM <= '0';
				wr_rd_SDRAM <= '0';
				wen_SRAM(0) 	<= '0';
				muxSel 		<= '0';  -- Selecting CPU as DIN
				demuxSel    <= '1'; -- Selecting CPU as DOUT
				incC 			<= '0';
				
				
			elsif(st1 = "100")then		--S4: Load to SDRAM Controller state.
				rdy 			<= '0';
				addr_SDRAM 	<= CacheReg(to_integer(unsigned(Index)))(7 downto 0) & Index & SD_Offset(5 downto 1); -- Address using tag of previous block in Cache SRAM
				addr_SRAM 	<= Index & SD_Offset(5 downto 1); 
				mstrb_SDRAM <= SD_Offset(0);
				wr_rd_SDRAM <= '1'; -- Writing to SD_RAM
				wen_SRAM(0) 	<= '0'; -- Reading to SRAM;
				muxSel 		<= '1'; -- DIN form SDRAM Controller to Cache SRAM
				demuxSel    <= '0'; -- DOUT from Local Cache SRAM to SDRAM
				incC 			<= '1'; -- Upcounter enabled
				
			elsif(st1 = "101")then		--S5: Fetch from SDRAM Controller state.
				rdy 			<= '0';
				addr_SDRAM 	<= Tag & Index & SD_Offset(5 downto 1); -- Address for the new block
				addr_SRAM 	<= Index & SD_Offset(5 downto 1); 
				mstrb_SDRAM <= SD_Offset(0);
				wr_rd_SDRAM <= '0'; -- Reading from SD_RAM
				wen_SRAM(0) <= '1'; -- writing to SRAM;
				muxSel 		<= '1'; -- DIN form SDRAM Controller to Cache SRAM
				demuxSel    <= '0'; -- DOUT from Cache SRAM to SDRAM
				incC 			<= '1';
			end if;
			
		end process;
		
		debIncC		<= incC;
		debRstC		<= rstC;
		debHit_Miss <= Hit_Miss;
		debReg0		<= CacheReg(0);
		debReg1		<= CacheReg(1);
		debReg2		<= CacheReg(2);
		debReg3		<= CacheReg(3);
		debReg4		<= CacheReg(4);
		debReg5		<= CacheReg(5);
		debReg6		<= CacheReg(6);
		debReg7		<= CacheReg(7);
		
end Behavioral;
