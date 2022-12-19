library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
    
-- sevenSegment component takes digit in binary form and outputs the logic for seven segment display
entity sevenSegment is
    port (
        digit: in std_logic_vector(3 downto 0);
        display: out std_logic_vector(6 downto 0)
    );
end entity;

architecture arc of sevenSegment is
    begin
        -- logic for lighting up every segment of segment display
        display(0) <= not ((digit(2) xor digit(1)) or digit(3) or (digit(2) and not digit(0)));
        display(1) <= not ((not digit(1) and not digit(0)) or (digit(2) and not digit(1)) or (digit(2) and not digit(0)) or digit(3));
        display(2) <= not ((not digit(2) and not digit(0)) or (digit(1) and not digit(0)));
        display(3) <= not (digit(3) or (digit(1) and not digit(0)) or (not digit(2) and not digit(0)) or (digit(0) and (digit(2) xor digit(1))));
        display(4) <= not (not digit(1) or digit(0) or digit(2));
        display(5) <= not (not digit(2) or not (digit(1) xor digit(0)));
        display(6) <= not (not (digit(2) xor digit(0)) or digit(3) or digit(1));
end arc;