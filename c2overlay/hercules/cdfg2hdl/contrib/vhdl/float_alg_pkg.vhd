-- --------------------------------------------------------------------
-- Title      : float_alg_pkg.vhd
-- These are the algorithemic functions.  In this package you will find
-- routines for doing complex arithmetic and basic Trig functions.  These
-- functions are not optimized, and are placed here as examples.  In the
-- future, a new complex number format will be used and placed into the
-- floating point packages.  The names of the routines have been changed
-- from "fp_*" to "fpalg_*" so that there will be no name space violations.
-- Last Modified: $Date: 2011/01/26 16:06:55 $
-- RCS ID: $Id: float_alg_pkg.vhdl,v 2.0 2011/01/26 16:06:55 l435385 Exp l435385 $
--
--  Created for VHDL-200X-ft, David Bishop (dbishop@vhdl.org) 
-- ---------------------------------------------------------------------------
--library ieee, ieee_proposed;
library ieee, WORK;
use ieee.std_logic_1164.all;
use IEEE.math_real.all;
--use WORK.math_real_custom.all;
--use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
--use ieee_proposed.float_pkg.all;
use WORK.fixed_float_types.all;
use WORK.fixed_pkg.all;
use WORK.float_pkg.all;

package float_alg_pkg is
  -- This differed constant will tell you if the package body is synthesizable
  -- or implimented as real numbers.
  constant fpalgsynth_or_real : BOOLEAN;  -- differed constant

  -- Used to generate the constants.
  type gen_number_type is (pi, half_pi, e, log2x, onef, mone, twof);
  function gen_number (
    arg                     : gen_number_type;
    constant exponent_width : NATURAL    := float_exponent_width;  -- length of FP output exponent
    constant fraction_width : NATURAL    := float_fraction_width;  -- length of FP output fraction
    constant round_style    : round_type := float_round_style)  -- rounding option
    return float;

  -- Rounds to a given precision.  "places" is the number of bits to round to.
  function precision (
    arg                  : float;
    constant places      : NATURAL;
    constant round_style : round_type := float_round_style)
    return float;

  -- largest integer not greater than arg
  function floor (
    arg : float)
    return float;

  -- largest integer not less than arg
  function ceil (
    arg : float)
    return float;

  -- Newton-Raphson divide (uses a loop to do division)
  function nr_divide (
    l, r                 : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- Newton-Raphson reciprocal (uses a loop to do division)
  function nr_reciprocal (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- Cube root.  X^(1/3)
  function cbrt (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float;

  -- 1/X^(1/2) (less logic than a SQRT function)
  function inverse_sqrt (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- returns e^arg
  function exp (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- returns ln(arg)/ln(base)
  function log (
    arg                  : float;       -- floating point input
    base                 : POSITIVE;    -- Log of a positive number
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- returns ln(arg)/ln(base)
  function log (
    arg                  : float;       -- floating point input
    base                 : float;       -- Log of a positive number
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- returns l^r
  function power_of (
    l, r                 : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float;

  -- returns l^r
  function power_of (
    l                    : float;       -- floating point input
    r                    : INTEGER;     -- Integer input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float;

  -- returns ln(arg)
  function ln (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function "**" (
    l, r : float)                       -- floating point input
    return float;

  function "**" (
    l : float;                          -- floating point input
    r : INTEGER)
    return float;

  -----------------------------------------------------------------------------
  -- Angle functions
  -- sine, cosine, tangent, arc_sine, arc_cosine, arc_tangent
  function sin (
    arg                  : float;                -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)  -- Bounded by 0 to 2PI
    return float;

  function cos (
    arg                  : float;                -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)  -- Bounded by 0 to 2PI
    return float;

  function tan (
    arg                  : float;                -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)  -- Bounded by 0 to 2PI
    return float;

  function arcsin (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function arccos (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function arctan (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  -- Hyperbolic functions.
  function sinh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function cosh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function tanh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function coth (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function sech (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function csch (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function arcsinh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function arccosh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

  function arctanh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float;

end package float_alg_pkg;

-- --------------------------------------------------------------------
-- Title      : "float_alg_pkg" alternate body, using REAL to compute
-- This are algorithimic functions, which are here as examples of how
-- to implement such things.
-- Last Modified: $Date: 2011/01/26 16:05:47 $
-- RCS ID: $Id: float_alg_pkg-body_real.vhdl,v 2.0 2011/01/26 16:05:47 l435385 Exp l435385 $
--
--  Created for VHDL-200X-ft, David Bishop (dbishop@vhdl.org) 
-- ---------------------------------------------------------------------------
library ieee;
use ieee.math_real.all;
--use WORK.math_real_custom.all;
package body float_alg_pkg is

  -- Set to "true" if synthesizable, "false" if done with real numbers
  constant fpalgsynth_or_real : BOOLEAN := false;  -- differed constant

  -----------------------------------------------------------------------------
  -- Constants needed for some algorithms.
  -----------------------------------------------------------------------------
  -- type gen_number_type is (pi, half_pi, e, log2x, onef, mone, twof);
  function gen_number (
    arg                     : gen_number_type;
    constant exponent_width : NATURAL    := float_exponent_width;  -- length of FP output exponent
    constant fraction_width : NATURAL    := float_fraction_width;  -- length of FP output fraction
    constant round_style    : round_type := float_round_style)  -- rounding option
    return float is
    variable fpresult : float (exponent_width downto -fraction_width);

  begin
    gencase : case arg is
      when pi =>
        fpresult := to_float (arg            => MATH_PI,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when half_pi =>
        fpresult := to_float (arg            => MATH_PI_OVER_2,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when e =>
        fpresult := to_float (arg            => MATH_E,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when log2x =>
        fpresult := to_float (arg            => MATH_LOG_OF_2,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when onef =>                      -- 1.0
        fpresult := to_float (arg            => 1,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when mone =>                      -- -1
        fpresult := to_float (arg            => -1,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
      when twof =>                      -- 2.0
        fpresult := to_float (arg            => 2,
                              exponent_width => exponent_width,
                              fraction_width => fraction_width,
                              round_style    => round_style);
    end case;
    return fpresult;
  end function gen_number;

  -- Rounds to a given precision.  "places" is the number of bits to round to.
  function precision (
    arg                  : float;
    constant places      : NATURAL;
    constant round_style : round_type := float_round_style)
    return float is
    variable argx : float (arg'high downto -places);
  begin
    argx := resize (arg            => arg,
                    exponent_width => arg'high,
                    fraction_width => places,
                    round_style    => round_style);
    return resize (arg            => argx,
                   exponent_width => arg'high,
                   fraction_width => -arg'low);
  end function precision;

  -- largest integer not greater than arg
  function floor (
    arg : float)
    return float is
    variable arg_real : REAL;
    variable result   : float (arg'range);
  begin
    arg_real := floor (to_real(arg));
    result := to_float (arg            => arg_real,
                        exponent_width => result'high,
                        fraction_width => -result'low);
    return result;
  end function floor;

  -- largest integer not less than arg
  function ceil (
    arg : float)
    return float is
    variable arg_real : REAL;
    variable result   : float (arg'range);
  begin
    arg_real := ceil (to_real(arg));
    result := to_float (arg            => arg_real,
                        exponent_width => result'high,
                        fraction_width => -result'low);
    return result;
  end function ceil;


  -- Newton-Raphson divide (uses a loop to do division)
  function nr_divide (
    l, r                 : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width : NATURAL := -l'low;  -- length of FP output fraction
    constant exponent_width : NATURAL := l'high;  -- length of FP output exponent
    variable l_real, r_real : REAL;
  begin
    l_real := to_real (l);
    r_real := to_real (r);
    return to_float (arg            => l_real / r_real,
                     fraction_width => fraction_width,
                     exponent_width => exponent_width,
                     round_style    => round_style,
                     denormalize    => denormalize);  
  end function nr_divide;

  -- Newton-Raphson reciprocal (uses a loop to do division)
  function nr_reciprocal (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is

    constant fraction_width : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width : NATURAL := arg'high;  -- length of FP output exponent
    variable fptype         : valid_fpstate;
    variable fpresult       : float (arg'range);
    variable arg_real       : REAL;
  begin  -- reciprocal
    fptype := classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>
        -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf | neg_inf =>         -- 1/inf, return 0
        fpresult := zerofp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when neg_zero | pos_zero =>       -- 1/0
        report "FLOAT_GENERIC_PKG.RECIPROCAL: Floating Point divide by zero"
          severity error;
        fpresult := pos_inffp (fraction_width => fraction_width,
                               exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg);
        fpresult := to_float (arg            => 1.0/ arg_real,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);      
    end case classcase;
    return fpresult;
  end function nr_reciprocal;

  -- purpose: 1/ sqrt (x)
  function inverse_sqrt (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- Real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan |
        -- Return quiet NAN, IEEE754-1985-7.1,1
        neg_normal | neg_denormal | neg_inf |         -- sqrt (neg)
        -- Return quiet NAN, IEEE754-1985-7.1.6
        pos_zero | neg_zero =>          -- 1/sqrt(0)
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>                   -- 1/Sqrt (inf), return infinity
        fpresult := zerofp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := 1.0/sqrt (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function inverse_sqrt;

  function cbrt (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- Real versions
    variable fptype           : valid_fpstate;
    variable fpresult         : float (arg'range);
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>
        -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf | neg_inf =>         -- (infinity), return infinity
        fpresult := pos_inffp (fraction_width => fraction_width,
                               exponent_width => exponent_width);
      when pos_zero | neg_zero =>       -- return 0.0
        fpresult := zerofp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := cbrt(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function cbrt;

  function exp (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- Real versions
    variable fptype           : valid_fpstate;
    variable fpresult         : float (arg'range);
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>
        -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>                   -- (e**inf), return infinity
        fpresult := pos_inffp (fraction_width => fraction_width,
                               exponent_width => exponent_width);
      when neg_inf =>                   -- (e**-inf), return zero
        fpresult := zerofp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_zero | neg_zero =>       -- return 1.0
        fpresult := to_float (arg            => 1,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := exp(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function exp;
  
  function log (
    arg                  : float;       -- floating point input
    base                 : POSITIVE;    -- Log of a positive number
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width : NATURAL := arg'high;  -- length of FP output exponent
    variable lnbase         : float (arg'range);
    variable fpresult       : float (arg'range);
  begin
    lnbase := to_float (arg            => base,
                        fraction_width => fraction_width,
                        exponent_width => exponent_width,
                        round_style    => round_style);
    fpresult := log (arg         => arg,
                     base        => lnbase,
                     round_style => round_style,
                     guard       => guard,
                     check_error => check_error,
                     denormalize => denormalize,
                     iterations  => iterations);
    return fpresult;
  end function log;

  function log (
    arg                  : float;       -- floating point input
    base                 : float;       -- Log of a positive number
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width              : NATURAL                                       := -arg'low;  -- length of FP output fraction
    constant exponent_width              : NATURAL                                       := arg'high;  -- length of FP output exponent
    variable arg_real, base_real, result : REAL;           -- Real versions
    variable fpresult                    : float (arg'range);
    variable lfptype, rfptype            : valid_fpstate;
    constant one                         : float (exponent_width downto -fraction_width) :=
      to_float (arg            => 1,
                exponent_width => exponent_width,
                fraction_width => fraction_width);
  begin
    if (fraction_width = 0 or arg'length < 7 or base'length < 7) then
      lfptype := isx;
    else
      lfptype := Classfp (arg, check_error);
      rfptype := Classfp (base, check_error);
    end if;
    if (lfptype = isx or rfptype = isx) then
      fpresult := (others => 'X');
      -- Return quiet NAN, IEEE754-1985-7.1,1
    elsif (lfptype = nan or lfptype = quiet_nan or
           rfptype = nan or rfptype = quiet_nan or
           -- Log (-1) = NAN
           lfptype = neg_normal or lfptype = neg_denormal or
           rfptype = neg_normal or rfptype = neg_denormal or
           rfptype = neg_inf or lfptype = neg_inf)   then
      -- Return quiet NAN, IEEE754-1985-7.1,2
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (lfptype = pos_zero or lfptype = neg_zero) then  -- log(0) = -inf
      fpresult := neg_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    elsif (rfptype = pos_zero or rfptype = neg_zero) then  -- log0(X) = 0
      fpresult := zerofp (fraction_width => fraction_width,
                          exponent_width => exponent_width);      
    elsif (lfptype = pos_inf) then      -- log (inf) = inf
      fpresult := pos_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    elsif (rfptype = pos_inf) then      -- log inf(x) = zero
      fpresult := zerofp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (arg = one) then              -- log (1) = 0
      fpresult := zerofp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (base = one) then             -- log1(X) = +inf
      fpresult := pos_inffp (fraction_width => fraction_width,
                             exponent_width => exponent_width);
    elsif (arg = base) then
      fpresult := one;
    else
      arg_real := to_real (arg         => arg,
                           denormalize => denormalize);
      base_real := to_real (arg         => base,
                            denormalize => denormalize);
      result := log (arg_real) / log (base_real);
      fpresult := to_float (arg            => result,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width,
                            round_style    => round_style,
                            denormalize    => denormalize);
    end if;
    return fpresult;
  end function log;
  
  function power_of (
    l, r                 : float;       -- floating point input
    constant round_style : round_type := round_nearest;   -- rounding option
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float is
    constant fraction_width         : NATURAL := -l'low;  -- length of FP output fraction
    constant exponent_width         : NATURAL := l'high;  -- length of FP output exponent
    variable r_real, l_real, result : REAL;               -- Real versions
    variable lfptype, rfptype       : valid_fpstate;
    variable fpresult               : float (l'range);
  begin
    assert (l'length = r'length and r'high = l'high)
      report "FPHDL_BASE_PKG.POWER_OF: Dimensions of arguments do not match"
      severity error;
    lfptype := Classfp (l, check_error);
    rfptype := Classfp (r, check_error);
    l_real := to_real (arg         => l,
                       denormalize => denormalize);
    if (lfptype = isx or rfptype = isx) then
      fpresult := (others => 'X');
    elsif (lfptype = nan or lfptype = quiet_nan or
           rfptype = nan or rfptype = quiet_nan) then
      -- Return quiet NAN, IEEE754-1985-7.1,1
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (lfptype = pos_zero or lfptype = neg_zero) or   -- 0**X = 0
      (lfptype = pos_Inf and            -- inf**-real = 0
       (rfptype = neg_inf or rfptype = neg_normal or
        rfptype = neg_denormal)) then
      -- return 0
      fpresult := zerofp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (rfptype = pos_zero or rfptype = neg_zero) then  -- X**0 = 1
      -- return 1
      fpresult := to_float (arg            => 1,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width);
    elsif (rfptype = pos_inf or rfptype = neg_inf) then   -- X**inf
      if l_real = 1.0 then
        fpresult := to_float (arg            => 1,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width);
      elsif l_real > 1.0 then
        if (rfptype = neg_inf) then
          -- return 0
          fpresult := zerofp (fraction_width => fraction_width,
                              exponent_width => exponent_width);
        else
          fpresult := pos_inffp (fraction_width => fraction_width,
                                 exponent_width => exponent_width);
        end if;
      else
        if (rfptype = pos_inf) then
          -- return 0
          fpresult := zerofp (fraction_width => fraction_width,
                              exponent_width => exponent_width);
        else
          fpresult := pos_inffp (fraction_width => fraction_width,
                                 exponent_width => exponent_width);
        end if;
      end if;
    else
      r_real := to_real (arg         => r,
                         denormalize => denormalize);
      result := l_real ** r_real;
      fpresult := to_float (arg            => result,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width,
                            round_style    => round_style,
                            denormalize    => denormalize);
    end if;
    return fpresult;
  end function power_of;

  function power_of (
    l                    : float;       -- floating point input
    r                    : INTEGER;     -- Integer input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize)
    return float is
    variable r_fp     : float (l'range);
    variable fpresult : float (l'range);
  begin
    r_fp := to_float (arg            => r,
                      exponent_width => l'high,
                      fraction_width => -l'low,
                      round_style    => round_style);
    fpresult := power_of (l           => l,
                          r           => r_fp,
                          round_style => round_style,
                          check_error => check_error,
                          denormalize => denormalize);
    return fpresult;
  end function power_of;

  function ln (
    arg                  : float;       -- floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- Real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when neg_normal | neg_denormal | neg_inf =>     -- log (neg)
        -- Return quiet NAN, IEEE754-1985-7.1,5*
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>                   -- log (inf), return infinity
        fpresult := pos_inffp (fraction_width => fraction_width,
                               exponent_width => exponent_width);
      when pos_zero | neg_zero =>       -- log (0), return negative infinity
        fpresult := neg_inffp (fraction_width => fraction_width,
                               exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := log (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function ln;

  function "**" (
    l, r : float)                       -- floating point input
    return float is
  begin
    return power_of (l => l,
                     r => r);
  end function "**";

  function "**" (
    l : float;                          -- floating point input
    r : INTEGER)
    return float is
  begin
    return power_of (l => l,
                     r => r);
  end function "**";
  -----------------------------------------------------------------------------
  -- Angle functions
  -- sine, cosine, tangent, arc_sine, arc_cosine, arc_tangent
  function sin (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)       -- Bounded by 0 to 2PI
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf | neg_inf =>
        -- sine (inf), return nan
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := sin (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function sin;

  function cos (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)       -- Bounded by 0 to 2PI
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf | neg_inf =>
        -- sine (inf), return nan
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := cos (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function cos;

  function tan (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant bounded     : BOOLEAN    := false)       -- Bounded by 0 to 2PI
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan |            -- Return quiet NAN, IEEE754-1985-7.1,1
                    pos_inf | neg_inf =>              -- tan (inf), return nan
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_zero | neg_zero =>
        -- tan (0), return zero
        fpresult := zerofp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := tan (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function tan;

  function arcsin (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width : NATURAL := arg'high;  -- length of FP output exponent
    function "<" (
      l, r : float)                     -- inputs
      return BOOLEAN is
    begin  -- function "<"
      return lt (l           => l,
                 r           => r,
                 check_error => check_error);
    end function "<";
    function ">" (
      l, r : float)                     -- inputs
      return BOOLEAN is
    begin  -- function ">"
      return gt (l           => l,
                 r           => r,
                 check_error => check_error);
    end function ">";
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    if (fptype = isx) then
      fpresult := (others => 'X');
    elsif (fptype = nan or fptype = quiet_nan) then
      -- Return quiet NAN, IEEE754-1985-7.1,1
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (arg > 1) or (arg < -1) then  -- -1 < x < 1
      -- Return a NAN for any arc sin greater than 1.0
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (arg = 1) or (arg = -1) then
      result := MATH_PI_OVER_2;
      fpresult := to_float (arg            => result,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width,
                            round_style    => round_style,
                            denormalize    => denormalize);
      if (arg(arg'high) = '1') then
        fpresult(arg'high) := '1';
      end if;
    else
      arg_real := to_real (arg         => arg,
                           denormalize => denormalize);
      result := arcsin (arg_real);
      fpresult := to_float (arg            => result,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width,
                            round_style    => round_style,
                            denormalize    => denormalize);
    end if;
    return fpresult;
  end function arcsin;

  function arccos (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width : NATURAL := arg'high;  -- length of FP output exponent
    function "<" (
      l, r : float)                     -- inputs
      return BOOLEAN is
    begin  -- function "<"
      return lt (l           => l,
                 r           => r,
                 check_error => check_error);
    end function "<";
    function ">" (
      l, r : float)                     -- inputs
      return BOOLEAN is
    begin  -- function ">"
      return lt (l           => l,
                 r           => r,
                 check_error => check_error);
    end function ">";
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    if (fptype = isx) then
      fpresult := (others => 'X');
    elsif (fptype = nan or fptype = quiet_nan) then
      -- Return quiet NAN, IEEE754-1985-7.1,1
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);

    elsif (arg > 1) or (arg < -1) then  -- -1 < x < 1
      -- Return a NAN for any arc sign greater than 1.0
      fpresult := qnanfp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    elsif (arg = 1) or (arg = -1) then
      fpresult := zerofp (fraction_width => fraction_width,
                          exponent_width => exponent_width);
    else
      arg_real := to_real (arg         => arg,
                           denormalize => denormalize);
      result := arccos (arg_real);
      fpresult := to_float (arg            => result,
                            fraction_width => fraction_width,
                            exponent_width => exponent_width,
                            round_style    => round_style,
                            denormalize    => denormalize);
    end if;
    return fpresult;
  end function arccos;

  function arctan (
    arg                  : float;       -- Floating point input
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg         => arg,
                             denormalize => denormalize);
        result := arctan (arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function arctan;

  -- Hyperbolic functions.
  function sinh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := sinh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function sinh;

  function cosh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := cosh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function cosh;
  
  function tanh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := tanh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function tanh;
  
  function coth (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := cosh(arg_real) / sinh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function coth;
  
  function sech (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := 1.0/cosh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function sech;
  
  function csch (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := 1.0 / sinh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function csch;

  function arcsinh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        arg_real := to_real (arg);
        result   := arcsinh(arg_real);
        fpresult := to_float (arg            => result,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style,
                              denormalize    => denormalize);
    end case classcase;
    return fpresult;
  end function arcsinh;
  
  function arccosh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL                                       := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL                                       := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
    constant one              : float (exponent_width downto -fraction_width) :=
      to_float (arg            => 1,
                exponent_width => exponent_width,
                fraction_width => fraction_width);
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_inf =>
        fpresult := to_float (arg            => MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when neg_inf =>
        fpresult := to_float (arg            => -MATH_PI/2.0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);
      when others =>
        if not (arg > one) then
          report "float_alg_pkg.arccosh: " &
            " only works on values > 1.0 " & to_string (arg) & "(= " &
            REAL'image(to_real(arg)) & ")" severity error;
          fpresult := to_float (arg            => 0,
                                fraction_width => fraction_width,
                                exponent_width => exponent_width);
        else
          arg_real := to_real (arg);
          result   := arccosh(arg_real);
          fpresult := to_float (arg            => result,
                                fraction_width => fraction_width,
                                exponent_width => exponent_width,
                                round_style    => round_style,
                                denormalize    => denormalize);
        end if;
    end case classcase;
    return fpresult;
  end function arccosh;
  
  function arctanh (
    arg                  : float;
    constant round_style : round_type := float_round_style;
    constant guard       : NATURAL    := float_guard_bits;
    constant check_error : BOOLEAN    := float_check_error;
    constant denormalize : BOOLEAN    := float_denormalize;
    constant iterations  : NATURAL    := 0)
    return float is
    constant fraction_width   : NATURAL                                       := -arg'low;  -- length of FP output fraction
    constant exponent_width   : NATURAL                                       := arg'high;  -- length of FP output exponent
    variable arg_real, result : REAL;   -- real versions
    variable fpresult         : float (arg'range);
    variable fptype           : valid_fpstate;
    constant one              : float (exponent_width downto -fraction_width) :=
      to_float (arg            => 1,
                exponent_width => exponent_width,
                fraction_width => fraction_width);
  begin
    fptype := Classfp(arg, check_error);
    classcase : case fptype is
      when isx =>
        fpresult := (others => 'X');
      when nan | quiet_nan =>           -- Return quiet NAN, IEEE754-1985-7.1,1
        fpresult := qnanfp (fraction_width => fraction_width,
                            exponent_width => exponent_width);
      when pos_zero | neg_zero =>
        fpresult := to_float (arg            => 0,
                              fraction_width => fraction_width,
                              exponent_width => exponent_width,
                              round_style    => round_style);

      when others =>
        if arg >= 1 or arg <= -1 then
          report float_alg_pkg'instance_name & "arctanh :" &
            " value out of range 1.0 to -1.0 " & to_string (arg) & " (= " &
            REAL'image(to_real(arg)) & ")"
            severity error;
          if arg >= one then
            fpresult := pos_inffp (fraction_width => fraction_width,
                                   exponent_width => exponent_width);
          else
            fpresult := neg_inffp (fraction_width => fraction_width,
                                   exponent_width => exponent_width);
          end if;
        else
          arg_real := to_real (arg);
          result   := arctanh(arg_real);
          fpresult := to_float (arg            => result,
                                fraction_width => fraction_width,
                                exponent_width => exponent_width,
                                round_style    => round_style,
                                denormalize    => denormalize);
        end if;
    end case classcase;
    return fpresult;
  end function arctanh;

end package body float_alg_pkg;
