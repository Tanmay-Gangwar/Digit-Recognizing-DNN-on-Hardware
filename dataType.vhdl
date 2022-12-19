library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;

package dataType is
    type shortVector is array(natural range<>) of std_logic_vector(7 downto 0);
    type vector is array(natural range<>) of std_logic_vector(15 downto 0);
end package;