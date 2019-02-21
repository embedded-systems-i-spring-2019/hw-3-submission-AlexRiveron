----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/21/2019 02:23:28 PM
-- Design Name: 
-- Module Name: Q3 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity mux4t1 is
    Port ( A,B,C,D: in STD_LOGIC_VECTOR(7 downto 0);
			msel: in STD_LOGIC_VECTOR(1 downto 0);
			M_out: out STD_LOGIC_VECTOR(7 downto 0));
end mux4t1;

architecture mux4t1 of mux4t1 is
signal mux_out : STD_LOGIC_VECTOR(7 downto 0);
    begin
    with msel select
		M_out <= A when "11",
				B when "10",
				C when "01",
				D when "00",
				(others => '0') when others;
end mux4t1;

-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity reg8 is
	Port ( REG_IN: in STD_LOGIC_VECTOR(7 downto 0);
			LD, CLK : in std_logic;
			REG_OUT: out std_logic_vector(7 downto 0));
end reg8;
architecture reg8 of reg8 is
begin 
	reg: process(CLK)
	begin
		if (rising_edge(CLK)) then
			if (LD = '1') then 
			REG_OUT <= REG_IN;
		end if;
	end if;
end process;
end reg8;

-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity dec1to2 is
	Port ( dsel: in std_logic;
			Dout0, Dout1: out std_logic);
end dec1to2;
architecture dec1to2 of dec1to2 is
begin
	with dsel select
	Dout1 <= '0' when '0',
        '1' when '1',
		'0' when others;
	with dsel select
	Dout0 <= '1' when '0',
		'0' when '1',
		'0' when others;
end dec1to2;
--map circuitry

-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity ckt_q2 is
	port (X,Y,Z: in std_logic_vector(7 downto 0);
			MS: in std_logic_vector(1 downto 0);
			DS, CLK: in std_logic;
			reg_a, reg_b: inout STD_LOGIC_VECTOR(7 downto 0));
end ckt_q2;
architecture q2_structure of ckt_q2 is 
	component mux4t1
		Port ( A,B,C,D: in STD_LOGIC_VECTOR(7 downto 0);
				msel: in STD_LOGIC_VECTOR(1 downto 0);
				M_out: out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	component reg8
		Port(  REG_IN: in STD_LOGIC_VECTOR(7 downto 0);
			LD, CLK : in std_logic;
			REG_OUT: out std_logic_vector(7 downto 0));
	end component;
	component dec1to2
		Port ( dsel: in std_logic;
			Dout1, Dout0: out std_logic);
	end component;

		signal mux_result : std_logic_vector (7 downto 0);
		signal dec_result0, dec_result1 : std_logic;
begin
	ra: reg8
	port map ( REG_IN => mux_result,
				LD => dec_result0,
				CLK => CLK,
				REG_OUT => reg_a);
	rb: reg8
	port map ( REG_IN => reg_a,
				LD => dec_result1,
				CLK => CLK,
				REG_OUT => reg_b);
	M: mux4t1
	port map ( A => X,
				B => Y,
				C => Z,
				D => reg_b,
				msel => MS,
				M_out => mux_result);
	D: dec1to2
	port map ( dsel => DS,
				Dout0 => dec_result0,
				Dout1 => dec_result1);
end q2_structure;