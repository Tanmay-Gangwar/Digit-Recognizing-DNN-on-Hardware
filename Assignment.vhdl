library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.std_logic_signed.all;
use work.dataType.all;

entity Assignment is
    port(
        clock: in std_logic;
        an: out std_logic_vector(3 downto 0);
        seg: out std_logic_vector(6 downto 0)
    );
end entity;

architecture Behavioral of Assignment is
    component mulAc is
        port(
            clk: in std_logic;
            reset: in std_logic;
            a: in std_logic_vector(15 downto 0);
            b: in std_logic_vector(7 downto 0);
            result: out std_logic_vector(15 downto 0)
        );
    end component;

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

    component relu is
        port(
            inp: in std_logic_vector(15 downto 0);
            res: out std_logic_vector(15 downto 0)
        );
    end component;

    component shifter is
        port(
            inp: in std_logic_vector(15 downto 0);
            res: out std_logic_vector(15 downto 0)
        );
    end component;

    component sevenSegment is
        port (
            digit: in std_logic_vector(3 downto 0);
            display: out std_logic_vector(6 downto 0)
        );
    end component;
    
    signal clkCnt: integer := 0;
    signal fsmState: std_logic_vector(1 downto 0) := "00";
    signal mulAc0_a: std_logic_vector(15 downto 0) := x"0000";
    signal mulAc1_a: std_logic_vector(15 downto 0) := x"0000";
    signal mulAc0_b: std_logic_vector(7 downto 0) := x"00";
    signal mulAc1_b: std_logic_vector(7 downto 0) := x"00";
    signal mulAc0_reset: std_logic := '0';
    signal mulAc1_reset: std_logic := '0';
    signal mulAc0_result: std_logic_vector(15 downto 0) := x"0000";
    signal mulAc1_result: std_logic_vector(15 downto 0) := x"0000";
    signal rwm0_index: integer := 0;
    signal rwm1_index: integer := 0;
    signal rwm0_wrSignal: std_logic := '0';
    signal rwm1_wrSignal: std_logic := '0';
    signal rwm0_newData: std_logic_vector(15 downto 0) := x"0000";
    signal rwm1_newData: std_logic_vector(15 downto 0) := x"0000";
    signal rwm0_data: std_logic_vector(15 downto 0) := x"0000";
    signal rwm1_data: std_logic_vector(15 downto 0) := x"0000";
    signal rrom_img_index: integer := 0;
    signal rrom_wb_index: integer := 0;
    signal rrom_img_data: std_logic_vector(7 downto 0) := x"00";
    signal rrom_wb_data: std_logic_vector(7 downto 0) := x"00";
    signal relu0_out: std_logic_vector(15 downto 0) := x"0000";
    signal mx: std_logic_vector(15 downto 0) := x"0000";
    signal mxLoc: std_logic_vector(3 downto 0) := x"0";
    signal clk: std_logic := '0';
    signal tempCnt: std_logic := '0';

    begin
        rrom0: rrom generic map(784, "./data/imgdata_digit7.mif", 50890, "./data/weights_bias.mif") port map(rrom_img_index, rrom_wb_index, rrom_img_data, rrom_wb_data);
        mulAc0: mulAc port map(clk, mulAc0_reset, mulAc0_a, mulAc0_b, mulAc0_result);
        mulAc1: mulAc port map(clk, mulAc1_reset, mulAc1_a, mulAc1_b, mulAc1_result);
        rwm0: rwm generic map(64) port map(clk, rwm0_index, rwm0_wrSignal, rwm0_newData, rwm0_data);
        rwm1: rwm generic map(10) port map(clk, rwm1_index, rwm1_wrSignal, rwm1_newData, rwm1_data);
        relu0: relu port map(mulAc0_result, relu0_out);
        relu1: relu port map(mulAc1_result, rwm1_newData);
        shifter0: shifter port map(relu0_out, rwm0_newData);
        sevenSegment0: sevenSegment port map(mxLoc, seg);
        mulAc0_a(7 downto 0) <= rrom_img_data;
        mulAc0_b <= rrom_wb_data;
        mulAc1_a <= rwm0_data;
        mulAc1_b <= rrom_wb_data;
        an <= "1110";
        
        
        process(clock) is begin
            if rising_edge(clock) then
                tempCnt <= not tempCnt;
                if tempCnt = '1' then clk <= not clk;
                end if;
            end if;
        end process;

        process (clk) is begin
            if rising_edge(clk) then
                if fsmState = "00" and clkCnt = 10000 then
                    fsmState <= "01";
                    clkCnt <= 0;
                elsif fsmState = "01" and clkCnt = 50239 then
                    fsmState <= "10";
                    clkCnt <= 0;
                elsif fsmState = "10" and clkCnt = 649 then
                    fsmState <= "11";
                    clkCnt <= 0;
                elsif fsmState /= "11" or clkCnt < 10 then clkCnt <= clkCnt + 1;
                end if;
            end if;
        end process;

        process (clkCnt) is begin
            if fsmState = "01" then
                rwm0_wrSignal <= '1';
                rwm0_index <= clkCnt / 785;
                if clkCnt mod 785 = 0 then
                    mulAc0_reset <= '1';
                    rrom_wb_index <= 50176 + clkCnt / 785;
                else
                    mulAc0_reset <= '0';
                    rrom_img_index <= clkCnt mod 785 - 1;
                    rrom_wb_index <= clkCnt - clkCnt / 785 - 1;
                end if;
            else
                rwm0_wrSignal <= '0';
                mulAc0_reset <= '1';
            end if;

            if fsmState = "10" then
                rwm1_wrSignal <= '1';
                rwm1_index <= clkCnt / 65;
                if clkCnt mod 65 = 0 then
                    mulAc1_reset <= '1';
                    rrom_wb_index <= 50880 + clkCnt / 65;
                else
                    mulAc1_reset <= '0';
                    rwm0_index <= clkCnt mod 65 - 1;
                    rrom_wb_index <= 50239 + clkCnt - clkCnt / 65;
                end if;
            else
                rwm1_wrSignal <= '0';
                mulAc1_reset <= '1';
            end if;

            if fsmState = "11" and clkCnt < 10 then
                rwm1_index <= clkCnt;
            end if;
        end process;
    
        process (rwm1_index, rwm1_data, fsmState, clkCnt) is begin
            if fsmState = "11" and clkCnt < 10 and rwm1_data > mx then
                mx <= rwm1_data;
                mxLoc <= std_logic_vector(to_signed(clkCnt, 4));
            end if;
        end process;
    end Behavioral;
    