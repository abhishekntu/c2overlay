-- File automatically generated by "nac2cdfg".
-- Filename: sierpinski_cdt_pkg.vhd
-- Date: 12 October 2013 02:00:24 PM
-- Author: Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013

library IEEE;
use IEEE.std_logic_1164.all;

package sierpinski_cdt_pkg is

  type cdt000_type is array (1023 downto 0) of std_logic_vector(31 downto 0);
  subtype table_type is cdt000_type;

end sierpinski_cdt_pkg;