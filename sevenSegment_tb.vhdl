library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sevenSegment_tb is
end entity;

architecture arc of sevenSegment_tb is
    component sevenSegment is
        port (
            digit: in std_logic_vector(3 downto 0);
            display: out std_logic_vector(6 downto 0)
        );
    end component;

    signal digit: std_logic_vector(3 downto 0);
    signal display: std_logic_vector(6 downto 0);

    begin
        seg0: sevenSegment port map (digit, display);
        process begin
            digit <= "0000";
            wait for 1 ns;

            digit <= "0001";
            wait for 1 ns;

            digit <= "0010";
            wait for 1 ns;

            digit <= "0011";
            wait for 1 ns;

            digit <= "0100";
            wait for 1 ns;

            digit <= "0101";
            wait for 1 ns;

            digit <= "0110";
            wait for 1 ns;

            digit <= "0111";
            wait for 1 ns;

            digit <= "1000";
            wait for 1 ns;

            digit <= "1001";
            wait for 1 ns;

            wait;
        end process;
    end arc;