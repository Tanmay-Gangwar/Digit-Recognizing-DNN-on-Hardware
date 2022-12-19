library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;

entity rwm is
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
end rwm;

architecture Behavioral of rwm is
    signal memory: vector(0 to ramSize - 1);
begin
    data <= memory(index);
    process (wrSignal, index, newData, clk) begin
        if wrSignal = '1' and rising_edge(clk) then
            memory(index) <= newData;
        end if;
    end process;
end Behavioral;
