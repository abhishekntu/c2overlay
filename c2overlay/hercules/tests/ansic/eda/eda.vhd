-- File automatically generated by "cdfg2hdl".
-- Filename: eda.vhd
-- Date: 24 October 2013 11:46:51 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE;
use WORK.operpack.all;
use WORK.eda_cdt_pkg.all;
use WORK.std_logic_1164_tinyadditions.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity eda is
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
end eda;

architecture fsmd of eda is
  type state_type is (S_ENTRY, S_EXIT, 