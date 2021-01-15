----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:52 10/20/2020 
-- Design Name: 
-- Module Name:    Project - Behavioral 
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

entity Project is
    Port (  clk 		: in  STD_LOGIC;
				addrIn 	: in std_logic_vector(15 downto 0);
				wr_rd 		: in std_logic;
				cs 			: in std_logic;
				cpu_dout	: in STD_LOGIC_VECTOR(7 downto 0);
				cpu_din	: out	STD_LOGIC_VECTOR(7 downto 0);
				rdy 		: out  std_logic;

				--Debug Ouputs
				debReg0 			: OUT std_logic_vector(9 downto 0);
				debReg1 			: OUT std_logic_vector(9 downto 0);
				debReg2 			: OUT std_logic_vector(9 downto 0);
				debReg3 			: OUT std_logic_vector(9 downto 0);
				debReg4 			: OUT std_logic_vector(9 downto 0);
				debReg5 			: OUT std_logic_vector(9 downto 0);
				debReg6 			: OUT std_logic_vector(9 downto 0);
				debReg7			: OUT std_logic_vector(9 downto 0);
				debHit_Miss 	: OUT std_logic;
				debAddr_SRAM	: OUT std_logic_vector(7 downto 0);
				debAddr_SDRAM	: OUT std_logic_vector(15 downto 0);
				debmstrb 		: OUT std_logic;
				debM32 			: OUT std_logic;
				debRstC 			: OUT std_logic;
				debst1	 		: OUT std_logic_vector(2 downto 0));
			  
end Project;

architecture Behavioral of Project is

	signal addr_SDRAM :  std_logic_vector(15 downto 0);
	signal wr_rd_SDRAM :  std_logic;
	signal mstrb_SDRAM :  std_logic;
	signal addr_SRAM :  std_logic_vector(7 downto 0);
	signal wen_SRAM : std_logic_vector(0 to 0);
	signal muxSel :  std_logic;
	signal demuxSel :  std_logic;
	
	--Mux inputs
	signal din0		: std_logic_vector(7 downto 0);
	signal din1		: std_logic_vector(7 downto 0);
	signal din_sel	: std_logic_vector(7 downto 0);
	
	--Demux inputs
	signal dout0		: std_logic_vector(7 downto 0);
	signal dout1		: std_logic_vector(7 downto 0);
	signal dout			: std_logic_vector(7 downto 0);

		COMPONENT cacheController
	PORT(
		clk : IN std_logic;
		addrIn : IN std_logic_vector(15 downto 0);
		wr_rd : IN std_logic;
		cs : IN std_logic;          
		rdy : OUT std_logic;
		addr_SDRAM : OUT std_logic_vector(15 downto 0);
		wr_rd_SDRAM : OUT std_logic;
		mstrb_SDRAM : OUT std_logic;
		addr_SRAM : OUT std_logic_vector(7 downto 0);
		wen_SRAM : OUT std_logic_vector(0 to 0);
		muxSel : OUT std_logic;
		demuxSel : OUT std_logic;
		debReg0 : OUT std_logic_vector(9 downto 0);
		debReg1 : OUT std_logic_vector(9 downto 0);
		debReg2 : OUT std_logic_vector(9 downto 0);
		debReg3 : OUT std_logic_vector(9 downto 0);
		debReg4 : OUT std_logic_vector(9 downto 0);
		debReg5 : OUT std_logic_vector(9 downto 0);
		debReg6 : OUT std_logic_vector(9 downto 0);
		debReg7 : OUT std_logic_vector(9 downto 0);
		debM32 : OUT std_logic;
		debIncC : OUT std_logic;
		debHit_Miss : OUT std_logic;
		debRstC : OUT std_logic;
		debst1 : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;

	COMPONENT CacheSRAM
	PORT (
		clka : IN STD_LOGIC;
		wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
		addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT mux2to1
	PORT(
		s : IN std_logic;
		w0 : IN std_logic_vector(7 downto 0);
		w1 : IN std_logic_vector(7 downto 0);          
		f : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT demux2to1
	PORT(
		s : IN std_logic;
		w : IN std_logic_vector(7 downto 0);          
		f0 : OUT std_logic_vector(7 downto 0);
		f1 : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT SDRAMController
	PORT(
		clk : IN std_logic;
		addr : IN std_logic_vector(15 downto 0);
		wr_rd : IN std_logic;
		memstrb : IN std_logic;
		din : IN std_logic_vector(7 downto 0);          
		dout : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
begin
	Inst_cacheController: cacheController PORT MAP(
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
		debHit_Miss => debHit_Miss,
		debRstC => debRstC,
		debst1 => debst1
	);

	Inst_CacheSRAM : CacheSRAM PORT MAP (
		clka => clk,
		wea => wen_SRAM,
		addra => addr_SRAM,
		dina => din_sel,
		douta => dout
	);
	
	Inst_mux2to1: mux2to1 PORT MAP(
		s => muxSel,
		w0 => din0,
		w1 => din1,
		f => din_sel
	);
	
	Inst_demux2to1: demux2to1 PORT MAP(
		s => demuxSel,
		w => dout,
		f0 => dout0,
		f1 => dout1
	);
	
	Inst_SDRAMController: SDRAMController PORT MAP(
		clk => clk,
		addr => addr_SDRAM,
		wr_rd => wr_rd_SDRAM,
		memstrb => mstrb_SDRAM,
		din => dout0,
		dout => din1
	);
	
	process(clk, cs)
		begin
			if (cs = '1') then
				--Storing inputs from cpu
				din0 <= cpu_dout; 
			end if;
	end process;
	
	cpu_din <= dout1;
	debAddr_SRAM	<= addr_SRAM;
	debAddr_SDRAM	<= addr_SDRAM;
	debmstrb 		<= mstrb_SDRAM;

	
end Behavioral;

