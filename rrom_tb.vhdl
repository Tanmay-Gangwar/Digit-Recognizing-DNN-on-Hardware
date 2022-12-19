library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;
use std.textio.all;

entity rrom_tb is
end entity;

architecture Behavioral of rrom_tb is
    component rrom is
        generic(
            img_size: integer := 784;
            img_file_name: string := "imgdata.mif";
            weight_bias_size: integer := 50890;
            weight_bias_file_name: string := "weight_bias.mif"
        );
        port(
            img_index: in integer;
            wb_index: in integer;
            img_data: out std_logic_vector(7 downto 0);
            wb_data: out std_logic_vector(7 downto 0)
        );
    end component;

    signal img_data, wb_data: std_logic_vector(7 downto 0);
    signal img_index, wb_index: integer := 0;
    signal a, b, c, d: std_logic_vector(7 downto 0);
    begin
        rrom0: rrom generic map(784, "./data/imgdata_digit7.mif", 50890, "./data/weights_bias.mif") port map(img_index, wb_index, img_data, wb_data);
        process is begin
            img_index <= 0;
            wb_index <= 0;
            wait for 2 ns;
            img_index <= 1;
            wb_index <= 1;
            wait for 2 ns;
            img_index <= 2;
            wb_index <= 2;
            wait for 2 ns;
            img_index <= 202;
            wb_index <= 205;
            wait for 2 ns;

            wait;
        end process;
    end Behavioral;