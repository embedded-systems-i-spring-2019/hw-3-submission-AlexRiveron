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

entity ckt_q5 is
	port (Ai,Bi,Ci: in std_logic_vector(7 downto 0);
			SL1, SL2, CLK: in std_logic;
			RAX, RBX: out STD_LOGIC_VECTOR(7 downto 0));
end ckt_q5;
architecture q5_structure of ckt_q5 is 
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
	component dec1to2
	Port ( dsel: in std_logic;
                Dout0, Dout1: out std_logic);
    end component;

        signal dec_r0, dec_r1 : std_logic;
		signal mux_result1 : std_logic_vector (7 downto 0);
begin
    ra: reg8
	port map ( REG_IN => Ai,
	           LD => dec_r1,
	           CLK => CLK,
	           REG_OUT => RAX);
	rb: reg8
	port map ( REG_IN => mux_result1,
				LD => dec_r0,
				CLK => CLK,
				REG_OUT => RBX);
	dc: dec1to2
	port map( dsel => SL1,
	           Dout0 => dec_r0,
	           Dout1 => dec_r1);
	Ma: mux2t1
	port map (  A => Bi,
				B => Ci,
				SEL => SL2,
				M_out => mux_result1);
end q5_structure;
