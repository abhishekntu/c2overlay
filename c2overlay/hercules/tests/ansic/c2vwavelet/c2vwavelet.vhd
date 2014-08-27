-- File automatically generated by "cdfg2hdl".
-- Filename: c2vwavelet.vhd
-- Date: 12 October 2013 02:06:58 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE;
use WORK.operpack.all;
use WORK.c2vwavelet_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity c2vwavelet is
  port (
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    length : in std_logic_vector(31 downto 0);
    y : out std_logic_vector(31 downto 0);
    done : out std_logic;
    ready : out std_logic
  );
end c2vwavelet;

architecture fsmd of c2vwavelet is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_002_001, S_002_002, S_002_003, S_003_001, S_003_002, S_003_003, S_003_004, S_003_005, S_003_006, S_003_007, S_004_001, S_005_001, S_005_002, S_005_003, S_006_001, S_007_001, S_007_002, S_008_001);
  signal current_state, next_state: state_type;
  signal input : input_type := (
    0 => "00000000000000000000000000000001",
    1 => "00000000000000000000000000000010",
    2 => "00000000000000000000000000000011",
    3 => "00000000000000000000000000000100",
    4 => "00000000000000000000000000000101",
    5 => "00000000000000000000000000000110",
    6 => "00000000000000000000000000000111",
    7 => "00000000000000000000000000001000",
    8 => "00000000000000000000000000001001",
    9 => "00000000000000000000000000001010",
    10 => "00000000000000000000000000001011",
    11 => "00000000000000000000000000001100",
    12 => "00000000000000000000000000001101",
    13 => "00000000000000000000000000001110",
    14 => "00000000000000000000000000001111",
    15 => "00000000000000000000000000010000",
    others => (others => '0'));
  signal output : output_type := (
    others => (others => '0'));
  signal sum_31_next : std_logic_vector(31 downto 0);
  signal sum_31_reg : std_logic_vector(31 downto 0);
  signal sum_31_eval : std_logic_vector(31 downto 0);
  signal D_1378_32_next : std_logic_vector(31 downto 0);
  signal D_1378_32_reg : std_logic_vector(31 downto 0);
  signal D_1378_32_eval : std_logic_vector(31 downto 0);
  signal D_1380_31_next : std_logic_vector(31 downto 0);
  signal D_1380_31_reg : std_logic_vector(31 downto 0);
  signal D_1380_31_eval : std_logic_vector(31 downto 0);
  signal i_31_next : std_logic_vector(31 downto 0);
  signal i_31_reg : std_logic_vector(31 downto 0);
  signal i_31_eval : std_logic_vector(31 downto 0);
  signal D_1378_31_next : std_logic_vector(31 downto 0);
  signal D_1378_31_reg : std_logic_vector(31 downto 0);
  signal D_1378_31_eval : std_logic_vector(31 downto 0);
  signal i_21_next : std_logic_vector(31 downto 0);
  signal i_21_reg : std_logic_vector(31 downto 0);
  signal i_21_eval : std_logic_vector(31 downto 0);
  signal D_1379_31_next : std_logic_vector(31 downto 0);
  signal D_1379_31_reg : std_logic_vector(31 downto 0);
  signal D_1379_31_eval : std_logic_vector(31 downto 0);
  signal D_1377_32_next : std_logic_vector(31 downto 0);
  signal D_1377_32_reg : std_logic_vector(31 downto 0);
  signal D_1377_32_eval : std_logic_vector(31 downto 0);
  signal D_1379_32_next : std_logic_vector(31 downto 0);
  signal D_1379_32_reg : std_logic_vector(31 downto 0);
  signal D_1379_32_eval : std_logic_vector(31 downto 0);
  signal D_1377_31_next : std_logic_vector(31 downto 0);
  signal D_1377_31_reg : std_logic_vector(31 downto 0);
  signal D_1377_31_eval : std_logic_vector(31 downto 0);
  signal len_next : std_logic_vector(31 downto 0);
  signal len_reg : std_logic_vector(31 downto 0);
  signal len_eval : std_logic_vector(31 downto 0);
  signal i_next : std_logic_vector(31 downto 0);
  signal i_reg : std_logic_vector(31 downto 0);
  signal i_eval : std_logic_vector(31 downto 0);
  signal D_1376_33_next : std_logic_vector(31 downto 0);
  signal D_1376_33_reg : std_logic_vector(31 downto 0);
  signal D_1376_33_eval : std_logic_vector(31 downto 0);
  signal D_1376_34_next : std_logic_vector(31 downto 0);
  signal D_1376_34_reg : std_logic_vector(31 downto 0);
  signal D_1376_34_eval : std_logic_vector(31 downto 0);
  signal D_1376_31_next : std_logic_vector(31 downto 0);
  signal D_1376_31_reg : std_logic_vector(31 downto 0);
  signal D_1376_31_eval : std_logic_vector(31 downto 0);
  signal D_1376_32_next : std_logic_vector(31 downto 0);
  signal D_1376_32_reg : std_logic_vector(31 downto 0);
  signal D_1376_32_eval : std_logic_vector(31 downto 0);
  signal len_11_next : std_logic_vector(31 downto 0);
  signal len_11_reg : std_logic_vector(31 downto 0);
  signal len_11_eval : std_logic_vector(31 downto 0);
  signal len_51_next : std_logic_vector(31 downto 0);
  signal len_51_reg : std_logic_vector(31 downto 0);
  signal len_51_eval : std_logic_vector(31 downto 0);
  signal difference_31_next : std_logic_vector(31 downto 0);
  signal difference_31_reg : std_logic_vector(31 downto 0);
  signal difference_31_eval : std_logic_vector(31 downto 0);
  signal y_next : std_logic_vector(31 downto 0);
  signal y_reg : std_logic_vector(31 downto 0);
  signal y_eval : std_logic_vector(31 downto 0);
  constant CNST_0 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  constant CNST_1 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
  constant CNST_2 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000010";
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
      sum_31_reg <= (others => '0');
      D_1378_32_reg <= (others => '0');
      D_1380_31_reg <= (others => '0');
      i_31_reg <= (others => '0');
      D_1378_31_reg <= (others => '0');
      i_21_reg <= (others => '0');
      D_1379_31_reg <= (others => '0');
      D_1377_32_reg <= (others => '0');
      D_1379_32_reg <= (others => '0');
      D_1377_31_reg <= (others => '0');
      len_reg <= (others => '0');
      i_reg <= (others => '0');
      D_1376_33_reg <= (others => '0');
      D_1376_34_reg <= (others => '0');
      D_1376_31_reg <= (others => '0');
      D_1376_32_reg <= (others => '0');
      len_11_reg <= (others => '0');
      len_51_reg <= (others => '0');
      difference_31_reg <= (others => '0');
      y_reg <= (others => '0');
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      sum_31_reg <= sum_31_next;
      D_1378_32_reg <= D_1378_32_next;
      D_1380_31_reg <= D_1380_31_next;
      i_31_reg <= i_31_next;
      D_1378_31_reg <= D_1378_31_next;
      i_21_reg <= i_21_next;
      D_1379_31_reg <= D_1379_31_next;
      D_1377_32_reg <= D_1377_32_next;
      D_1379_32_reg <= D_1379_32_next;
      D_1377_31_reg <= D_1377_31_next;
      len_reg <= len_next;
      i_reg <= i_next;
      D_1376_33_reg <= D_1376_33_next;
      D_1376_34_reg <= D_1376_34_next;
      D_1376_31_reg <= D_1376_31_next;
      D_1376_32_reg <= D_1376_32_next;
      len_11_reg <= len_11_next;
      len_51_reg <= len_51_next;
      difference_31_reg <= difference_31_next;
      y_reg <= y_next;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    length,
    y_reg,
    sum_31_reg, sum_31_next,
    D_1378_32_reg, D_1378_32_next,
    D_1380_31_reg, D_1380_31_next,
    i_31_reg, i_31_next,
    D_1378_31_reg, D_1378_31_next,
    i_21_reg, i_21_next,
    D_1379_31_reg, D_1379_31_next,
    D_1377_32_reg, D_1377_32_next,
    D_1379_32_reg, D_1379_32_next,
    D_1377_31_reg, D_1377_31_next,
    len_reg, len_next,
    i_reg, i_next,
    D_1376_33_reg, D_1376_33_next,
    D_1376_34_reg, D_1376_34_next,
    D_1376_31_reg, D_1376_31_next,
    D_1376_32_reg, D_1376_32_next,
    len_11_reg, len_11_next,
    len_51_reg, len_51_next,
    difference_31_reg, difference_31_next
  )
  begin
    done <= '0';
    ready <= '0';
    sum_31_next <= sum_31_reg;
    D_1378_32_next <= D_1378_32_reg;
    D_1380_31_next <= D_1380_31_reg;
    i_31_next <= i_31_reg;
    D_1378_31_next <= D_1378_31_reg;
    i_21_next <= i_21_reg;
    D_1379_31_next <= D_1379_31_reg;
    D_1377_32_next <= D_1377_32_reg;
    D_1379_32_next <= D_1379_32_reg;
    D_1377_31_next <= D_1377_31_reg;
    len_next <= len_reg;
    i_next <= i_reg;
    D_1376_33_next <= D_1376_33_reg;
    D_1376_34_next <= D_1376_34_reg;
    D_1376_31_next <= D_1376_31_reg;
    D_1376_32_next <= D_1376_32_reg;
    len_11_next <= len_11_reg;
    len_51_next <= len_51_reg;
    difference_31_next <= difference_31_reg;
    y_next <= y_reg;
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        len_11_next <= "0" & length(31 downto 1);
        len_next <= len_11_next (31 downto 0);
        next_state <= S_006_001;
      when S_002_001 =>
        i_21_next <= CNST_0(31 downto 0);
        i_next <= i_21_next (31 downto 0);
        next_state <= S_004_001;
      when S_003_001 =>
        D_1380_31_next <= std_logic_vector(unsigned(len_reg) + unsigned(i_reg(31 downto 0)));
        i_31_next <= std_logic_vector(unsigned(i_reg) + unsigned(CNST_1(31 downto 0)));
        D_1376_33_next <= mul(i_reg, CNST_2(31 downto 0), '0', 32);
        D_1376_34_next <= mul(i_reg, CNST_2(31 downto 0), '0', 32);
        D_1376_31_next <= mul(i_reg, CNST_2(31 downto 0), '0', 32);
        D_1376_32_next <= mul(i_reg, CNST_2(31 downto 0), '0', 32);
        D_1378_32_next <= std_logic_vector(unsigned(D_1376_34_next ) + unsigned(CNST_1(31 downto 0)));
        D_1378_31_next <= std_logic_vector(unsigned(D_1376_32_next ) + unsigned(CNST_1(31 downto 0)));
        D_1377_32_next <= input(to_integer(unsigned(D_1376_33_next (3 downto 0))));
        D_1377_31_next <= input(to_integer(unsigned(D_1376_31_next (3 downto 0))));
        D_1379_31_next <= input(to_integer(unsigned(D_1378_31_next (3 downto 0))));
        D_1379_32_next <= input(to_integer(unsigned(D_1378_32_next (3 downto 0))));
        sum_31_next <= std_logic_vector(unsigned(D_1377_31_next ) + unsigned(D_1379_31_next (31 downto 0)));
        difference_31_next <= std_logic_vector(unsigned(D_1377_32_next ) - unsigned(D_1379_32_next (31 downto 0)));
        output(to_integer(unsigned(i_reg(3 downto 0)))) <= sum_31_next (31 downto 0);
        output(to_integer(unsigned(D_1380_31_next (3 downto 0)))) <= difference_31_next (31 downto 0);
        i_next <= i_31_next (31 downto 0);
        next_state <= S_004_001; --
      when S_004_001 =>        --
        if (i_reg < len_reg(31 downto 0)) then
          next_state <= S_003_001;
        else
          next_state <= S_005_001;
        end if;
      when S_005_001 =>
        len_51_next <= "0" & len_reg(31 downto 1);
        len_next <= len_51_next (31 downto 0);
        next_state <= S_006_001; --
      when S_006_001 =>        --
        if (len_reg > CNST_1(31 downto 0)) then
          next_state <= S_002_001;
        else
          next_state <= S_007_001;
        end if;
      when S_007_001 =>
        y_next <= CNST_1(31 downto 0);
        next_state <= S_008_001; --
      when S_008_001 =>        --
        next_state <= S_EXIT; --
      when S_EXIT =>        --
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

  y <= y_reg;

end fsmd;