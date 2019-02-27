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

entity mux2t1 is
    Port ( A,B: in STD_LOGIC_VECTOR(7 downto 0);
           SEL : in STD_LOGIC;
           M_out : out STD_LOGIC_VECTOR(7 downto 0));
end mux2t1;

architecture mux2t1 of mux2t1 is
    begin
  with SEL select
  M_out <= A when '0',
			B when '1',
			(others => '0') when others;
end mux2t1;

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
--map circuitry

-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity ckt_q3 is
	port (X,Y: in std_logic_vector(7 downto 0);
			S0, S1: in std_logic;
			LDA, LDB, CLK: in std_logic;
			reg_a, reg_b: inout STD_LOGIC_VECTOR(7 downto 0));
end ckt_q3;
architecture q3_structure of ckt_q3 is 
	component mux2t1
		Port ( A,B: in STD_LOGIC_VECTOR(7 downto 0);
				SEL: in STD_LOGIC;
				M_out: out STD_LOGIC_VECTOR(7 downto 0));
	end component;
	component reg8
		Port(  REG_IN: in STD_LOGIC_VECTOR(7 downto 0);
			LD, CLK : in std_logic;
			REG_OUT: out std_logic_vector(7 downto 0));
	end component;

		signal mux_result1, mux_result2 : std_logic_vector (7 downto 0);
begin
    ra: reg8
	port map ( REG_IN => mux_result1,
	           LD => LDA,
	           CLK => CLK,
	           REG_OUT => reg_a);
	rb: reg8
	port map ( REG_IN => reg_a,
				LD => LDB,
				CLK => CLK,
				REG_OUT => reg_b);
	Ma: mux2t1
	port map (  A => X,
				B => reg_b,
				SEL => S1,
				M_out => mux_result1);
	Mb: mux2t1
    port map (  A => reg_a,
                B => Y,
                SEL => S1,
                M_out => mux_result2);
end q3_structure;
