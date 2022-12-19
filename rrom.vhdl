library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_signed.all;
use work.dataType.all;
use std.textio.all;

entity rrom is
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
end rrom;

architecture Behavioral of rrom is
    impure function init_vector(file1_name: in string; file2_name: in string) return shortVector is
        file mif_file1 : text open read_mode is file1_name;
        file mif_file2 : text open read_mode is file2_name;
        variable mif_line: line;
        variable temp_bv: bit_vector(7 downto 0);
        variable temp_vector: shortVector(0 to img_size + weight_bias_size - 1);
    begin
        for i in 0 to img_size - 1 loop
            readline(mif_file1, mif_line);
            read(mif_line, temp_bv);
            temp_vector(i) := to_stdlogicvector(temp_bv);
        end loop;
        for i in img_size to img_size + weight_bias_size - 1 loop
            readline(mif_file2, mif_line);
            read(mif_line, temp_bv);
            temp_vector(i) := to_stdlogicvector(temp_bv);
        end loop;
        return temp_vector;
    end function;
    
    signal rom_block: shortVector(0 to img_size + weight_bias_size - 1) := init_vector(img_file_name, weight_bias_file_name);
begin
    img_data <= rom_block(img_index);
    wb_data <= rom_block(wb_index + 784);
end Behavioral;
