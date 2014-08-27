-- File automatically generated by "cdfg2hdl".
-- Filename: bitrev_tb.vhd
-- Date: 12 October 2013 12:34:17 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE, STD;
use STD.textio.all;
use WORK.std_logic_textio.all;
use IEEE.numeric_std.all;
use WORK.bitrev_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;

entity bitrev_tb is
end bitrev_tb;

architecture tb_arch of bitrev_tb is
  component bitrev
    port (
      clk : in std_logic;
      reset : in std_logic;
      start : in std_logic;
      inp : in std_logic_vector(7 downto 0);
      D_1377 : out std_logic_vector(7 downto 0);
      done : out std_logic;
      ready : out std_logic
    );
  end component;
  signal clk : std_logic;
  signal reset : std_logic;
  signal start : std_logic;
  signal inp : std_logic_vector(7 downto 0);
  signal D_1377 : std_logic_vector(7 downto 0);
  signal done : std_logic;
  signal ready : std_logic;
  -- Profiling signals
  signal ncycles : integer;
  -- Constant declarations
  constant CLK_PERIOD : time := 10 ns;
  -- Declare test data file and results file
  file TestDataFile: text open read_mode is "bitrev_test_data.txt";
  file ResultsFile: text open write_mode is "bitrev_alg_test_results.txt";
begin
  uut : bitrev
    port map (
      clk => clk,
      reset => reset,
      start => start,
      inp => inp,
      D_1377 => D_1377,
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

  BITREV_BENCH: process
    variable inp_v : unsigned(7 downto 0);
    variable inp_v_vec : std_logic_vector(7 downto 0);
    variable D_1377_v, D_1377_ref : unsigned(7 downto 0);
    variable D_1377_v_vec, D_1377_ref_vec : std_logic_vector(7 downto 0);
    variable ncycles_v: integer;
    variable ntests_v : integer := 1;
    variable ntests_max : integer := 256;
    variable TestData, BufLine: line;
    variable Passed: std_logic := '1';
  begin
    while not endfile(TestDataFile) loop
      -- Read test data from file
      readline(TestDataFile, TestData);
      hread(TestData, inp_v_vec);
      inp <= inp_v_vec;
      hread(TestData, D_1377_ref_vec);
      D_1377_ref := UNSIGNED(D_1377_ref_vec);
      wait until done = '1';
      D_1377_v := UNSIGNED(D_1377);
      -- Test BITREV algorithm
      if (
          (D_1377_v /= D_1377_ref)
      ) then
        Passed := '0';
        write(Bufline, string'("BITREV error: inp="));
        hwrite(Bufline, STD_LOGIC_VECTOR(inp));
        write(Bufline, string'(" D_1377="));
        hwrite(Bufline, STD_LOGIC_VECTOR(D_1377_v));
        write(Bufline, string'(" D_1377_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(D_1377_ref));
        writeline(ResultsFile, Bufline);
      else
        write(Bufline, string'(" inp="));
        hwrite(Bufline, STD_LOGIC_VECTOR(inp));
        write(Bufline, string'(" D_1377="));
        hwrite(Bufline, STD_LOGIC_VECTOR(D_1377));
        write(Bufline, string'(" D_1377_ref="));
        hwrite(Bufline, STD_LOGIC_VECTOR(D_1377_ref));
        writeline(ResultsFile, Bufline);
        ncycles_v := ncycles;
        write(Bufline, string'("BITREV OK: Number of cycles="));
        write(Bufline, ncycles_v);
        writeline(ResultsFile, Bufline);
      end if;
      if (ntests_v = ntests_max) then
        exit;
      end if;
      ntests_v := ntests_v + 1;
    end loop;
    if (Passed = '1') then
      write(Bufline, string'("BITREV algorithm test has passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "NONE. End simulation time reached"
        severity failure;
    else
      write(Bufline, string'("BITREV algorithm test has not passed"));
      writeline(ResultsFile, Bufline);
      -- Automatic end of the current simulation.
      assert false
        report "ERRORS. End simulation time reached"
        severity failure;
    end if;
    wait for CLK_PERIOD;
  end process BITREV_BENCH;

end tb_arch;