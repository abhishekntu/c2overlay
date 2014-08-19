--------------------------------------------------------------------------------
-- Filename: operpack.vhd
-- Purpose : Package for various arithmetic operators:
--           * Variable shifter (left shift unsigned, left shift signed, right 
--             shift unsigned, right shift signed)
--           * Multipliers (mul, smul, umul)
--           * Dividers and modulo extractors (divqr, divq, divr)
--           * Bit manipulation operators (bitinsert, bitextract)
--           * Variable rotators (rotr, rotl)
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
--           0.3.2 (18/04/11)
--           Added divm (mod) operator.
--           0.3.3 (01/05/11)
--           Added bitinsert, bitextract operators.
--           0.4.0 (16/11/11)
--           Added rotr, rotl.
--           0.4.1 (20/07/12)
--           Small cleanups, fixes in log2f, log2c.
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


package operpack is 
  
  function log2f (arg : integer) return integer;
  function log2c (arg : integer) return integer;
  function shrv (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv1 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv2 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv3 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv4 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shrv5 (a, b : std_logic_vector; mode : std_logic) return std_logic_vector;
  function shlv (a, b : std_logic_vector) return std_logic_vector;
  function shlv1 (a, b : std_logic_vector) return std_logic_vector;
  function shlv2 (a, b : std_logic_vector) return std_logic_vector;
  function shlv3 (a, b : std_logic_vector) return std_logic_vector;
  function shlv4 (a, b : std_logic_vector) return std_logic_vector;
  function shlv5 (a, b : std_logic_vector) return std_logic_vector;
  function rotr(vector : in std_logic_vector; n : in integer) return std_logic_vector;  
  function rotl(vector : in std_logic_vector; n : in integer) return std_logic_vector;  
  function mul (a, b : std_logic_vector ; mode : std_logic ; trunc_val : integer) return std_logic_vector;
  function umul (a, b : std_logic_vector ; trunc_val : integer) return std_logic_vector;
  function smul (a, b : std_logic_vector ; trunc_val : integer) return std_logic_vector;
  procedure divqr (a, b : in std_logic_vector; mode : in std_logic; signal q, r : out std_logic_vector);
  procedure divq (a, b : in std_logic_vector; mode : in std_logic; signal q : out std_logic_vector);
  procedure divr (a, b : in std_logic_vector; mode : in std_logic; signal r : out std_logic_vector);
  procedure divm (a, b : in std_logic_vector; mode : in std_logic; signal r : out std_logic_vector);
  function bitinsert (a, y0, bhi, blo : std_logic_vector) return std_logic_vector;
  function bitextract (a, bhi, blo : std_logic_vector) return std_logic_vector;

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
  
  function rotr(vector : in std_logic_vector; n : in integer) return std_logic_vector is
    variable new_vector : std_logic_vector(vector'RANGE);
    variable temp_bit : std_logic;
  begin
    new_vector := vector;
    if (n > vector'LENGTH) then
      report "n is greater than the vector LENGTH"
      severity warning;
    else
      new_vector := new_vector(n-1 downto 0) & new_vector(new_vector'LENGTH-1 downto n);      
    end if;
    return new_vector;
  end rotr;

  function rotl(vector : in std_logic_vector; n : in integer) return std_logic_vector is
    variable new_vector : std_logic_vector(vector'RANGE);
    variable temp_bit : std_logic;
  begin
    new_vector := vector;
    if (n > vector'LENGTH) then
      report "n is greater than the vector LENGTH"
      severity warning;
    else
      new_vector := new_vector(new_vector'LENGTH-n-1 downto 0) 
              & new_vector(new_vector'LENGTH-1 downto new_vector'LENGTH-n);      
    end if;
    return new_vector;
  end rotl;

  function mul (a, b : std_logic_vector; mode : std_logic ; trunc_val : integer) return std_logic_vector is
    variable c : std_logic_vector(trunc_val-1 downto 0);
    variable t_c : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
    variable t_a : std_logic_vector(a'RANGE);
    variable t_b : std_logic_vector(b'RANGE);
    variable a_sgn, b_sgn, c_sgn : std_logic;
  begin 
    if (mode = '0') then
      t_c := a * b;
    else
      t_a := a;
      t_b := b;
      a_sgn := a(a'LENGTH-1);
      b_sgn := b(b'LENGTH-1);
      c_sgn := a_sgn xor b_sgn;
      if (a_sgn = '1') then
        t_a(a'LENGTH-2 downto 0) := not t_a(a'LENGTH-2 downto 0);
        t_a(a'LENGTH-2 downto 0) := t_a(a'LENGTH-2 downto 0) + "1";
      end if;
      if (b_sgn = '1') then
        t_b(b'LENGTH-2 downto 0) := not t_b(b'LENGTH-2 downto 0);
        t_b(b'LENGTH-2 downto 0) := t_b(b'LENGTH-2 downto 0) + "1";
      end if;
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := t_a(a'LENGTH-2 downto 0) * t_b(b'LENGTH-2 downto 0);
      if (c_sgn = '1') then
        t_c(a'LENGTH+b'LENGTH-3 downto 0) := not t_c(a'LENGTH+b'LENGTH-3 downto 0);
        t_c(a'LENGTH+b'LENGTH-3 downto 0) := t_c(a'LENGTH+b'LENGTH-3 downto 0) + "1";
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
    t_c := a * b;
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
      t_a(a'LENGTH-2 downto 0) := t_a(a'LENGTH-2 downto 0) + "1";
    end if;
    if (b_sgn = '1') then
      t_b(b'LENGTH-2 downto 0) := not t_b(b'LENGTH-2 downto 0);
      t_b(b'LENGTH-2 downto 0) := t_b(b'LENGTH-2 downto 0) + "1";
    end if;
    t_c(a'LENGTH+b'LENGTH-3 downto 0) := t_a(a'LENGTH-2 downto 0) * t_b(b'LENGTH-2 downto 0);
    if (c_sgn = '1') then
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := not t_c(a'LENGTH+b'LENGTH-3 downto 0);
      t_c(a'LENGTH+b'LENGTH-3 downto 0) := t_c(a'LENGTH+b'LENGTH-3 downto 0) + "1";
    end if;
    t_c(a'LENGTH+b'LENGTH-2) := c_sgn;
    t_c(a'LENGTH+b'LENGTH-1) := c_sgn;
    c := t_c(trunc_val-1 downto 0);
    return (c);
  end smul;

-- ==============================================================================
-- Generic signed/unsigned restoring divider 
-- 
-- This library is free software; you can redistribute it and/or modify it 
-- under the terms of the GNU Lesser General Public License as published 
-- by the Free Software Foundation; either version 2.1 of the License, or 
-- (at your option) any later version.
-- 
-- This library is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE.   See the GNU Lesser General Public 
-- License for more details.   See http://www.gnu.org/copyleft/lesser.txt
-- 
-- ------------------------------------------------------------------------------
-- Version   Author          Date          Changes
-- 0.1       Hans Tiggeler   07/18/02      Tested on Modelsim SE 5.6
-- x.x       Nik. Kavvadias  22/10/10      Procedure implementations.
-- ==============================================================================
  procedure divqr (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal q, r : out std_logic_vector) is
    type stdarray is array(a'LENGTH downto 0) of std_logic_vector(b'LENGTH downto 0);
    variable addsub_s   : stdarray;
    variable dividend_s   : std_logic_vector(a'RANGE);
    variable didi_s       : std_logic_vector(a'RANGE);
    variable divisor_s    : std_logic_vector(b'LENGTH downto 0);  
    variable disi_s       : std_logic_vector(b'LENGTH downto 0); 
    variable divn_s       : std_logic_vector(b'LENGTH downto 0);
    variable div_s        : std_logic_vector(b'LENGTH downto 0);
    variable signquot_s   : std_logic;
    variable signremain_s : std_logic;  
    variable remain_s     : std_logic_vector(b'LENGTH+1 downto 0); 
    variable remainder_s  : std_logic_vector(b'LENGTH+1 downto 0); 
    variable quot_s       : std_logic_vector(a'RANGE);
    variable quotient_s   : std_logic_vector(a'RANGE);
  begin 
  -- Sign Quotient
  signquot_s := (a(a'LENGTH-1) xor b(b'LENGTH-1)) and mode;
  -- Sign Remainder
  signremain_s := (signquot_s xor b(b'LENGTH-1)) and mode;
  --  Rectify Dividend    
  if ((a(a'LENGTH-1) and mode)='1') then
    didi_s := not(a);
  else
    didi_s := a;
  end if;
  dividend_s := didi_s + (a(a'LENGTH-1) and mode);
  --  Rectify Divisor   
  if ((b(b'LENGTH-1) and mode)='1') then
    disi_s := not('1'&b);
  else
    disi_s := '0'&b;
  end if;
  divisor_s := disi_s + (b(b'LENGTH-1) and mode);
  --  Create 2-Complement negative divisor
  divn_s := not(divisor_s) + '1';
  --  Positive Divisor
  div_s  := divisor_s;
  -- Note first stage dividend_s(a'LENGTH-1) is always '0'
  addsub_s(a'LENGTH) := divn_s;
  --
  stages : for i in a'LENGTH-1 downto 0 loop
    if (addsub_s(i+1)(b'LENGTH)='1') then
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + div_s;
    else 
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + divn_s;
    end if;
  end loop stages;
  --
  if (addsub_s(0)(b'LENGTH)='1') then
    remain_s := ((addsub_s(0)(b'LENGTH)&addsub_s(0)) + ('0'&div_s));
  else
    remain_s := '0'&addsub_s(0);
  end if;
  --
  -- Quotient
  outstage : for i in a'LENGTH-1 downto 0 loop
    quot_s(i) := not(addsub_s(i)(b'LENGTH));
  end loop outstage;
  --
  -- Correct remainder sign
  if (signremain_s='1') then
    remainder_s := not(remain_s) + '1';   
  else
    remainder_s := remain_s;  
  end if;
  -- Correct quotient sign
  if (signquot_s='1') then
    quotient_s := not(quot_s) + '1';   
  else
    quotient_s := quot_s;
  end if;
  -- Final remainder calculation
  if (mode='1') then
    r <= remainder_s(b'LENGTH-1 downto 0);
  else
    r <= remainder_s(b'LENGTH-1 downto 0) + remainder_s(b'LENGTH+1);
  end if;
  -- Final quotient calculation
  q <= quotient_s;
  --
  end divqr;

  procedure divq (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal q : out std_logic_vector) is
    type stdarray is array(a'LENGTH downto 0) of std_logic_vector(b'LENGTH downto 0);
    variable addsub_s   : stdarray;
    variable dividend_s   : std_logic_vector(a'RANGE);
    variable didi_s       : std_logic_vector(a'RANGE);
    variable divisor_s    : std_logic_vector(b'LENGTH downto 0);  
    variable disi_s       : std_logic_vector(b'LENGTH downto 0); 
    variable divn_s       : std_logic_vector(b'LENGTH downto 0);
    variable div_s        : std_logic_vector(b'LENGTH downto 0);
    variable signquot_s   : std_logic;
    variable quot_s       : std_logic_vector(a'RANGE);
    variable quotient_s   : std_logic_vector(a'RANGE);
  begin 
  -- Sign Quotient
  signquot_s := (a(a'LENGTH-1) xor b(b'LENGTH-1)) and mode;
  --  Rectify Dividend    
  if ((a(a'LENGTH-1) and mode)='1') then
    didi_s := not(a);
  else
    didi_s := a;
  end if;
  dividend_s := didi_s + (a(a'LENGTH-1) and mode);
  --  Rectify Divisor   
  if ((b(b'LENGTH-1) and mode)='1') then
    disi_s := not('1'&b);
  else
    disi_s := '0'&b;
  end if;
  divisor_s := disi_s + (b(b'LENGTH-1) and mode);
  --  Create 2-Complement negative divisor
  divn_s := not(divisor_s) + '1';
  --  Positive Divisor
  div_s  := divisor_s;
  -- Note first stage dividend_s(a'LENGTH-1) is always '0'
  addsub_s(a'LENGTH) := divn_s;
  --
  stages : for i in a'LENGTH-1 downto 0 loop
    if (addsub_s(i+1)(b'LENGTH)='1') then
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + div_s;
    else 
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + divn_s;
    end if;
  end loop stages;
  --
  -- Quotient
  outstage : for i in a'LENGTH-1 downto 0 loop
    quot_s(i) := not(addsub_s(i)(b'LENGTH));
  end loop outstage;
  --
  -- Correct quotient sign
  if (signquot_s='1') then
    quotient_s := not(quot_s) + '1';   
  else
    quotient_s := quot_s;
  end if;
  -- Final quotient calculation
  q <= quotient_s;
  --
  end divq;

  procedure divr (a, b : in std_logic_vector; 
    mode : in std_logic ; 
    signal r : out std_logic_vector) is
    type stdarray is array(a'LENGTH downto 0) of std_logic_vector(b'LENGTH downto 0);
    variable addsub_s   : stdarray;
    variable dividend_s   : std_logic_vector(a'RANGE);
    variable didi_s       : std_logic_vector(a'RANGE);
    variable divisor_s    : std_logic_vector(b'LENGTH downto 0);  
    variable disi_s       : std_logic_vector(b'LENGTH downto 0); 
    variable divn_s       : std_logic_vector(b'LENGTH downto 0);
    variable div_s        : std_logic_vector(b'LENGTH downto 0);
    variable signquot_s   : std_logic;  
    variable signremain_s : std_logic;  
    variable remain_s     : std_logic_vector(b'LENGTH+1 downto 0); 
    variable remainder_s  : std_logic_vector(b'LENGTH+1 downto 0); 
  begin 
  if (b = (b'LENGTH-1 downto 0 => '0')) then
    assert false
      report "divr: Result = NaN" 
      severity failure;
  end if;
  -- Sign Quotient
  signquot_s := (a(a'LENGTH-1) xor b(b'LENGTH-1)) and mode;  
  -- Sign Remainder
  signremain_s := (signquot_s xor b(b'LENGTH-1)) and mode;
  --  Rectify Dividend    
  if ((a(a'LENGTH-1) and mode)='1') then
    didi_s := not(a);
  else
    didi_s := a;
  end if;
  dividend_s := didi_s + (a(a'LENGTH-1) and mode);
  --  Rectify Divisor   
  if ((b(b'LENGTH-1) and mode)='1') then
    disi_s := not('1'&b);
  else
    disi_s := '0'&b;
  end if;
  divisor_s := disi_s + (b(b'LENGTH-1) and mode);
  --  Create 2-Complement negative divisor
  divn_s := not(divisor_s) + '1';
  --  Positive Divisor
  div_s  := divisor_s;
  -- Note first stage dividend_s(a'LENGTH-1) is always '0'
  addsub_s(a'LENGTH) := divn_s;
  --
  stages : for i in a'LENGTH-1 downto 0 loop
    if (addsub_s(i+1)(b'LENGTH)='1') then
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + div_s;
    else 
      addsub_s(i) := (addsub_s(i+1)(b'LENGTH-1 downto 0) & dividend_s(i)) + divn_s;
    end if;
  end loop stages;
  --
  if (addsub_s(0)(b'LENGTH)='1') then
    remain_s := ((addsub_s(0)(b'LENGTH)&addsub_s(0)) + ('0'&div_s));
  else
    remain_s := '0'&addsub_s(0);
  end if;
  --
  -- Correct remainder sign
  if (signremain_s='1') then
    remainder_s := not(remain_s) + '1';   
  else
    remainder_s := remain_s;  
  end if;
  -- Final remainder calculation
  if (mode='1') then
    r <= remainder_s(b'LENGTH-1 downto 0);
  else
    r <= remainder_s(b'LENGTH-1 downto 0) + remainder_s(b'LENGTH+1);
  end if;
  --
  end divr;
  
  function bitinsert (a, y0, bhi, blo : std_logic_vector) return std_logic_vector is
    variable y : std_logic_vector(a'RANGE);
  begin
    y := y0;
    y(conv_integer(bhi) downto conv_integer(blo)) := a(conv_integer(bhi)-conv_integer(blo) downto a'LOW);
    return (y);
  end bitinsert;
    
  function bitextract (a, bhi, blo : std_logic_vector) return std_logic_vector is
    variable y : std_logic_vector(a'RANGE);
  begin
    y := a;
    y(conv_integer(bhi)-conv_integer(blo) downto a'LOW) := a(conv_integer(bhi) downto conv_integer(blo));
    return (y);
  end bitextract;

end operpack;
