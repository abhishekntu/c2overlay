--------------------------------------------------------------------------------
-- Filename: operpack_ieee.vhd
-- Purpose : Package for various arithmetic operators:
--           * Variable shifter (left shift unsigned, left shift signed, right 
--             shift unsigned, right shift signed)
--           * Multipliers (mul, smul, umul)
--           * Dividers and modulo extractors (divqr, divq, divr, divm)
--           * Bit manipulation operators (bitinsert, bitextract)
--             
-- Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012
-- Date    : 20-Jul-2012
-- Revision: 0.0.0 (03/10/09)
--           Initial version.
--           0.2.0 (12/10/09)
--           Added mul, umul, smul operators.
--           0.3.0 (22/01/10)
--           Added divqr, divq, divr operators.
--           0.3.1 (20/07/10)
--           All input procedure parameters are not necessarily of the signal 
--           type.
--           0.3.2 (14/10/10)
--           Spin-off of file "operpack.vhd". Supports the "real" IEEE standard
--           libraries (numeric_std).
--           0.3.3 (01/05/11)
--           Added bitinsert, bitextract operators.
--           0.4.9 (25/02/12)
--           Added support for shrv6, shlv6 (64-bit quantities).
--           0.4.10 (20/07/12)
--           Added support for divm (mod), fixes for log2c.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


package operpack is 
  
  function log2f (arg : integer) return integer;
  function log2c (arg : integer) return integer;
  function shrv (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv1 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv2 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv3 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv4 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv5 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv6 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shlv (a, b : std_logic_vector) return std_logic_vector;
  function shlv1 (a, b : std_logic_vector) return std_logic_vector;
  function shlv2 (a, b : std_logic_vector) return std_logic_vector;
  function shlv3 (a, b : std_logic_vector) return std_logic_vector;
  function shlv4 (a, b : std_logic_vector) return std_logic_vector;
  function shlv5 (a, b : std_logic_vector) return std_logic_vector;
  function shlv6 (a, b : std_logic_vector) return std_logic_vector;
  function mul (a, b : std_logic_vector ; mode : std_logic ; trunc_val : integer) return std_logic_vector;
  function umul (a, b : std_logic_vector ; trunc_val : integer) return std_logic_vector;
  function smul (a, b : std_logic_vector ; trunc_val : integer) return std_logic_vector;
  procedure divqr (a, b : in std_logic_vector; mode : in std_logic; signal q, r : out std_logic_vector);
  procedure divq (a, b : in std_logic_vector; mode : in std_logic; signal q : out std_logic_vector);
  procedure divr (a, b : in std_logic_vector; mode : in std_logic; signal r : out std_logic_vector);
  procedure divm (a, b : in std_logic_vector; mode : in std_logic; signal r : out std_logic_vector);
  function bitinsert (a, y0, bhi, blo : std_logic_vector) return std_logic_vector;
  function bitextract (a, bhi, blo : std_logic_vector) return std_logic_vector;  
  -- from ieee.numeric_std!
--  procedure xdivmod (num, xdenom: unsigned; xquot, xremain: out unsigned);
--  procedure xdiv (num, xdenom: unsigned; xquot: out unsigned);
--  procedure xmod (num, xdenom: unsigned; xremain: out unsigned);
  -- based on Ashenden's implementation; bit-vector equivalents for xdivmod, xdiv, xmod.
  procedure xdivmod (bv1, bv2 : in unsigned; bv_quotient : out unsigned; bv_remainder : out unsigned);
  procedure xdiv (bv1, bv2 : in unsigned; bv_quotient : out unsigned) ;
  procedure xmod (bv1, bv2 : in unsigned; bv_remainder : out unsigned) ;

  constant  ONE : std_logic_vector(0 downto 0) := "1";

end operpack;


package body operpack is

  ----------------------------------------------------------------------------
  -- Base-2 logarithm function (LOG2F(x)) [rounds to floor]
  ----------------------------------------------------------------------------
  function log2f(arg: integer) return integer is
    variable temp, log : integer;
    begin
      temp := arg;
      log := 0;
      while (temp > 1) loop
        temp := temp / 2;
        log := log + 1;
      end loop;
    return log;
  end function log2f;

  ----------------------------------------------------------------------------
  -- Base-2 logarithm function (LOG2C(x)) [rounds to ceiling]
  ----------------------------------------------------------------------------
  function log2c(arg : integer) return integer is
    variable temp    : integer := arg;
    variable ret_val : integer := 0; 
  begin					
    while temp > 1 loop
      ret_val := ret_val + 1;
      temp    := temp / 2;     
    end loop;	
    if (arg >= (2**ret_val)) then
      return(ret_val + 1); -- RetVal is too small, so bump it up by 1 and return
    else
      return(ret_val); -- Just right
    end if;
  end function log2c;  
  
  function shrv (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shiftR : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   for i in 0 to log2c(a'LENGTH)-1 loop
     if (b(i) = '1') then
       if (i = 0) then
         shiftR := fills(a'LENGTH-1 downto a'LENGTH-(2**i)) & a(a'LENGTH-1 downto 2**i);
       else
         shiftR := fills(a'LENGTH-1 downto a'LENGTH-(2**i)) & shiftR(a'LENGTH-1 downto 2**i);
       end if;
     else
       shiftR := shiftR;
     end if;
   end loop;
   return (shiftR);
  end shrv;

  function shrv1 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   return (shift1R);
  end shrv1;

  function shrv2 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R, shift2R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   if (b(1) = '1') then
     shift2R := fills(a'LENGTH-1 downto a'LENGTH-2) & shift1R(a'LENGTH-1 downto 2);
   else
     shift2R := shift1R;
   end if;
   return (shift2R);
  end shrv2;

  function shrv3 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R, shift2R, shift4R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   if (b(1) = '1') then
     shift2R := fills(a'LENGTH-1 downto a'LENGTH-2) & shift1R(a'LENGTH-1 downto 2);
   else
     shift2R := shift1R;
   end if;
   if (b(2) = '1') then
     shift4R := fills(a'LENGTH-1 downto a'LENGTH-4) & shift2R(a'LENGTH-1 downto 4);
   else
     shift4R := shift2R;
   end if;
   return (shift4R);
  end shrv3;

  function shrv4 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R, shift2R, shift4R, shift8R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   if (b(1) = '1') then
     shift2R := fills(a'LENGTH-1 downto a'LENGTH-2) & shift1R(a'LENGTH-1 downto 2);
   else
     shift2R := shift1R;
   end if;
   if (b(2) = '1') then
     shift4R := fills(a'LENGTH-1 downto a'LENGTH-4) & shift2R(a'LENGTH-1 downto 4);
   else
     shift4R := shift2R;
   end if;
   if (b(3) = '1') then
     shift8R := fills(a'LENGTH-1 downto a'LENGTH-8) & shift4R(a'LENGTH-1 downto 8);
   else
     shift8R := shift4R;
   end if;
   return (shift8R);
  end shrv4;

  function shrv5 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R, shift2R, shift4R, shift8R, shift16R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   if (b(1) = '1') then
     shift2R := fills(a'LENGTH-1 downto a'LENGTH-2) & shift1R(a'LENGTH-1 downto 2);
   else
     shift2R := shift1R;
   end if;
   if (b(2) = '1') then
     shift4R := fills(a'LENGTH-1 downto a'LENGTH-4) & shift2R(a'LENGTH-1 downto 4);
   else
     shift4R := shift2R;
   end if;
   if (b(3) = '1') then
     shift8R := fills(a'LENGTH-1 downto a'LENGTH-8) & shift4R(a'LENGTH-1 downto 8);
   else
     shift8R := shift4R;
   end if;
   if (b(4) = '1') then
     shift16R := fills(a'LENGTH-1 downto a'LENGTH-16) & shift8R(a'LENGTH-1 downto 16);
   else
     shift16R := shift8R;
   end if;
   return (shift16R);
  end shrv5;

  -- FIXME: Needs testing.
  function shrv6 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector is
    variable shift1R, shift2R, shift4R, shift8R, shift16R, shift32R : std_logic_vector(a'RANGE);
    variable fills : std_logic_vector(a'LENGTH-1 downto a'LENGTH/2);
  begin
   if (mode = '1' and a(a'LENGTH-1) = '1') then
     fills := (others => '1');
   else
     fills := (others => '0');
   end if;
   if (b(0) = '1') then
     shift1R := fills(a'LENGTH-1 downto a'LENGTH-1) & a(a'LENGTH-1 downto 1);
   else
     shift1R := a;
   end if;
   if (b(1) = '1') then
     shift2R := fills(a'LENGTH-1 downto a'LENGTH-2) & shift1R(a'LENGTH-1 downto 2);
   else
     shift2R := shift1R;
   end if;
   if (b(2) = '1') then
     shift4R := fills(a'LENGTH-1 downto a'LENGTH-4) & shift2R(a'LENGTH-1 downto 4);
   else
     shift4R := shift2R;
   end if;
   if (b(3) = '1') then
     shift8R := fills(a'LENGTH-1 downto a'LENGTH-8) & shift4R(a'LENGTH-1 downto 8);
   else
     shift8R := shift4R;
   end if;
   if (b(4) = '1') then
     shift16R := fills(a'LENGTH-1 downto a'LENGTH-16) & shift8R(a'LENGTH-1 downto 16);
   else
     shift16R := shift8R;
   end if;
   if (b(5) = '1') then
     shift32R := fills(a'LENGTH-1 downto a'LENGTH-32) & shift16R(a'LENGTH-1 downto 32);
   else
     shift32R := shift16R;
   end if;
   return (shift32R);
  end shrv6;

  function shlv (a, b : std_logic_vector) return std_logic_vector is
    variable shiftL : std_logic_vector(a'RANGE);
  begin
    for i in 0 to log2c(a'LENGTH)-1 loop
      if (b(i) = '1') then
        if (i = 0) then
          shiftL := a(a'LENGTH-2**i-1 downto 2**i) & (2**i - 1 downto 0 => '0');
        else
          shiftL := shiftL(a'LENGTH-2**i-1 downto 2**i) & (2**i - 1 downto 0 => '0');
        end if;
      else
        shiftL := shiftL;
      end if;
    end loop;
    return (shiftL);
  end shlv;
  
  function shlv1 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   return (shift1L);
  end shlv1;
  
  function shlv2 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L, shift2L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   if (b(1) = '1') then
     shift2L := shift1L(a'LENGTH-3 downto 0) & "00";
   else
     shift2L := shift1L;
   end if;
   return (shift2L);
  end shlv2;

  function shlv3 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L, shift2L, shift4L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   if (b(1) = '1') then
     shift2L := shift1L(a'LENGTH-3 downto 0) & "00";
   else
     shift2L := shift1L;
   end if;
   if (b(2) = '1') then
     shift4L := shift2L(a'LENGTH-5 downto 0) & X"0";
   else
     shift4L := shift2L;
   end if;
   return (shift4L);
  end shlv3;

  function shlv4 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L, shift2L, shift4L, shift8L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   if (b(1) = '1') then
     shift2L := shift1L(a'LENGTH-3 downto 0) & "00";
   else
     shift2L := shift1L;
   end if;
   if (b(2) = '1') then
     shift4L := shift2L(a'LENGTH-5 downto 0) & X"0";
   else
     shift4L := shift2L;
   end if;
   if (b(3) = '1') then
     shift8L := shift4L(a'LENGTH-9 downto 0) & X"00";
   else
     shift8L := shift4L;
   end if;
   return (shift8L);
  end shlv4;

  function shlv5 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L, shift2L, shift4L, shift8L, shift16L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   if (b(1) = '1') then
     shift2L := shift1L(a'LENGTH-3 downto 0) & "00";
   else
     shift2L := shift1L;
   end if;
   if (b(2) = '1') then
     shift4L := shift2L(a'LENGTH-5 downto 0) & X"0";
   else
     shift4L := shift2L;
   end if;
   if (b(3) = '1') then
     shift8L := shift4L(a'LENGTH-9 downto 0) & X"00";
   else
     shift8L := shift4L;
   end if;
   if (b(4) = '1') then
     shift16L := shift8L(a'LENGTH-17 downto 0) & X"0000";
   else
     shift16L := shift8L;
   end if;
   return (shift16L);
  end shlv5;
  
  function shlv6 (a, b : std_logic_vector) return std_logic_vector is
    variable shift1L, shift2L, shift4L, shift8L, shift16L, shift32L : std_logic_vector(a'RANGE);
  begin
   if (b(0) = '1') then
     shift1L := a(a'LENGTH-2 downto 0) & '0';
   else
     shift1L := a;
   end if;
   if (b(1) = '1') then
     shift2L := shift1L(a'LENGTH-3 downto 0) & "00";
   else
     shift2L := shift1L;
   end if;
   if (b(2) = '1') then
     shift4L := shift2L(a'LENGTH-5 downto 0) & X"0";
   else
     shift4L := shift2L;
   end if;
   if (b(3) = '1') then
     shift8L := shift4L(a'LENGTH-9 downto 0) & X"00";
   else
     shift8L := shift4L;
   end if;
   if (b(4) = '1') then
     shift16L := shift8L(a'LENGTH-17 downto 0) & X"0000";
   else
     shift16L := shift8L;
   end if;
   if (b(5) = '1') then
     shift32L := shift16L(a'LENGTH-33 downto 0) & X"00000000";
   else
     shift32L := shift16L;
   end if;
   return (shift32L);
  end shlv6;

  function mul (a, b : std_logic_vector; mode : std_logic ; trunc_val : integer) return std_logic_vector is
    variable c : std_logic_vector(trunc_val-1 downto 0);
    variable t_c : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
    variable t_a : std_logic_vector(a'RANGE);
    variable t_b : std_logic_vector(b'RANGE);
    variable a_sgn, b_sgn, c_sgn : std_logic;
  begin 
    if (mode = '0') then
      t_c := std_logic_vector(unsigned(a) * unsigned(b));
    else
      t_a := a;
      t_b := b;
      a_sgn := a(a'LENGTH-1);
      b_sgn := b(b'LENGTH-1);
      c_sgn := a_sgn xor b_sgn;
      if (a_sgn = '1') then
        t_a(a'LENGTH-2 downto 0) := not t_a(a'LENGTH-2 downto 0);
        t_a(a'LENGTH-2 downto 0) := std_logic_vector(unsigned(t_a(a'LENGTH-2 downto 0)) + unsigned(ONE));
      end if;
      if (b_sgn = '1') then
        t_b(b'LENGTH-2 downto 0) := not t_b(b'LENGTH-2 downto 0);
        t_b(b'LENGTH-2 downto 0) := std_logic_vector(unsigned(t_b(b'LENGTH-2 downto 0)) + unsigned(ONE));
      end if;
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := std_logic_vector(unsigned(t_a(a'LENGTH-2 downto 0)) * unsigned(t_b(b'LENGTH-2 downto 0)));
      if (c_sgn = '1') then
        t_c(a'LENGTH+b'LENGTH-3 downto 0) := not t_c(a'LENGTH+b'LENGTH-3 downto 0);
        t_c(a'LENGTH+b'LENGTH-3 downto 0) := std_logic_vector(unsigned(t_c(a'LENGTH+b'LENGTH-3 downto 0)) + unsigned(ONE));
      end if;
      t_c(a'LENGTH+b'LENGTH-2) := c_sgn;
      t_c(a'LENGTH+b'LENGTH-1) := c_sgn;
    end if;
    c := t_c(trunc_val-1 downto 0);
    return (c);
  end mul;
  
  function umul (a, b : std_logic_vector ; trunc_val : integer) return std_logic_vector is
    variable c : std_logic_vector(trunc_val-1 downto 0);
    variable t_c : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
  begin 
    t_c := std_logic_vector(unsigned(a) * unsigned(b));
    c := t_c(trunc_val-1 downto 0);
    return (c);
  end umul;

  function smul (a, b : std_logic_vector; trunc_val : integer) return std_logic_vector is
    variable c : std_logic_vector(trunc_val-1 downto 0);
    variable t_c : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
    variable t_a : std_logic_vector(a'RANGE);
    variable t_b : std_logic_vector(b'RANGE);
    variable a_sgn, b_sgn, c_sgn : std_logic;
  begin 
    t_a := a;
    t_b := b;
    a_sgn := a(a'LENGTH-1);
    b_sgn := b(b'LENGTH-1);
    c_sgn := a_sgn xor b_sgn;
    if (a_sgn = '1') then
      t_a(a'LENGTH-2 downto 0) := not t_a(a'LENGTH-2 downto 0);
      t_a(a'LENGTH-2 downto 0) := std_logic_vector(unsigned(t_a(a'LENGTH-2 downto 0)) + unsigned(ONE));
    end if;
    if (b_sgn = '1') then
      t_b(b'LENGTH-2 downto 0) := not t_b(b'LENGTH-2 downto 0);
      t_b(b'LENGTH-2 downto 0) := std_logic_vector(unsigned(t_b(b'LENGTH-2 downto 0)) + unsigned(ONE));
    end if;
    t_c(a'LENGTH+b'LENGTH-3 downto 0) := std_logic_vector(unsigned(t_a(a'LENGTH-2 downto 0)) * unsigned(t_b(b'LENGTH-2 downto 0)));
    if (c_sgn = '1') then
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := not t_c(a'LENGTH+b'LENGTH-3 downto 0);
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := std_logic_vector(unsigned(t_c(a'LENGTH+b'LENGTH-3 downto 0)) + unsigned(ONE));
    end if;
    t_c(a'LENGTH+b'LENGTH-2) := c_sgn;
    t_c(a'LENGTH+b'LENGTH-1) := c_sgn;
    c := t_c(trunc_val-1 downto 0);
    return (c);
  end smul;

  procedure divqr (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal q, r : out std_logic_vector) is
    variable a_uns        : unsigned(a'RANGE);
    variable b_uns        : unsigned(b'RANGE);
    variable quot_uns     : unsigned(a'RANGE);
    variable rem_uns      : unsigned(b'RANGE); 
  begin 
    if (mode = '0') then
      a_uns := unsigned(a);
      b_uns := unsigned(b);
      xdivmod (a_uns, b_uns, quot_uns, rem_uns);
    else
    if (a(a'LENGTH-1) = '1') then
      a_uns := not(unsigned(a)) + unsigned(ONE);
    else 
      a_uns := unsigned(a);
    end if;
    if (b(b'LENGTH-1) = '1') then
      b_uns := not(unsigned(b)) + unsigned(ONE);
    else 
      b_uns := unsigned(b);
    end if;
    xdivmod (a_uns, b_uns, quot_uns, rem_uns);
    -- The sign of the remainder is the same as the sign of the dividend
    -- and the quotient is negated if the signs of the operands are
    -- opposite.
    if (a(a'LENGTH-1) = '1') then
      rem_uns := not(rem_uns) + unsigned(ONE);
      if (b(b'LENGTH-1) = '0') then
        quot_uns := not(quot_uns) + unsigned(ONE);
      end if;
    else -- positive dividend
      if (b(b'LENGTH-1) = '1') then
        quot_uns := not(quot_uns) + unsigned(ONE);
      end if;
    end if;
    end if;
    q <= std_logic_vector(quot_uns);
    r <= std_logic_vector(rem_uns);
  end divqr;

  procedure divq (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal q : out std_logic_vector) is
    variable a_uns        : unsigned(a'LENGTH-1 downto 0);
    variable b_uns        : unsigned(b'LENGTH-1 downto 0);
    variable quot_uns     : unsigned(a'RANGE);
  begin 
    if (mode = '0') then
      a_uns := unsigned(a);
      b_uns := unsigned(b);
      xdiv(a_uns, b_uns, quot_uns);
    else
    if (a(a'LENGTH-1) = '1') then
      a_uns := not(unsigned(a)) + unsigned(ONE);
    else 
      a_uns := unsigned(a);
    end if;
    if (b(b'LENGTH-1) = '1') then
      b_uns := not(unsigned(b)) + unsigned(ONE);
    else 
      b_uns := unsigned(b);
    end if;
    xdiv (a_uns, b_uns, quot_uns);
    -- The sign of the remainder is the same as the sign of the dividend
    -- and the quotient is negated if the signs of the operands are
    -- opposite.
    if (a(a'LENGTH-1) = '1') then
      if (b(b'LENGTH-1) = '0') then
        quot_uns := not(quot_uns) + unsigned(ONE);
      end if;
    else -- positive dividend
      if (b(b'LENGTH-1) = '1') then
        quot_uns := not(quot_uns) + unsigned(ONE);
      end if;
    end if;
    end if;
    q <= std_logic_vector(quot_uns);
  end divq;

  procedure divr (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal r : out std_logic_vector) is
    variable a_uns        : unsigned(a'LENGTH-1 downto 0);
    variable b_uns        : unsigned(b'LENGTH-1 downto 0);
    variable rem_uns      : unsigned(b'RANGE); 
  begin 
    if (mode = '0') then
      a_uns := unsigned(a);
      b_uns := unsigned(b);
      xmod (a_uns, b_uns, rem_uns);
    else
    if (a(a'LENGTH-1) = '1') then
      a_uns := not(unsigned(a)) + unsigned(ONE);
    else 
      a_uns := unsigned(a);
    end if;
    if (b(b'LENGTH-1) = '1') then
      b_uns := not(unsigned(b)) + unsigned(ONE);
    else 
      b_uns := unsigned(b);
    end if;
    xmod (a_uns, b_uns, rem_uns);
    -- The sign of the remainder is the same as the sign of the dividend
    -- and the quotient is negated if the signs of the operands are
    -- opposite.
    if (a(a'LENGTH-1) = '1') then
      rem_uns := not(rem_uns) + unsigned(ONE);
    end if;
    end if;
    r <= std_logic_vector(rem_uns);
  end divr;
  
  procedure divm (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal r : out std_logic_vector) is
    variable a_uns        : unsigned(a'LENGTH-1 downto 0);
    variable b_uns        : unsigned(b'LENGTH-1 downto 0);
    variable rem_uns      : unsigned(b'RANGE); 
  begin 
    if (mode = '0') then
      a_uns := unsigned(a);
      b_uns := unsigned(b);
      xmod (a_uns, b_uns, rem_uns);
    else
    if (a(a'LENGTH-1) = '1') then
      a_uns := not(unsigned(a)) + unsigned(ONE);
    else 
      a_uns := unsigned(a);
    end if;
    if (b(b'LENGTH-1) = '1') then
      b_uns := not(unsigned(b)) + unsigned(ONE);
    else 
      b_uns := unsigned(b);
    end if;
    xmod (a_uns, b_uns, rem_uns);
    -- The sign of the remainder is the same as the sign of the divisor
    -- and the quotient is negated if the signs of the operands are
    -- opposite.
    if (b(a'LENGTH-1) = '1') then
      rem_uns := not(rem_uns) + unsigned(ONE);
    end if;
    end if;
    r <= std_logic_vector(rem_uns);
  end divm;  

  function bitinsert (a, y0, bhi, blo : std_logic_vector) return std_logic_vector is
    variable y : std_logic_vector(a'RANGE);
  begin
    y := y0;
    y(to_integer(unsigned(bhi)) downto to_integer(unsigned(blo))) := a(to_integer(unsigned(bhi))-to_integer(unsigned(blo)) downto a'LOW);
    return (y);
  end bitinsert;
    
  function bitextract (a, bhi, blo : std_logic_vector) return std_logic_vector is
    variable y : std_logic_vector(a'RANGE);
  begin
    y := a;
    y(to_integer(unsigned(bhi))-to_integer(unsigned(blo)) downto a'LOW) := a(to_integer(unsigned(bhi)) downto to_integer(unsigned(blo)));
    return (y);
  end bitextract;

  -- -- this internal procedure computes unsigned division
  -- -- giving the quotient and remainder.
  -- procedure xdivmod (num, xdenom: unsigned; xquot, xremain: out unsigned) is
    -- variable temp: unsigned(num'length downto 0);
-- --    variable quot: unsigned(max(num'length, xdenom'length)-1 downto 0); -- ?
    -- variable quot: unsigned(num'length-1 downto 0);
    -- alias denom: unsigned(xdenom'length-1 downto 0) is xdenom;
    -- variable topbit: integer;
  -- begin
    -- temp := "0"&num;
    -- quot := (others => '0');
    -- topbit := -1;
    -- for j in denom'range loop
      -- if denom(j)='1' then
        -- topbit := j;
        -- exit;
      -- end if;
    -- end loop;
    -- assert topbit >= 0 report "div, mod, or rem by zero" severity error;
    -- for j in num'length-(topbit+1) downto 0 loop
      -- if temp(topbit+j+1 downto j) >= "0"&denom(topbit downto 0) then
        -- temp(topbit+j+1 downto j) := (temp(topbit+j+1 downto j))
            -- -("0"&denom(topbit downto 0));
        -- quot(j) := '1';
      -- end if;
      -- assert temp(topbit+j+1)='0'
          -- report "internal error in the division algorithm"
          -- severity error;
    -- end loop;
    -- xquot := resize(quot, xquot'length);
    -- xremain := resize(temp, xremain'length);
  -- end xdivmod;

  -- procedure xdiv (num, xdenom: unsigned; xquot: out unsigned) is
    -- variable temp: unsigned(num'length downto 0);
    -- variable quot: unsigned(num'length-1 downto 0);
    -- alias denom: unsigned(xdenom'length-1 downto 0) is xdenom;
    -- variable topbit: integer;
  -- begin
    -- temp := "0"&num;
    -- quot := (others => '0');
    -- topbit := -1;
    -- for j in denom'range loop
      -- if denom(j)='1' then
        -- topbit := j;
        -- exit;
      -- end if;
    -- end loop;
    -- assert topbit >= 0 report "div, mod, or rem by zero" severity error;

    -- for j in num'length-(topbit+1) downto 0 loop
      -- if temp(topbit+j+1 downto j) >= "0"&denom(topbit downto 0) then
        -- temp(topbit+j+1 downto j) := (temp(topbit+j+1 downto j))
            -- -("0"&denom(topbit downto 0));
        -- quot(j) := '1';
      -- end if;
      -- assert temp(topbit+j+1)='0'
          -- report "internal error in the division algorithm"
          -- severity error;
    -- end loop;
    -- xquot := resize(quot, xquot'length);
  -- end xdiv;

  -- procedure xmod (num, xdenom: unsigned; xremain: out unsigned) is
    -- variable temp: unsigned(num'length downto 0);
-- --    variable quot: unsigned(max(num'length, xdenom'length)-1 downto 0);
    -- variable quot: unsigned(num'length-1 downto 0);
    -- alias denom: unsigned(xdenom'length-1 downto 0) is xdenom;
    -- variable topbit: integer;
  -- begin
    -- temp := "0"&num;
    -- quot := (others => '0');
    -- topbit := -1;
    -- for j in denom'range loop
      -- if denom(j)='1' then
        -- topbit := j;
        -- exit;
      -- end if;
    -- end loop;
    -- assert topbit >= 0 report "div, mod, or rem by zero" severity error;

    -- for j in num'length-(topbit+1) downto 0 loop
      -- if temp(topbit+j+1 downto j) >= "0"&denom(topbit downto 0) then
        -- temp(topbit+j+1 downto j) := (temp(topbit+j+1 downto j))
            -- -("0"&denom(topbit downto 0));
        -- quot(j) := '1';
      -- end if;
      -- assert temp(topbit+j+1)='0'
          -- report "internal error in the division algorithm"
          -- severity error;
    -- end loop;
    -- xremain := resize(temp, xremain'length);
  -- end xmod;
  
  procedure xdivmod (bv1, bv2 : in unsigned; bv_quotient : out unsigned; bv_remainder : out unsigned) is
    constant len : natural := bv1'length;
    constant zero_divisor : unsigned(len-1 downto 0) := (others => '0');
    alias dividend : unsigned(bv1'length-1 downto 0) is bv1;
    variable divisor : unsigned(bv2'length downto 0) := '0' & bv2;
    variable quotient : unsigned(len-1 downto 0);
    variable remainder : unsigned(len downto 0) := (others => '0');
    variable ignore_overflow : boolean;
    variable div_by_zero : boolean;
  begin
    if bv1'length /= bv2'length
	   or bv1'length /= bv_quotient'length or bv1'length /= bv_remainder'length then
      report "xdivmod: operands of different lengths"
      severity failure;
    else
      --  check for zero divisor
      if bv2 = zero_divisor then
        div_by_zero := true;
        return;
      end if;
      --  perform division
      for iter in len-1 downto 0 loop
        if remainder(len) = '0' then
          remainder := remainder sll 1;
          remainder(0) := dividend(iter);
--          bv_sub(remainder, divisor, remainder, ignore_overflow);
          remainder := remainder - divisor;
        else
          remainder := remainder sll 1;
          remainder(0) := dividend(iter);
--          bv_add(remainder, divisor, remainder, ignore_overflow);
          remainder := remainder + divisor;
        end if;
      quotient(iter) := not remainder(len);
      end loop;
      if remainder(len) = '1' then
--        bv_add(remainder, divisor, remainder, ignore_overflow);
        remainder := remainder + divisor;
      end if;
      bv_quotient := quotient;
      bv_remainder := remainder(len - 1 downto 0);
      div_by_zero := false;
    end if;
  end procedure xdivmod;

  procedure xdiv(bv1, bv2 : in unsigned; bv_quotient : out unsigned) is
    variable ignore_remainder : unsigned(bv_quotient'range);
  begin
    xdivmod(bv1, bv2, bv_quotient, ignore_remainder);
  end procedure xdiv;

  procedure xmod(bv1, bv2 : in unsigned; bv_remainder : out unsigned) is
    variable ignore_quotient : unsigned(bv_remainder'range);
  begin
    xdivmod(bv1, bv2, ignore_quotient, bv_remainder);
  end procedure xmod;

end operpack;
