library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity shifter is
    port(
        inp: in std_logic_vector(15 downto 0);
        res: out std_logic_vector(15 downto 0)
    );
end shifter;

architecture Behavioral of shifter is
begin
    res(15 downto 11) <= "00000";
    res(10 downto 0) <= inp(15 downto 5);
end Behavioral;
