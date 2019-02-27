----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2019 09:16:50 PM
-- Design Name: 
-- Module Name: fancy_counter - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fancy_counter is
    Port ( clk : in STD_LOGIC;
           clk_en : in STD_LOGIC;
           dir : in STD_LOGIC;
           en : in STD_LOGIC;
           ld : in STD_LOGIC;
           rst : in STD_LOGIC;
           updn : in STD_LOGIC;
           val : in STD_LOGIC_VECTOR (3 downto 0);
           cnt : inout STD_LOGIC_VECTOR (3 downto 0));
end fancy_counter;

architecture Behavioral of fancy_counter is

signal temp: std_logic := '0';

begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            if (en = '1') then
                if (rst = '0') then
                    if (clk_en = '1') then
                        if (updn ='1') then
                            temp <= dir;
                        end if;
                        if (ld = '1') then
                            cnt <= val;
                        else if (temp = '1') then
                            if (cnt = val) then
                                cnt <= "0000";
                            else 
                                cnt <= STD_LOGIC_VECTOR (unsigned(cnt) + 1);
                            end if;
                        else if( temp = '0') then
                            if (cnt = "0000") then
                                cnt <= val;
                            else 
                                cnt <= STD_LOGIC_VECTOR (unsigned(cnt) - 1);
                            end if;
                        end if;
                        end if;
                        end if;
                    end if;
                else if (rst = '1') then
                    cnt <= "0000";
                    if (clk_en = '1') then
                        if (updn = '1') then
                            temp <= dir;
                        end if;
                    end if;
                end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
