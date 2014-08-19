-- File automatically generated by "cdfg2hdl".
-- Filename: eda_tb.vhd
-- Date: 24 October 2013 06:57:47 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE, STD;
use STD.textio.all;
use WORK.std_logic_textio.all;
use IEEE.numeric_std.all;
use WORK.eda_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;

entity eda_tb is
end eda_tb;

architecture tb_arch of eda_tb is
  component eda
    port (
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      in1 : in std_logic_vector(31 downto 0);
      in2 : in std_logic_vector(31 downto 0);
      out1 : out std_logic_vector(31 downto 0);
      done : out std_logic;
      ready : out std_logic
    );
  end component;
  signal clk : std_logic;
  signal reset : std_logic;
  signal start : std_logic;
  signal in1 : std_logic_vector(31 downto 0);
  signal in2 : std_logic_vector(31 downto 0);
  signal out1 : std_logic_vector(31 downto 0);
  signal done : std_logic;
  signal ready : std_logic;
  -- Profiling signals
  signal ncycles : integer;
  -- Constant declarations
  constant CLK_PERIOD : time := 10 ns;
  -- Declare test data file and results file
  file TestDataFile: text open read_mode is "eda_test_data.txt";
  file ResultsFile: text open write_mode is "eda_alg_test_results.txt";
begin
  uut : eda
    port map (
      clk => clk,
      reset => reset,
      start => start,
      in1 => in1,
      in2 => in2,
      out1 => out1,
      ready => ready,
      done => done
    );

  CLK_GEN_PROC: process(clk)
  begin
    if (clk = 'U') then
      clk <= '1';
    else
      clk <= not clk after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  RESET_START_STIM: process
  begin
    reset <= '1';
    start <= '0';
    wait for CLK_PERIOD;
    reset <= '0';
    start <= '1';
    wait for 536870911*CLK_PERIOD;
  end process RESET_START_STIM;

  PROFILING: process(clk, reset, done)
  begin
    if (reset = '1' or done = '1') then
      ncycles <= 0;
    elsif (clk = '1' and clk'EVENT) then
      ncycles <= ncycles + 1;
    end if;
  end process PROFILING;

  EDA_BENCH: process
    variable in1_v : signed(31 downto 0);
    variable in1_v_vec : std_logic_vector(31 downto 0);
    variable in2_v : signed(31 downto 0);
    variable in2_v_vec : std_logic_vector(31 downto 0);
    variable out1_v, out1_ref : signed(31 downto 0);
    variable out1_v_vec, out1_ref_vec : std_logic_vector(31 downto 0);
    variable ncycles_v: integer;
    variable ntests_v : integer := 1;
    variable ntests_max : integer := 32;
    variable TestData, BufLine: line;
    variable Passed: std_logic := '1';
  begin
    while not endfile(TestDataFile) loop
      -- Read test data from file
      readline(TestDataFile, TestData);
      hread(TestData, in1_v_vec);
      in1 <= in1_v_vec;
      hread(TestData, in2_v_vec);
      in2 <= in2_v_vec;
      hread(TestData, out1_ref_vec);
      out1_ref := SIGNED(out1_ref_vec);
      wait until done = '1';
      out1_v := signed(out1);
      -- Test EDA algorithm
      if (
          (out1_v /= out1_ref)
      ) then
        Passed := '0';
        write(Bufline, string'("EDA error: in1="));
        hwrite(Bufline, STD_LOGIC_VECTOR(in1));
        write(Bufline, string'("EDA error: in2="));
        hwrite(Bufline, STD_LOGIC_VECTOR(in2));
        write(Bufline, string'(" out1="));
        hwrite(Bufline, STD_LOGIC_VECTOR(out1_v));
        write(Bufline, string'(" out1_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(out1_ref));
        writeline(ResultsFile, Bufline);
      else
        write(Bufline, string'(" in1="));
        hwrite(Bufline, STD_LOGIC_VECTOR(in1));
        write(Bufline, string'(" in2="));
        hwrite(Bufline, STD_LOGIC_VECTOR(in2));
        write(Bufline, string'(" out1="));
        hwrite(Bufline, STD_LOGIC_VECTOR(out1));
        write(Bufline, string'(" out1_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(out1_ref));
        writeline(ResultsFile, Bufline);
        ncycles_v := ncycles;
        write(Bufline, string'("EDA OK: Number of cycles="));
        write(Bufline, ncycles_v);
        writeline(ResultsFile, Bufline);
      end if;
      if (ntests_v = ntests_max) then
        exit;
      end if;
      ntests_v := ntests_v + 1;
    end loop;
    if (Passed = '1') then
      write(Bufline, string'("EDA algorithm test has passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "NONE. End simulation time reached"
        severity failure;
    else
      write(Bufline, string'("EDA algorithm test has not passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "ERRORS. End simulation time reached"
        severity failure;
    end if;
    wait for CLK_PERIOD;
  end process EDA_BENCH;

end tb_arch;
