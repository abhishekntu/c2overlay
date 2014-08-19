-- File automatically generated by "cdfg2hdl".
-- Filename: icbrt_tb.vhd
-- Date: 12 October 2013 04:22:56 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE, STD;
use STD.textio.all;
use WORK.std_logic_textio.all;
use IEEE.numeric_std.all;
use WORK.icbrt_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;

entity icbrt_tb is
end icbrt_tb;

architecture tb_arch of icbrt_tb is
  component icbrt
    port (
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      x : in std_logic_vector(31 downto 0);
      res : out std_logic_vector(31 downto 0);
      done : out std_logic;
      ready : out std_logic
    );
  end component;
  signal clk : std_logic;
  signal reset : std_logic;
  signal start : std_logic;
  signal x : std_logic_vector(31 downto 0);
  signal res : std_logic_vector(31 downto 0);
  signal done : std_logic;
  signal ready : std_logic;
  -- Profiling signals
  signal ncycles : integer;
  -- Constant declarations
  constant CLK_PERIOD : time := 10 ns;
  -- Declare test data file and results file
  file TestDataFile: text open read_mode is "icbrt_test_data.txt";
  file ResultsFile: text open write_mode is "icbrt_alg_test_results.txt";
begin
  uut : icbrt
    port map (
      clk => clk,
      reset => reset,
      start => start,
      x => x,
      res => res,
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

  ICBRT_BENCH: process
    variable x_v : unsigned(31 downto 0);
    variable x_v_vec : std_logic_vector(31 downto 0);
    variable res_v, res_ref : signed(31 downto 0);
    variable res_v_vec, res_ref_vec : std_logic_vector(31 downto 0);
    variable ncycles_v: integer;
    variable ntests_v : integer := 1;
    variable ntests_max : integer := 2049;
    variable TestData, BufLine: line;
    variable Passed: std_logic := '1';
  begin
    while not endfile(TestDataFile) loop
      -- Read test data from file
      readline(TestDataFile, TestData);
      hread(TestData, x_v_vec);
      x <= x_v_vec;
      hread(TestData, res_ref_vec);
      res_ref := SIGNED(res_ref_vec);
      wait until done = '1';
      res_v := signed(res);
      -- Test ICBRT algorithm
      if (
          (res_v /= res_ref)
      ) then
        Passed := '0';
        write(Bufline, string'("ICBRT error: x="));
        hwrite(Bufline, STD_LOGIC_VECTOR(x));
        write(Bufline, string'(" res="));
        hwrite(Bufline, STD_LOGIC_VECTOR(res_v));
        write(Bufline, string'(" res_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(res_ref));
        writeline(ResultsFile, Bufline);
      else
        write(Bufline, string'(" x="));
        hwrite(Bufline, STD_LOGIC_VECTOR(x));
        write(Bufline, string'(" res="));
        hwrite(Bufline, STD_LOGIC_VECTOR(res));
        write(Bufline, string'(" res_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(res_ref));
        writeline(ResultsFile, Bufline);
        ncycles_v := ncycles;
        write(Bufline, string'("ICBRT OK: Number of cycles="));
        write(Bufline, ncycles_v);
        writeline(ResultsFile, Bufline);
      end if;
      if (ntests_v = ntests_max) then
        exit;
      end if;
      ntests_v := ntests_v + 1;
    end loop;
    if (Passed = '1') then
      write(Bufline, string'("ICBRT algorithm test has passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "NONE. End simulation time reached"
        severity failure;
    else
      write(Bufline, string'("ICBRT algorithm test has not passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "ERRORS. End simulation time reached"
        severity failure;
    end if;
    wait for CLK_PERIOD;
  end process ICBRT_BENCH;

end tb_arch;
