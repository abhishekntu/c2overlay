------------------------------------------------------------------------------
-- "std_logic_1164_additions" package contains the additions to the standard
-- "std_logic_1164" package proposed by the VHDL-200X-ft working group.
-- This package should be compiled into "ieee_proposed" and used as follows:
-- use ieee.std_logic_1164.all;
-- use ieee_proposed.std_logic_1164_additions.all;
-- Last Modified: $Date: 2007-09-11 14:52:13-04 $
-- RCS ID: $Id: std_logic_1164_additions.vhdl,v 1.12 2007-09-11 14:52:13-04 l435385 Exp $
--
--  Created for VHDL-200X par, David Bishop (dbishop@vhdl.org)
--  Added "count_tokens" (Nikolaos Kavvadias, nikolaos.kavvadias@gmail.com)
--  on 24-May-2011.
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

package std_logic_1164_tinyadditions is

  -- NOTE that in the new std_logic_1164, STD_LOGIC_VECTOR is a resolved
  -- subtype of STD_ULOGIC_VECTOR.  Thus there is no need for functions which
  -- take inputs in STD_LOGIC_VECTOR.
  -- For compatability with VHDL-2002, I have replicated all of these funcitons
  -- here for STD_LOGIC_VECTOR.

--  function TO_01 (s : STD_ULOGIC_VECTOR; xmap : STD_ULOGIC := '0')
--    return STD_ULOGIC_VECTOR;
--  function TO_01 (s : STD_ULOGIC; xmap : STD_ULOGIC := '0')
--    return STD_ULOGIC;
--  function TO_01 (s : BIT_VECTOR; xmap : STD_ULOGIC := '0')
--    return STD_ULOGIC_VECTOR;
--  function TO_01 (s : BIT; xmap : STD_ULOGIC := '0')
--    return STD_ULOGIC;

  -- rtl_synthesis off
-- pragma synthesis_off
  function To_StdULogicVector (s : STD_LOGIC_VECTOR) return STD_ULOGIC_VECTOR;
  alias To_Std_ULogic_Vector is
    To_StdULogicVector[STD_LOGIC_VECTOR return STD_ULOGIC_VECTOR];
  alias To_SUV is
    To_StdULogicVector[STD_LOGIC_VECTOR return STD_ULOGIC_VECTOR];

    function to_string (value : STD_ULOGIC) return STRING;
  function to_string (value : STD_ULOGIC_VECTOR) return STRING;
  function to_string (value : STD_LOGIC_VECTOR) return STRING;

  -- explicitly defined operations
  alias TO_BSTRING is TO_STRING [STD_ULOGIC_VECTOR return STRING];
  alias TO_BINARY_STRING is TO_STRING [STD_ULOGIC_VECTOR return STRING];
  function TO_HSTRING (VALUE : STD_ULOGIC_VECTOR) return STRING;
  alias TO_HEX_STRING is TO_HSTRING [STD_ULOGIC_VECTOR return STRING];
  --
  alias TO_BSTRING is TO_STRING [STD_LOGIC_VECTOR return STRING];
  alias TO_BINARY_STRING is TO_STRING [STD_LOGIC_VECTOR return STRING];
  function TO_HSTRING (VALUE : STD_LOGIC_VECTOR) return STRING;
  alias TO_HEX_STRING is TO_HSTRING [STD_LOGIC_VECTOR return STRING];
  
  -- Count tokens in a LINE
  procedure count_tokens(variable l : inout line; count : out integer);
  -- rtl_synthesis on
-- pragma synthesis_on
end package std_logic_1164_tinyadditions;

package body std_logic_1164_tinyadditions is

  -- The following functions are implicit in 1076-2006
  -- truth table for "?=" function
--  constant match_logic_table : stdlogic_table := (
--    -----------------------------------------------------
--    -- U    X    0    1    Z    W    L    H    -         |   |  
--    -----------------------------------------------------
--    ('U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', '1'),  -- | U |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1'),  -- | X |
--    ('U', 'X', '1', '0', 'X', 'X', '1', '0', '1'),  -- | 0 |
--    ('U', 'X', '0', '1', 'X', 'X', '0', '1', '1'),  -- | 1 |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1'),  -- | Z |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '1'),  -- | W |
--    ('U', 'X', '1', '0', 'X', 'X', '1', '0', '1'),  -- | L |
--    ('U', 'X', '0', '1', 'X', 'X', '0', '1', '1'),  -- | H |
--    ('1', '1', '1', '1', '1', '1', '1', '1', '1')   -- | - |
--    );

--  constant no_match_logic_table : stdlogic_table := (
--    -----------------------------------------------------
--    -- U    X    0    1    Z    W    L    H    -         |   |  
--    -----------------------------------------------------
--    ('U', 'U', 'U', 'U', 'U', 'U', 'U', 'U', '0'),  -- | U |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '0'),  -- | X |
--    ('U', 'X', '0', '1', 'X', 'X', '0', '1', '0'),  -- | 0 |
--    ('U', 'X', '1', '0', 'X', 'X', '1', '0', '0'),  -- | 1 |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '0'),  -- | Z |
--    ('U', 'X', 'X', 'X', 'X', 'X', 'X', 'X', '0'),  -- | W |
--    ('U', 'X', '0', '1', 'X', 'X', '0', '1', '0'),  -- | L |
--    ('U', 'X', '1', '0', 'X', 'X', '1', '0', '0'),  -- | H |
--    ('0', '0', '0', '0', '0', '0', '0', '0', '0')   -- | - |
--    );

  -- rtl_synthesis off
-- pragma synthesis_off
  -----------------------------------------------------------------------------
  -- This section copied from "std_logic_textio"
  -----------------------------------------------------------------------------
  -- Type and constant definitions used to map STD_ULOGIC values 
  -- into/from character values.
  type MVL9plus is ('U', 'X', '0', '1', 'Z', 'W', 'L', 'H', '-', error);
  type char_indexed_by_MVL9 is array (STD_ULOGIC) of CHARACTER;
  type MVL9_indexed_by_char is array (CHARACTER) of STD_ULOGIC;
  type MVL9plus_indexed_by_char is array (CHARACTER) of MVL9plus;
  constant MVL9_to_char : char_indexed_by_MVL9 := "UX01ZWLH-";
  constant char_to_MVL9 : MVL9_indexed_by_char :=
    ('U' => 'U', 'X' => 'X', '0' => '0', '1' => '1', 'Z' => 'Z',
     'W' => 'W', 'L' => 'L', 'H' => 'H', '-' => '-', others => 'U');
  constant char_to_MVL9plus : MVL9plus_indexed_by_char :=
    ('U' => 'U', 'X' => 'X', '0' => '0', '1' => '1', 'Z' => 'Z',
     'W' => 'W', 'L' => 'L', 'H' => 'H', '-' => '-', others => error);
  constant NBSP : CHARACTER      := CHARACTER'val(160);  -- space character
  constant NUS  : STRING(2 to 1) := (others => ' ');     -- null STRING

  -----------------------------------------------------------------------------
  -- New string functions for vhdl-200x fast track
  -----------------------------------------------------------------------------
  function to_string (value     : STD_ULOGIC) return STRING is
    variable result : STRING (1 to 1);
  begin
    result (1) := MVL9_to_char (value);
    return result;
  end function to_string;
  -------------------------------------------------------------------    
  -- TO_STRING (an alias called "to_bstring" is provide)
  -------------------------------------------------------------------   
  function to_string (value     : STD_ULOGIC_VECTOR) return STRING is
    alias ivalue    : STD_ULOGIC_VECTOR(1 to value'length) is value;
    variable result : STRING(1 to value'length);
  begin
    if value'length < 1 then
      return NUS;
    else
      for i in ivalue'range loop
        result(i) := MVL9_to_char(iValue(i));
      end loop;
      return result;
    end if;
  end function to_string;

  -------------------------------------------------------------------    
  -- TO_HSTRING
  -------------------------------------------------------------------   
  function to_hstring (value     : STD_ULOGIC_VECTOR) return STRING is
    constant ne     : INTEGER := (value'length+3)/4;
    variable pad    : STD_ULOGIC_VECTOR(0 to (ne*4 - value'length) - 1);
    variable ivalue : STD_ULOGIC_VECTOR(0 to ne*4 - 1);
    variable result : STRING(1 to ne);
    variable quad   : STD_ULOGIC_VECTOR(0 to 3);
  begin
    if value'length < 1 then
      return NUS;
    else
      if value (value'left) = 'Z' then
        pad := (others => 'Z');
      else
        pad := (others => '0');
      end if;
      ivalue := pad & value;
      for i in 0 to ne-1 loop
        quad := To_X01Z(ivalue(4*i to 4*i+3));
        case quad is
          when x"0"   => result(i+1) := '0';
          when x"1"   => result(i+1) := '1';
          when x"2"   => result(i+1) := '2';
          when x"3"   => result(i+1) := '3';
          when x"4"   => result(i+1) := '4';
          when x"5"   => result(i+1) := '5';
          when x"6"   => result(i+1) := '6';
          when x"7"   => result(i+1) := '7';
          when x"8"   => result(i+1) := '8';
          when x"9"   => result(i+1) := '9';
          when x"A"   => result(i+1) := 'A';
          when x"B"   => result(i+1) := 'B';
          when x"C"   => result(i+1) := 'C';
          when x"D"   => result(i+1) := 'D';
          when x"E"   => result(i+1) := 'E';
          when x"F"   => result(i+1) := 'F';
          when "ZZZZ" => result(i+1) := 'Z';
          when others => result(i+1) := 'X';
        end case;
      end loop;
      return result;
    end if;
  end function to_hstring;

  function to_string (value     : STD_LOGIC_VECTOR) return STRING is
  begin
    return to_string (to_stdulogicvector (value));
  end function to_string;

  function to_hstring (value     : STD_LOGIC_VECTOR) return STRING is
  begin
    return to_hstring (to_stdulogicvector (value));
  end function to_hstring;
  
  function To_StdULogicVector (s : STD_LOGIC_VECTOR) return STD_ULOGIC_VECTOR is
    alias sv        : STD_LOGIC_VECTOR (s'length-1 downto 0) is s;
    variable result : STD_ULOGIC_VECTOR (s'length-1 downto 0);
  begin
    for i in result'range loop
      result(i) := sv(i);
    end loop;
    return result;
  end function To_StdULogicVector;  

  procedure count_tokens(variable l : inout line; count : out integer) is
    variable i: integer;
    variable j: integer := 0;
    variable c: character;    
    variable is_string: boolean;    
  begin
    for i in l'range loop
      read(l, c, is_string);
      if (c = ' ') then
        j := j + 1;
      end if;
      if not is_string then -- found end of line
        exit;
      end if;   
    end loop; 
    count := j;
  end count_tokens; 
  
  -- rtl_synthesis on
-- pragma synthesis_on

end std_logic_1164_tinyadditions;
