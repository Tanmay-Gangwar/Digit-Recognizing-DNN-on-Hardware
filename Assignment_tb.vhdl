library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity Assignment_tb is
end entity;

architecture Behavioral of Assignment_tb is
    component Assignment is
        port(
            clock: in std_logic;
            an: out std_logic_vector(3 downto 0);
            seg: out std_logic_vector(6 downto 0)
        );
    end component;

    signal clock: std_logic := '0';
    signal an: std_logic_vector(3 downto 0);
    signal seg: std_logic_vector(6 downto 0);
    begin
        Assignment0: Assignment port map(clock, an, seg);
        clock <= not clock after 0.75 ns;
end Behavioral;
    