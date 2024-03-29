-- File automatically generated by "cdfg2hdl".
-- Filename: fir.vhd
-- Date: 12 October 2013 04:36:43 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE;
use WORK.operpack.all;
use WORK.fir_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity fir is
  port (
    clk : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    out1 : out std_logic_vector(31 downto 0);
    done : out std_logic;
    ready : out std_logic
  );
end fir;

architecture fsmd of fir is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_002_001, S_002_002, S_002_003, S_003_001, S_004_001, S_004_002, S_004_003, S_004_004, S_004_005, S_004_006, S_005_001, S_005_002, S_005_003, S_006_001, S_007_001, S_007_002, S_007_003, S_008_001, S_009_001, S_009_002, S_010_001);
  signal current_state, next_state: state_type;
  signal a : a_type := (
    0 => "00000000000000000000000000000001",
    1 => "00000000000000000000000000000010",
    2 => "00000000000000000000000000000000",
    3 => "00000000000000000000000000000001",
    4 => "00000000000000000000000000000000",
    5 => "00000000000000000000000000000010",
    6 => "00000000000000000000000000000001",
    7 => "00000000000000000000000000000001",
    others => (others => '0'));
  signal v : v_type := (
    0 => "00000000000000000000000000000000",
    1 => "00000000000000000000000000000001",
    2 => "00000000000000000000000000000000",
    3 => "00000000000000000000000000000001",
    4 => "00000000000000000000000000000010",
    5 => "00000000000000000000000000000001",
    6 => "00000000000000000000000000000000",
    7 => "00000000000000000000000000000000",
    8 => "00000000000000000000000000000001",
    9 => "00000000000000000000000000000001",
    others => (others => '0'));
  signal acc_41_next : std_logic_vector(31 downto 0);
  signal acc_41_reg : std_logic_vector(31 downto 0);
  signal acc_41_eval : std_logic_vector(31 downto 0);
  signal acc_11_next : std_logic_vector(31 downto 0);
  signal acc_11_reg : std_logic_vector(31 downto 0);
  signal acc_11_eval : std_logic_vector(31 downto 0);
  signal i_11_next : std_logic_vector(31 downto 0);
  signal i_11_reg : std_logic_vector(31 downto 0);
  signal i_11_eval : std_logic_vector(31 downto 0);
  signal j_21_next : std_logic_vector(31 downto 0);
  signal j_21_reg : std_logic_vector(31 downto 0);
  signal j_21_eval : std_logic_vector(31 downto 0);
  signal D_1377_41_next : std_logic_vector(31 downto 0);
  signal D_1377_41_reg : std_logic_vector(31 downto 0);
  signal D_1377_41_eval : std_logic_vector(31 downto 0);
  signal D_1378_41_next : std_logic_vector(31 downto 0);
  signal D_1378_41_reg : std_logic_vector(31 downto 0);
  signal D_1378_41_eval : std_logic_vector(31 downto 0);
  signal acc_next : std_logic_vector(31 downto 0);
  signal acc_reg : std_logic_vector(31 downto 0);
  signal acc_eval : std_logic_vector(31 downto 0);
  signal j_next : std_logic_vector(31 downto 0);
  signal j_reg : std_logic_vector(31 downto 0);
  signal j_eval : std_logic_vector(31 downto 0);
  signal i_next : std_logic_vector(31 downto 0);
  signal i_reg : std_logic_vector(31 downto 0);
  signal i_eval : std_logic_vector(31 downto 0);
  signal D_1379_41_next : std_logic_vector(31 downto 0);
  signal D_1379_41_reg : std_logic_vector(31 downto 0);
  signal D_1379_41_eval : std_logic_vector(31 downto 0);
  signal j_51_next : std_logic_vector(31 downto 0);
  signal j_51_reg : std_logic_vector(31 downto 0);
  signal j_51_eval : std_logic_vector(31 downto 0);
  signal i_71_next : std_logic_vector(31 downto 0);
  signal i_71_reg : std_logic_vector(31 downto 0);
  signal i_71_eval : std_logic_vector(31 downto 0);
  signal D_1376_41_next : std_logic_vector(31 downto 0);
  signal D_1376_41_reg : std_logic_vector(31 downto 0);
  signal D_1376_41_eval : std_logic_vector(31 downto 0);
  signal out1_next : std_logic_vector(31 downto 0);
  signal out1_reg : std_logic_vector(31 downto 0);
  signal out1_eval : std_logic_vector(31 downto 0);
  constant CNST_0 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000000";
  constant CNST_1 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000001";
  constant CNST_7 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000000111";
  constant CNST_9 : std_logic_vector(63 downto 0) := "0000000000000000000000000000000000000000000000000000000000001001";
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
      acc_41_reg <= (others => '0');
      acc_11_reg <= (others => '0');
      i_11_reg <= (others => '0');
      j_21_reg <= (others => '0');
      D_1377_41_reg <= (others => '0');
      D_1378_41_reg <= (others => '0');
      acc_reg <= (others => '0');
      j_reg <= (others => '0');
      i_reg <= (others => '0');
      D_1379_41_reg <= (others => '0');
      j_51_reg <= (others => '0');
      i_71_reg <= (others => '0');
      D_1376_41_reg <= (others => '0');
      out1_reg <= (others => '0');
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      acc_41_reg <= acc_41_next;
      acc_11_reg <= acc_11_next;
      i_11_reg <= i_11_next;
      j_21_reg <= j_21_next;
      D_1377_41_reg <= D_1377_41_next;
      D_1378_41_reg <= D_1378_41_next;
      acc_reg <= acc_next;
      j_reg <= j_next;
      i_reg <= i_next;
      D_1379_41_reg <= D_1379_41_next;
      j_51_reg <= j_51_next;
      i_71_reg <= i_71_next;
      D_1376_41_reg <= D_1376_41_next;
      out1_reg <= out1_next;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    out1_reg,
    acc_41_reg, acc_41_next,
    acc_11_reg, acc_11_next,
    i_11_reg, i_11_next,
    j_21_reg, j_21_next,
    D_1377_41_reg, D_1377_41_next,
    D_1378_41_reg, D_1378_41_next,
    acc_reg, acc_next,
    j_reg, j_next,
    i_reg, i_next,
    D_1379_41_reg, D_1379_41_next,
    j_51_reg, j_51_next,
    i_71_reg, i_71_next,
    D_1376_41_reg, D_1376_41_next
  )
  begin
    done <= '0';
    ready <= '0';
    acc_41_next <= acc_41_reg;
    acc_11_next <= acc_11_reg;
    i_11_next <= i_11_reg;
    j_21_next <= j_21_reg;
    D_1377_41_next <= D_1377_41_reg;
    D_1378_41_next <= D_1378_41_reg;
    acc_next <= acc_reg;
    j_next <= j_reg;
    i_next <= i_reg;
    D_1379_41_next <= D_1379_41_reg;
    j_51_next <= j_51_reg;
    i_71_next <= i_71_reg;
    D_1376_41_next <= D_1376_41_reg;
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
        acc_11_next <= CNST_0(31 downto 0);
        i_11_next <= CNST_9(31 downto 0);
        next_state <= S_001_002;
      when S_001_002 =>
        i_next <= i_11_reg(31 downto 0);
        acc_next <= acc_11_reg(31 downto 0);
        next_state <= S_001_003;
      when S_001_003 =>
        next_state <= S_008_001;
      when S_002_001 =>
        j_21_next <= CNST_7(31 downto 0);
        next_state <= S_002_002;
      when S_002_002 =>
        j_next <= j_21_reg(31 downto 0);
        next_state <= S_002_003;
      when S_002_003 =>
        next_state <= S_006_001;
      when S_003_001 =>
        if (signed(j_reg) <= signed(i_reg(31 downto 0))) then
          next_state <= S_004_001;
        else
          next_state <= S_005_001;
        end if;
      when S_004_001 =>
        D_1378_41_next <= a(to_integer(unsigned(j_reg(2 downto 0))));
        D_1376_41_next <= std_logic_vector(signed(i_reg) - signed(j_reg(31 downto 0)));
        next_state <= S_004_002;
      when S_004_002 =>
        D_1377_41_next <= v(to_integer(unsigned(D_1376_41_reg(3 downto 0))));
        next_state <= S_004_003;
      when S_004_003 =>
        D_1379_41_next <= mul(D_1377_41_reg, D_1378_41_reg(31 downto 0), '1', 32);
        next_state <= S_004_004;
      when S_004_004 =>
        acc_41_next <= std_logic_vector(signed(D_1379_41_reg) + signed(acc_reg(31 downto 0)));
        next_state <= S_004_005;
      when S_004_005 =>
        acc_next <= acc_41_reg(31 downto 0);
        next_state <= S_004_006;
      when S_004_006 =>
        next_state <= S_005_001;
      when S_005_001 =>
        j_51_next <= std_logic_vector(signed(j_reg) - signed(CNST_1(31 downto 0)));
        next_state <= S_005_002;
      when S_005_002 =>
        j_next <= j_51_reg(31 downto 0);
        next_state <= S_005_003;
      when S_005_003 =>
        next_state <= S_006_001;
      when S_006_001 =>
        if (signed(j_reg) >= signed(CNST_0(31 downto 0))) then
          next_state <= S_003_001;
        else
          next_state <= S_007_001;
        end if;
      when S_007_001 =>
        i_71_next <= std_logic_vector(signed(i_reg) - signed(CNST_1(31 downto 0)));
        next_state <= S_007_002;
      when S_007_002 =>
        i_next <= i_71_reg(31 downto 0);
        next_state <= S_007_003;
      when S_007_003 =>
        next_state <= S_008_001;
      when S_008_001 =>
        if (signed(i_reg) >= signed(CNST_0(31 downto 0))) then
          next_state <= S_002_001;
        else
          next_state <= S_009_001;
        end if;
      when S_009_001 =>
        out1_next <= acc_reg(31 downto 0);
        next_state <= S_009_002;
      when S_009_002 =>
        next_state <= S_010_001;
      when S_010_001 =>
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
