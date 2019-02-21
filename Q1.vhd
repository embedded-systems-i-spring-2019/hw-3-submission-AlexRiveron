--library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity q1 is
    Port ( A: in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           SEL : in STD_LOGIC;
           LDA, CLK: in STD_LOGIC;
		   reg_a: out STD_LOGIC_VECTOR (7 downto 0));
end q1;

architecture q1_behavioral of q1 is
signal mux_out : STD_LOGIC_VECTOR(7 downto 0);
    begin
    ra: process(CLK)
    begin
         if rising_edge(CLK) then
           if (LDA = '1') then
            reg_a <= mux_out;
         end if;
    end if;
  end process ra;
  with SEL select
  mux_out <= A when '0',
			B when '1',
			(others => '0') when others;
end q1_behavioral;