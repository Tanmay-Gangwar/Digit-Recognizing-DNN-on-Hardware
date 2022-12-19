library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity mulAc is
    port(
        clk: in std_logic;
        reset: in std_logic;
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(7 downto 0);
        result: out std_logic_vector(15 downto 0)
    );
end mulAc;

architecture Behavioral of mulAc is
    signal res: std_logic_vector(23 downto 0) := x"000000";
    signal currData: std_logic_vector(23 downto 0) := x"000000";
begin
    
    result <= res(15 downto 0);
    process (clk, reset, a, b, currData) begin
        if rising_edge(clk) then
            currData <= res;
        end if;
        if not rising_edge(clk) then
            if reset = '1' then
                res(7 downto 0) <= b;
                if b(7) = '1' then res(23 downto 8) <= x"FFFF";
                else res(23 downto 8) <= x"0000";
                end if;
            else
                res <= currData + a * b;
            end if;
        end if;
    end process;
end Behavioral;
