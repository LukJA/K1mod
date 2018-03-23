-- vhdl entity
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.global.all;

entity ID is 
	port (	
		CIR	: in std_logic_vector(15 downto 0);
		
		reg_D1	: out std_logic_vector(7 downto 0);
		
		reg_clk1_EN, reg_clk2_EN	: out std_logic := '0';
		
		reg_addr1, reg_addr2	: out	std_logic_vector(5 downto 0);
		
		ALU_OP	: out std_logic_vector(3 downto 0);
		OVERFLOW, ZERO, EQIN	: in std_logic;
		
		PCOut : out std_logic_vector(11 downto 0);
		jumpEn : inout std_logic;
		
		addDat, readWri, enab	: out std_logic := '0'
		);
		
end ID;

architecture behavioral of ID is

	signal EQ_LAT, Z_LAT : std_logic := '0';

begin
	
	process(all)begin
	
	-- set some defaults
	-- data is normally zeroed
	reg_D1 <= "00000000";
	-- disable clocks
	reg_clk1_EN <= '0';
	reg_clk2_EN <= '0';
	-- set addresses to 0x00 and 0x01
	reg_addr1 <= "000000";
	reg_addr2 <= "000001";
	-- set ALU to follow through
	ALU_OP <= "1111";
	
	-- disable expansion interface
	addDat	<= '0';
	readWri	<= '0';
	enab		<= '0';
	
	jumpEn <= '0';
		
		case CIR(15 downto 12) is
		
			when "0000" =>
				-- NOP -- defaults
				reg_D1 <= "00000000";
				-- disable clocks
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '0';
				-- set addresses to 0x00 and 0x01
				reg_addr1 <= "000000";
				reg_addr2 <= "000001";
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
		
			when "0001" =>
				-- MOV instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "1111"; -- set ALU to follow through
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "0010" =>
				-- LDI instruction
				reg_D1 <= CIR(7 downto 0);	-- use half the CIR for data
				reg_clk1_EN <= '1';	-- enable the port 1 clock
				reg_clk2_EN <= '0';  
				reg_addr1 <= ("000000") or CIR(11 downto 8);	-- use the next 4 to address the first 16 regs
				reg_addr2 <= "000000";	-- default
				ALU_OP <= "1111"; -- set ALU to follow through
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
			
			when "0011" =>
				-- ADD instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0000"; -- set ALU to ADD
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "0100" =>
				-- SUB instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0001"; -- set ALU to SUB
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "0101" =>
				-- AND instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0101"; -- set ALU to AND
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "0110" =>
				-- OR instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0110"; -- set ALU to OR
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "0111" =>
				-- XOR instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0101"; -- set ALU to XOR
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "1000" =>
				-- NOT instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "0111"; -- set ALU to NOT
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			when "1001" =>
				-- INC instruction
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '1';  -- enable the port 2 clock
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "1001"; -- set ALU to INC
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
			------------------------------------------
				
			when "1010" =>
				-- AJMP instruction -- absolute jump
				-- defaults
				reg_D1 <= "00000000";
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '0';
				reg_addr1 <= "000000";
				reg_addr2 <= "000001";
				ALU_OP <= "1111";
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
				PCOut <= CIR(11 downto 0);	-- set the new location
				jumpEn <= '1';					-- tell it to jump next clock
				
			when "1011" =>
				-- CPI instruction -- compare ie load ALU without clocks just setting address
				reg_D1 <= "00000000";	-- clear the D1 port
				reg_clk1_EN <= '0';	-- disable all clocks
				reg_clk2_EN <= '0';  
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				ALU_OP <= "1111"; -- set ALU to follow through
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
				-- latch the result
				EQ_LAT <= EQIN;
				Z_LAT <= ZERO;
				
			when "1100" =>
				-- JMNE instruction -- Jump if not equal
				if not EQ_LAT then
				
					reg_D1 <= "00000000";
					reg_clk1_EN <= '0';
					reg_clk2_EN <= '0';
					reg_addr1 <= "000000";
					reg_addr2 <= "000001";
					ALU_OP <= "1111";
					-- disable expansion interface
					addDat	<= '0';
					readWri	<= '0';
					enab		<= '0';
				
					PCOut <= CIR(11 downto 0);	-- set the new location
					jumpEn <= '1';		
					
				end if;
				
			when "1101" =>
				-- JMIE instruction -- jump if equal
				if EQ_LAT then
				
					reg_D1 <= "00000000";
					reg_clk1_EN <= '0';
					reg_clk2_EN <= '0';
					reg_addr1 <= "000000";
					reg_addr2 <= "000001";
					ALU_OP <= "1111";
					-- disable expansion interface
					addDat	<= '0';
					readWri	<= '0';
					enab		<= '0';
					
					PCOut <= CIR(11 downto 0);	-- set the new location
					jumpEn <= '1';	
					
				end if;
				
			when "1110" =>
				-- expansion read write data (combined instruction)
				enab <= '1';
				-- set to data
				addDat <= '1';
				-- set to read of write 
				readWri <= CIR(11);
				-- set the number choice
				reg_addr1 <= CIR(5 downto 0);
				ALU_OP <= "1111"; -- set ALU to follow through
				
				
			when "1111" =>
				-- expansion address set 
				-- enable block
				enab <= '1';
				-- set to address
				addDat <= '0';
				-- set the pointer registers
				reg_addr1 <= CIR(11 downto 6);
				reg_addr2 <= CIR(5 downto 0);	-- select the sddress lines
				
			
			when others =>
				-- defaults
				reg_D1 <= "00000000";
				reg_clk1_EN <= '0';
				reg_clk2_EN <= '0';
				reg_addr1 <= "000000";
				reg_addr2 <= "000001";
				ALU_OP <= "1111";
				-- disable expansion interface
				addDat	<= '0';
				readWri	<= '0';
				enab		<= '0';
				
		end case;
	
	end process;

end behavioral;