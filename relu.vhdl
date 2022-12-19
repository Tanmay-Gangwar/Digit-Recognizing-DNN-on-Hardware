library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity relu is
    port(
        inp: in std_logic_vector(15 downto 0);
        res: out std_logic_vector(15 downto 0)
    );
end relu;

architecture Behavioral of relu is
begin
    process(inp) is begin
        if (inp(15) = '1') then res <= x"0000";
        else res <= inp;
        end if;
    end process;
end Behavioral;
