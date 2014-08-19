--
-- File    : misc_pkg.vhd
-- Purpose : VHDL package with some useful functions.
-- Date    : 10-Aug-2009
-- Author  : Nikolaos Kavvadias (C) 2002, 2003, 2004, 2005, 2006, 2007, 2008, 
--           2009.
-- Comments:
-- Revision History:
-- 14/02/02: Initial version.
-- 26/04/02: Added LOG2 function proposed by Ray Andraka.
-- 26/04/02: Not correct (rounds at +1 int), corrected by Nick Kavvadias.
-- 26/04/02: LOGN function proposed by Nick Kavvadias.
-- 27/04/02: int_to_str, hex_str_to_int, Shrink_line functs/procs
--           added. Originally proposed in various LPM codes (of Altera).
-- 10/05/02: bin_str_to_int added for ROM Memory "Initialization".
-- ??/??/??: int_to_str, hex_str_to_int, Shrink_line, bin_str_to_int
--           removed.
-- 10/08/09: Renamed to "misc_pkg.vhd". 
--

library IEEE;
use IEEE.std_logic_1164.all;


package misc_pkg is
  function LOG2F(input: INTEGER) return INTEGER;
  function LOG2C(input: INTEGER) return INTEGER;
  function LOG2CTAB(input: INTEGER) return INTEGER;
  function NUMBITS(input: INTEGER) return INTEGER;
  function LOGNF(input: INTEGER; N: INTEGER) return INTEGER;
  function LOGNC(input: INTEGER; N: INTEGER) return INTEGER;
end misc_pkg;


package body misc_pkg is

  ----------------------------------------------------------------------------
  -- Base-2 logarithm function (LOG2F(x)) [rounds to floor]
  ----------------------------------------------------------------------------
  function LOG2F(input: INTEGER) return INTEGER is
    variable temp,log: INTEGER;
    begin
      temp := input;
      log := 0;
      while (temp > 1) loop
        temp := temp/2;
        log := log+1;
      end loop;
    return log;
  end function LOG2F;

----------------------------------------------------------------------------
-- Base-2 logarithm function (LOG2C(x)) [rounds to ceiling]
-- Adopted from Reto Zimmermann's "arith_lib" (was: log2ceil)
----------------------------------------------------------------------------
  function LOG2C(input: INTEGER) return INTEGER is
    variable temp,log: INTEGER;
    begin
      log := 0;
      temp := 1;
      for i in 0 to input loop
        if temp < input then
          log := log + 1;
          temp := temp * 2;
        end if;
      end loop;
    return (log);
  end function LOG2C;

  function LOG2CTAB(input: INTEGER) return INTEGER is
    variable log: INTEGER;
    begin
      case input is 
        when  0 to   1 => log := 0;
        when  2        => log := 1;
        when  3 to   4 => log := 2;
        when  5 to   8 => log := 3;
        when  9 to  16 => log := 4;
        when 17 to  32 => log := 5;
        when 33 to  64 => log := 6;
        when 65 to 128 => log := 7;
        when others    => log := 0;
      end case;
    return (log);
  end function LOG2CTAB;

  function NUMBITS(input: INTEGER) return INTEGER is
    variable temp   : INTEGER := input;
    variable result : INTEGER := 1;
    begin
      loop
        temp := temp/2;
        exit when temp = 0;
        result := result + 1;
      end loop;
    return result;
  end NUMBITS;

  ----------------------------------------------------------------------------
  -- Base-N logarithm function (LOGNF(x,N)) [rounds to floor]
  ----------------------------------------------------------------------------
  function LOGNF(input: INTEGER; N: INTEGER) return INTEGER is
    variable temp,log: INTEGER;
    begin
      temp := input;
      log := 0;
      while (temp >= N) loop
        temp := temp / N;
        log := log + 1;
      end loop;
    return log;
  end function LOGNF;

  ----------------------------------------------------------------------------
  -- Base-N logarithm function (LOGNC(x,N)) [rounds to ceiling]
  ----------------------------------------------------------------------------
  function LOGNC(input: INTEGER; N: INTEGER) return INTEGER is
    variable temp,log: INTEGER;
    begin
      temp := 1;
      log := 0;
      for i in 0 to input-1 loop
        exit when temp >= input;
        log := log + 1;
        temp := temp * N;
      end loop;
    return log;
  end function LOGNC;

end misc_pkg;

--
-- "The more i want something done, the less i call it work."
-- Richard Bach
--
