library ieee;
use ieee.std_logic_1164.all;
use work.dataType.all;


entity relu_tb is
end relu_tb;

architecture Behavioral of relu_tb is
    component relu is
        port(
            inp: in std_logic_vector(15 downto 0);
            res: out std_logic_vector(15 downto 0)
        );
    end component;
    
    signal inp, res: std_logic_vector(15 downto 0);
    begin
        relu0: relu port map(inp, res);
        process begin
            inp <= x"0352";
            wait for 2 ns;
            inp <= x"F302";
            wait for 2 ns;
            inp <= x"0000";
            wait for 2 ns;
            inp <= x"7301";
            wait for 2 ns;
            inp <= x"8201";
            wait for 2 ns;
            wait;
        end process;
    end Behavioral;