library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity rwm_tb is
end entity;

architecture Behavioral of rwm_tb is
    component rwm is
        generic(
            ramSize: integer := 1024
        );
        port(
            clk : in std_logic;
            index : in integer;
            wrSignal : in std_logic;
            newData : in std_logic_vector(15 downto 0);
            data : out std_logic_vector(15 downto 0)
        );
    end component;

    signal clk, wrSignal: std_logic := '0';
    signal index : integer := 0;
    signal newData, data: std_logic_vector(15 downto 0) := x"0000";

    begin
        rwm0: rwm generic map(16) port map(clk, index, wrSignal, newData, data);
        clk <= not clk after 0.75 ns;
        process begin
            wrSignal <= '1';
            index <= 3;
            newData <= x"0006";
            wait for 2 ns;

            index <= 5;
            newData <= x"0007";
            wait for 2 ns;

            wrSignal <= '0';
            index <= 3;
            wait for 2 ns;

            wrSignal <= '1';
            index <= 0;
            newData <= x"0009";
            wait for 2 ns;

            wrSignal <= '0';
            index <= 3;
            wait for 2 ns;

            index <= 5;
            wait for 2 ns;

            index <= 0;
            wait for 2 ns;
            wait;
        end process;
    end Behavioral;