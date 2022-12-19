library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity mulAc_tb is
end entity;

architecture Behavioral of mulAc_tb is
    component mulAc is
        port(
            clk: in std_logic;
            reset: in std_logic;
            a: in std_logic_vector(15 downto 0);
            b: in std_logic_vector(7 downto 0);
            result: out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk, reset: std_logic := '1';
    signal a, result: std_logic_vector(15 downto 0);
    signal b: std_logic_vector(7 downto 0);

    begin
        clk <= not clk after 1 ns;
        mul0: mulAc port map(clk, reset, a, b, result);
        process begin
            reset <= '1';
            b <= x"04";
            wait for 2 ns;

            reset <= '0';
            a <= x"0002";
            b <= x"03";
            wait for 2 ns;

            a <= x"0004";
            b <= x"FD";
            wait for 2 ns;

            a <= x"0002";
            b <= x"05";
            wait for 2 ns;

            reset <= '1';
            b <= x"FC";
            wait for 2 ns;

            reset <= '0';
            a <= x"0003";
            b <= x"01";
            wait for 2 ns;

            a <= x"0005";
            b <= x"FD";
            wait for 2 ns;

            a <= x"0007";
            b <= x"06";
            wait for 2 ns;
            
            reset <= '1';
            wait;
        end process;
    end Behavioral;
    