----------------------------------------------------------------------------------
-- Company:				Ryerson University 
-- Engineer: 			Victor Dumitriu
-- 
-- Design Name: 		CPU Read/Write Transaction Generator
-- Module Name:		CPU_gen - Behavioral 
-- Target Devices: 	XC3S500E
--
-- Description: 		A testbench circuit for course COE758, Project 1.
--							The circuit plays the role of a CPU, generating read
--							and write transactions to various addresses. The Cache
--							Controller being designed for Project 1 must respond to
--							these transactions.
--
-- Dependencies: 		None.
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CPU is
	Port ( 
		clk 		: in  STD_LOGIC;
      --rst 		: in  STD_LOGIC;
      --trig 		: in  STD_LOGIC;
		--Interface to the Cache Controller.
      --Address 	: out  STD_LOGIC_VECTOR (15 downto 0);
      --wr_rd 	: out  STD_LOGIC;
      --cs 		: out  STD_LOGIC;
      --DOut 		: out  STD_LOGIC_VECTOR (7 downto 0);
		
		--Debug Ouputs
		debReg0 		: OUT std_logic_vector(9 downto 0);
		debReg1 		: OUT std_logic_vector(9 downto 0);
		debReg2 		: OUT std_logic_vector(9 downto 0);
		debReg3 		: OUT std_logic_vector(9 downto 0);
		debReg4 		: OUT std_logic_vector(9 downto 0);
		debReg5 		: OUT std_logic_vector(9 downto 0);
		debReg6 		: OUT std_logic_vector(9 downto 0);
		debReg7		: OUT std_logic_vector(9 downto 0);
		debtrig		: OUT std_logic;
		debHit_Miss : OUT std_logic;
		debAddr_SRAM : OUT std_logic_vector(7 downto 0);
		debAddr_SDRAM : OUT std_logic_vector(15 downto 0);
		debmstrb 		: OUT std_logic;
		debM32 			: OUT std_logic;
		debRstC 			: OUT std_logic;
		debCachest1	 	: OUT std_logic_vector(2 downto 0);
		debpatCtrl	 	: OUT std_logic_vector(2 downto 0);
		debCPU_out		: out  STD_LOGIC_VECTOR (24 downto 0);
		debCPU_Din		: out  STD_LOGIC_VECTOR (7 downto 0)
	);
end CPU;

architecture Behavioral of CPU is
	
	-- Interface to the Cache Controller.
	signal rst 		:  STD_LOGIC;
   signal trig 		: STD_LOGIC;
	signal Address 	: STD_LOGIC_VECTOR (15 downto 0);
   signal wr_rd 	: STD_LOGIC;
   signal cs 		: STD_LOGIC;
   signal DOut 		: STD_LOGIC_VECTOR (7 downto 0);
	
	
	-- Pattern storage and control.
	signal patOut : std_logic_vector(24 downto 0);
	signal patCtrl : std_logic_vector(2 downto 0) := "111";
	signal updPat : std_logic;
	
	-- Main control.
	signal st1 : std_logic_vector(2 downto 0) := "000";
	signal st1N : std_logic_vector(2 downto 0);
	
	-- Rising edge detection.
	signal rReg1, rReg2 : std_logic := '0';
	signal trig_r : std_logic;
	
	--
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

begin
	
	Inst_Project: Project PORT MAP(
		clk => clk,
		addrIn => Address,
		wr_rd => wr_rd,
		cs => cs,
		cpu_dout => DOut,
		cpu_din => debCPU_Din,
		rdy => trig,
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
		debst1 => debCachest1
	);
	
	debTrig <= trig;
	debpatCtrl <= patCtrl;
	--------------------------------------------------------------------------
	-- Main control FSM.
	--------------------------------------------------------------------------
	
	-- State storage.
	process(clk, rst, st1N)
	begin
		if(rst = '1')then
			st1 <= "000";
		else
			if(clk'event and clk = '1')then
				st1 <= st1N;
			end if;
		end if;
	end process;
	
	-- Next state generation.
	process(st1, trig_r)
	begin
		if(st1 = "000")then
			if(trig_r = '1')then
				st1N <= "001";
			else
				st1N <= "000";
			end if;
		elsif(st1 = "001")then
			st1N <= "010";
		elsif(st1 = "010")then
			st1N <= "011";
		elsif(st1 = "011")then
			st1N <= "100";
		elsif(st1 = "100")then
			st1N <= "101";
		elsif(st1 = "101")then
			st1N <= "000";
		else
			st1N <= "000";
		end if;
	end process;
	
	-- Output generation.
	process(st1)
	begin
		if(st1 = "000")then
			updPat <= '0';
			cs <= '0';
		elsif(st1 = "001")then
			updPat <= '1';
			cs <= '0';
		elsif(st1 = "010")then
			updPat <= '0';
			cs <= '1';
		elsif(st1 = "011")then
			updPat <= '0';
			cs <= '1';
		elsif(st1 = "100")then
			updPat <= '0';
			cs <= '1';
		elsif(st1 = "101")then
			updPat <= '0';
			cs <= '1';
		else
		end if;
	end process;
	
	--------------------------------------------------------------------------
	-- Pattern generator and control circuit.
	--------------------------------------------------------------------------
	
	-- Generator control circuit.
	process(clk, rst, updPat, patCtrl)
	begin
		if(rst = '1')then
			patCtrl <= "111";
		else
			if(clk'event and clk = '1')then
				if(updPat = '1')then
					patCtrl <= patCtrl + "001";
				else
					patCtrl <= patCtrl;
				end if;
			end if;
		end if;
	end process;
	
	-- Pattern storage.
	process(patCtrl)
	begin
		if(patCtrl = "000")then                        -- ALL THE USER GENERATED CPU ADDR
			patOut <= "0001000100000000101010101";  
		elsif(PatCtrl = "001")then
			patOut <= "0001000100000010101110111";
		elsif(PatCtrl = "010")then
			patOut <= "0001000100000000000000000";
		elsif(PatCtrl = "011")then
			patOut <= "0001000100000010000000000";
		elsif(PatCtrl = "100")then
			patOut <= "0011001101000110000000000";
		elsif(PatCtrl = "101")then
			patOut <= "0100010001000100000000000";
		elsif(PatCtrl = "110")then
			patOut <= "0101010100000100110011001";
		else
			patOut <= "0110011000000110000000000";
		end if;
	end process;
	
	--------------------------------------------------------------------------
	-- Rising edge detector.
	--------------------------------------------------------------------------
	
	-- Register 1
	process(clk, trig)
	begin
		if(clk'event and clk = '1')then
			rReg1 <= trig;
		end if;
	end process;
	
	-- Register 2
	process(clk, rReg1)
	begin
		if(clk'event and clk = '1')then
			rReg2 <= rReg1;
		end if;
	end process;
	
	trig_r <= rReg1 and (not rReg2);
	--trig_r <= trig;
	--------------------------------------------------------------------------
	-- Output connections.
	--------------------------------------------------------------------------
	
	-- Output mapping:
	-- Address [24 .. 9]
	-- Data [8 .. 1]
	-- Wr/Rd [0]
	
	Address(15 downto 0) <= patOut(24 downto 9);
	DOut(7 downto 0) <= patOut(8 downto 1);
	wr_rd <= patOut(0);
	
	debCPU_out <= patOut;

end Behavioral;