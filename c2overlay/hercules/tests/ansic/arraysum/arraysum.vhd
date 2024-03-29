-- File automatically generated by "cdfg2hdl".
-- Filename: arraysum.vhd
-- Date: 25 October 2013 11:14:17 AM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE;
use WORK.operpack.all;
use WORK.arraysum_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity arraysum is
  port (
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    in1 : in std_logic_vector(31 downto 0);
    out1 : out std_logic_vector(31 downto 0);
    done : out std_logic;
    ready : out std_logic
  );
end arraysum;

architecture fsmd of arraysum is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_001_005, S_002_001, S_002_002, S_002_003, S_002_004, S_002_005, S_002_006, S_003_001, S_004_001, S_004_002, S_005_001);
  signal current_state, next_state: state_type;
  signal arr : arr_type := (
    0 => "00000000000000000000000000000010",
    1 => "00000000000000000000000000000011",
    2 => "00000000000000000000000000000101",
    3 => "00000000000000000000000000000111",
    4 => "00000000000000000000000000001011",
    5 => "00000000000000000000000000001101",
    6 => "00000000000000000000000000010001",
    7 => "00000000000000000000000000010011",
    8 => "00000000000000000000000000010111",
    9 => "00000000000000000000000000011011",
    others => (others => '0'));
  signal sum_3_next : std_logic_vector(31 downto 0);
  signal sum_3_reg : std_logic_vector(31 downto 0);
  signal sum_3_eval : std_logic_vector(31 downto 0);
  signal i_3_next : std_logic_vector(31 downto 0);
  signal i_3_reg : std_logic_vector(31 downto 0);
  signal i_3_eval : std_logic_vector(31 downto 0);
  signal sum_1_next : std_logic_vector(31 downto 0);
  signal sum_1_reg : std_logic_vector(31 downto 0);
  signal sum_1_eval : std_logic_vector(31 downto 0);
  signal i_1_next : std_logic_vector(31 downto 0);
  signal i_1_reg : std_logic_vector(31 downto 0);
  signal i_1_eval : std_logic_vector(31 downto 0);
  signal D_1237_3_next : std_logic_vector(31 downto 0);
  signal D_1237_3_reg : std_logic_vector(31 downto 0);
  signal D_1237_3_eval : std_logic_vector(31 downto 0);
  signal i_4_next : std_logic_vector(31 downto 0);
  signal i_4_reg : std_logic_vector(31 downto 0);
  signal i_4_eval : std_logic_vector(31 downto 0);
  signal sum_4_next : std_logic_vector(31 downto 0);
  signal sum_4_reg : std_logic_vector(31 downto 0);
  signal sum_4_eval : std_logic_vector(31 downto 0);
  signal out1_next : std_logic_vector(31 downto 0);
  signal out1_reg : std_logic_vector(31 downto 0);
  signal out1_eval : std_logic_vector(31 downto 0);
  constant CNST_0 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  constant CNST_1 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
      sum_3_reg <= (others => '0');
      i_3_reg <= (others => '0');
      sum_1_reg <= (others => '0');
      i_1_reg <= (others => '0');
      D_1237_3_reg <= (others => '0');
      i_4_reg <= (others => '0');
      sum_4_reg <= (others => '0');
      out1_reg <= (others => '0');
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      sum_3_reg <= sum_3_next;
      i_3_reg <= i_3_next;
      sum_1_reg <= sum_1_next;
      i_1_reg <= i_1_next;
      D_1237_3_reg <= D_1237_3_next;
      i_4_reg <= i_4_next;
      sum_4_reg <= sum_4_next;
      out1_reg <= out1_next;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    in1,
    out1_reg,
    sum_3_reg, sum_3_next,
    i_3_reg, i_3_next,
    sum_1_reg, sum_1_next,
    i_1_reg, i_1_next,
    D_1237_3_reg, D_1237_3_next,
    i_4_reg, i_4_next,
    sum_4_reg, sum_4_next
  )
  begin
    done <= '0';
    ready <= '0';
    sum_3_next <= sum_3_reg;
    i_3_next <= i_3_reg;
    sum_1_next <= sum_1_reg;
    i_1_next <= i_1_reg;
    D_1237_3_next <= D_1237_3_reg;
    i_4_next <= i_4_reg;
    sum_4_next <= sum_4_reg;
    out1_next <= out1_reg;
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        sum_1_next <= CNST_0(31 downto 0);
        next_state <= S_001_002;
      when S_001_002 =>
        i_1_next <= CNST_0(31 downto 0);
        next_state <= S_001_003;
      when S_001_003 =>
        i_4_next <= i_1_reg(31 downto 0);
        next_state <= S_001_004;
      when S_001_004 =>
        sum_4_next <= sum_1_reg(31 downto 0);
        next_state <= S_001_005;
      when S_001_005 =>
        next_state <= S_003_001;
      when S_002_001 =>
        D_1237_3_next <= arr(to_integer(unsigned(i_4_reg(3 downto 0))));
        next_state <= S_002_002;
      when S_002_002 =>
        sum_3_next <= std_logic_vector(signed(D_1237_3_reg) + signed(sum_4_reg(31 downto 0)));
        next_state <= S_002_003;
      when S_002_003 =>
        i_3_next <= std_logic_vector(signed(i_4_reg) + signed(CNST_1(31 downto 0)));
        next_state <= S_002_004;
      when S_002_004 =>
        i_4_next <= i_3_reg(31 downto 0);
        next_state <= S_002_005;
      when S_002_005 =>
        sum_4_next <= sum_3_reg(31 downto 0);
        next_state <= S_002_006;
      when S_002_006 =>
        next_state <= S_003_001;
      when S_003_001 =>
        if (signed(i_4_reg) < signed(in1(31 downto 0))) then
          next_state <= S_002_001;
        else
          next_state <= S_004_001;
        end if;
      when S_004_001 =>
        out1_next <= sum_4_reg(31 downto 0);
        next_state <= S_004_002;
      when S_004_002 =>
        next_state <= S_005_001;
      when S_005_001 =>
        next_state <= S_EXIT;
      when S_EXIT =>
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

  out1 <= out1_reg;

end fsmd;
