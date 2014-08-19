--------------------------------------------------------------------------------
--                                 FPDiv_8_23
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 16 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPDiv_8_23 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPDiv_8_23 is
signal fX :  std_logic_vector(23 downto 0);
signal fY, fY_d1, fY_d2, fY_d3, fY_d4, fY_d5, fY_d6, fY_d7, fY_d8, fY_d9, fY_d10, fY_d11, fY_d12, fY_d13 :  std_logic_vector(23 downto 0);
signal expR0, expR0_d1, expR0_d2, expR0_d3, expR0_d4, expR0_d5, expR0_d6, expR0_d7, expR0_d8, expR0_d9, expR0_d10, expR0_d11, expR0_d12, expR0_d13, expR0_d14, expR0_d15 :  std_logic_vector(9 downto 0);
signal sR, sR_d1, sR_d2, sR_d3, sR_d4, sR_d5, sR_d6, sR_d7, sR_d8, sR_d9, sR_d10, sR_d11, sR_d12, sR_d13, sR_d14, sR_d15, sR_d16 : std_logic;
signal exnXY :  std_logic_vector(3 downto 0);
signal exnR0, exnR0_d1, exnR0_d2, exnR0_d3, exnR0_d4, exnR0_d5, exnR0_d6, exnR0_d7, exnR0_d8, exnR0_d9, exnR0_d10, exnR0_d11, exnR0_d12, exnR0_d13, exnR0_d14, exnR0_d15, exnR0_d16 :  std_logic_vector(1 downto 0);
signal fYTimes3, fYTimes3_d1, fYTimes3_d2, fYTimes3_d3, fYTimes3_d4, fYTimes3_d5, fYTimes3_d6, fYTimes3_d7, fYTimes3_d8, fYTimes3_d9, fYTimes3_d10, fYTimes3_d11, fYTimes3_d12, fYTimes3_d13 :  std_logic_vector(25 downto 0);
signal w13, w13_d1 :  std_logic_vector(25 downto 0);
signal sel13 :  std_logic_vector(4 downto 0);
signal q13, q13_d1, q13_d2, q13_d3, q13_d4, q13_d5, q13_d6, q13_d7, q13_d8, q13_d9, q13_d10, q13_d11, q13_d12, q13_d13 :  std_logic_vector(2 downto 0);
signal q13D :  std_logic_vector(26 downto 0);
signal w13pad :  std_logic_vector(26 downto 0);
signal w12full :  std_logic_vector(26 downto 0);
signal w12, w12_d1 :  std_logic_vector(25 downto 0);
signal sel12 :  std_logic_vector(4 downto 0);
signal q12, q12_d1, q12_d2, q12_d3, q12_d4, q12_d5, q12_d6, q12_d7, q12_d8, q12_d9, q12_d10, q12_d11, q12_d12 :  std_logic_vector(2 downto 0);
signal q12D :  std_logic_vector(26 downto 0);
signal w12pad :  std_logic_vector(26 downto 0);
signal w11full :  std_logic_vector(26 downto 0);
signal w11, w11_d1 :  std_logic_vector(25 downto 0);
signal sel11 :  std_logic_vector(4 downto 0);
signal q11, q11_d1, q11_d2, q11_d3, q11_d4, q11_d5, q11_d6, q11_d7, q11_d8, q11_d9, q11_d10, q11_d11 :  std_logic_vector(2 downto 0);
signal q11D :  std_logic_vector(26 downto 0);
signal w11pad :  std_logic_vector(26 downto 0);
signal w10full :  std_logic_vector(26 downto 0);
signal w10, w10_d1 :  std_logic_vector(25 downto 0);
signal sel10 :  std_logic_vector(4 downto 0);
signal q10, q10_d1, q10_d2, q10_d3, q10_d4, q10_d5, q10_d6, q10_d7, q10_d8, q10_d9, q10_d10 :  std_logic_vector(2 downto 0);
signal q10D :  std_logic_vector(26 downto 0);
signal w10pad :  std_logic_vector(26 downto 0);
signal w9full :  std_logic_vector(26 downto 0);
signal w9, w9_d1 :  std_logic_vector(25 downto 0);
signal sel9 :  std_logic_vector(4 downto 0);
signal q9, q9_d1, q9_d2, q9_d3, q9_d4, q9_d5, q9_d6, q9_d7, q9_d8, q9_d9 :  std_logic_vector(2 downto 0);
signal q9D :  std_logic_vector(26 downto 0);
signal w9pad :  std_logic_vector(26 downto 0);
signal w8full :  std_logic_vector(26 downto 0);
signal w8, w8_d1 :  std_logic_vector(25 downto 0);
signal sel8 :  std_logic_vector(4 downto 0);
signal q8, q8_d1, q8_d2, q8_d3, q8_d4, q8_d5, q8_d6, q8_d7, q8_d8 :  std_logic_vector(2 downto 0);
signal q8D :  std_logic_vector(26 downto 0);
signal w8pad :  std_logic_vector(26 downto 0);
signal w7full :  std_logic_vector(26 downto 0);
signal w7, w7_d1 :  std_logic_vector(25 downto 0);
signal sel7 :  std_logic_vector(4 downto 0);
signal q7, q7_d1, q7_d2, q7_d3, q7_d4, q7_d5, q7_d6, q7_d7 :  std_logic_vector(2 downto 0);
signal q7D :  std_logic_vector(26 downto 0);
signal w7pad :  std_logic_vector(26 downto 0);
signal w6full :  std_logic_vector(26 downto 0);
signal w6, w6_d1 :  std_logic_vector(25 downto 0);
signal sel6 :  std_logic_vector(4 downto 0);
signal q6, q6_d1, q6_d2, q6_d3, q6_d4, q6_d5, q6_d6 :  std_logic_vector(2 downto 0);
signal q6D :  std_logic_vector(26 downto 0);
signal w6pad :  std_logic_vector(26 downto 0);
signal w5full :  std_logic_vector(26 downto 0);
signal w5, w5_d1 :  std_logic_vector(25 downto 0);
signal sel5 :  std_logic_vector(4 downto 0);
signal q5, q5_d1, q5_d2, q5_d3, q5_d4, q5_d5 :  std_logic_vector(2 downto 0);
signal q5D :  std_logic_vector(26 downto 0);
signal w5pad :  std_logic_vector(26 downto 0);
signal w4full :  std_logic_vector(26 downto 0);
signal w4, w4_d1 :  std_logic_vector(25 downto 0);
signal sel4 :  std_logic_vector(4 downto 0);
signal q4, q4_d1, q4_d2, q4_d3, q4_d4 :  std_logic_vector(2 downto 0);
signal q4D :  std_logic_vector(26 downto 0);
signal w4pad :  std_logic_vector(26 downto 0);
signal w3full :  std_logic_vector(26 downto 0);
signal w3, w3_d1 :  std_logic_vector(25 downto 0);
signal sel3 :  std_logic_vector(4 downto 0);
signal q3, q3_d1, q3_d2, q3_d3 :  std_logic_vector(2 downto 0);
signal q3D :  std_logic_vector(26 downto 0);
signal w3pad :  std_logic_vector(26 downto 0);
signal w2full :  std_logic_vector(26 downto 0);
signal w2, w2_d1 :  std_logic_vector(25 downto 0);
signal sel2 :  std_logic_vector(4 downto 0);
signal q2, q2_d1, q2_d2 :  std_logic_vector(2 downto 0);
signal q2D :  std_logic_vector(26 downto 0);
signal w2pad :  std_logic_vector(26 downto 0);
signal w1full :  std_logic_vector(26 downto 0);
signal w1, w1_d1 :  std_logic_vector(25 downto 0);
signal sel1 :  std_logic_vector(4 downto 0);
signal q1, q1_d1 :  std_logic_vector(2 downto 0);
signal q1D :  std_logic_vector(26 downto 0);
signal w1pad :  std_logic_vector(26 downto 0);
signal w0full :  std_logic_vector(26 downto 0);
signal w0, w0_d1 :  std_logic_vector(25 downto 0);
signal q0 :  std_logic_vector(2 downto 0);
signal qP13 :  std_logic_vector(1 downto 0);
signal qM13 :  std_logic_vector(1 downto 0);
signal qP12 :  std_logic_vector(1 downto 0);
signal qM12 :  std_logic_vector(1 downto 0);
signal qP11 :  std_logic_vector(1 downto 0);
signal qM11 :  std_logic_vector(1 downto 0);
signal qP10 :  std_logic_vector(1 downto 0);
signal qM10 :  std_logic_vector(1 downto 0);
signal qP9 :  std_logic_vector(1 downto 0);
signal qM9 :  std_logic_vector(1 downto 0);
signal qP8 :  std_logic_vector(1 downto 0);
signal qM8 :  std_logic_vector(1 downto 0);
signal qP7 :  std_logic_vector(1 downto 0);
signal qM7 :  std_logic_vector(1 downto 0);
signal qP6 :  std_logic_vector(1 downto 0);
signal qM6 :  std_logic_vector(1 downto 0);
signal qP5 :  std_logic_vector(1 downto 0);
signal qM5 :  std_logic_vector(1 downto 0);
signal qP4 :  std_logic_vector(1 downto 0);
signal qM4 :  std_logic_vector(1 downto 0);
signal qP3 :  std_logic_vector(1 downto 0);
signal qM3 :  std_logic_vector(1 downto 0);
signal qP2 :  std_logic_vector(1 downto 0);
signal qM2 :  std_logic_vector(1 downto 0);
signal qP1 :  std_logic_vector(1 downto 0);
signal qM1 :  std_logic_vector(1 downto 0);
signal qP0 :  std_logic_vector(1 downto 0);
signal qM0 :  std_logic_vector(1 downto 0);
signal qP :  std_logic_vector(27 downto 0);
signal qM :  std_logic_vector(27 downto 0);
signal fR0, fR0_d1 :  std_logic_vector(27 downto 0);
signal fR :  std_logic_vector(26 downto 0);
signal fRn1, fRn1_d1 :  std_logic_vector(24 downto 0);
signal expR1, expR1_d1 :  std_logic_vector(9 downto 0);
signal round, round_d1 : std_logic;
signal expfrac :  std_logic_vector(32 downto 0);
signal expfracR :  std_logic_vector(32 downto 0);
signal exnR :  std_logic_vector(1 downto 0);
signal exnRfinal :  std_logic_vector(1 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            fY_d1 <=  fY;
            fY_d2 <=  fY_d1;
            fY_d3 <=  fY_d2;
            fY_d4 <=  fY_d3;
            fY_d5 <=  fY_d4;
            fY_d6 <=  fY_d5;
            fY_d7 <=  fY_d6;
            fY_d8 <=  fY_d7;
            fY_d9 <=  fY_d8;
            fY_d10 <=  fY_d9;
            fY_d11 <=  fY_d10;
            fY_d12 <=  fY_d11;
            fY_d13 <=  fY_d12;
            expR0_d1 <=  expR0;
            expR0_d2 <=  expR0_d1;
            expR0_d3 <=  expR0_d2;
            expR0_d4 <=  expR0_d3;
            expR0_d5 <=  expR0_d4;
            expR0_d6 <=  expR0_d5;
            expR0_d7 <=  expR0_d6;
            expR0_d8 <=  expR0_d7;
            expR0_d9 <=  expR0_d8;
            expR0_d10 <=  expR0_d9;
            expR0_d11 <=  expR0_d10;
            expR0_d12 <=  expR0_d11;
            expR0_d13 <=  expR0_d12;
            expR0_d14 <=  expR0_d13;
            expR0_d15 <=  expR0_d14;
            sR_d1 <=  sR;
            sR_d2 <=  sR_d1;
            sR_d3 <=  sR_d2;
            sR_d4 <=  sR_d3;
            sR_d5 <=  sR_d4;
            sR_d6 <=  sR_d5;
            sR_d7 <=  sR_d6;
            sR_d8 <=  sR_d7;
            sR_d9 <=  sR_d8;
            sR_d10 <=  sR_d9;
            sR_d11 <=  sR_d10;
            sR_d12 <=  sR_d11;
            sR_d13 <=  sR_d12;
            sR_d14 <=  sR_d13;
            sR_d15 <=  sR_d14;
            sR_d16 <=  sR_d15;
            exnR0_d1 <=  exnR0;
            exnR0_d2 <=  exnR0_d1;
            exnR0_d3 <=  exnR0_d2;
            exnR0_d4 <=  exnR0_d3;
            exnR0_d5 <=  exnR0_d4;
            exnR0_d6 <=  exnR0_d5;
            exnR0_d7 <=  exnR0_d6;
            exnR0_d8 <=  exnR0_d7;
            exnR0_d9 <=  exnR0_d8;
            exnR0_d10 <=  exnR0_d9;
            exnR0_d11 <=  exnR0_d10;
            exnR0_d12 <=  exnR0_d11;
            exnR0_d13 <=  exnR0_d12;
            exnR0_d14 <=  exnR0_d13;
            exnR0_d15 <=  exnR0_d14;
            exnR0_d16 <=  exnR0_d15;
            fYTimes3_d1 <=  fYTimes3;
            fYTimes3_d2 <=  fYTimes3_d1;
            fYTimes3_d3 <=  fYTimes3_d2;
            fYTimes3_d4 <=  fYTimes3_d3;
            fYTimes3_d5 <=  fYTimes3_d4;
            fYTimes3_d6 <=  fYTimes3_d5;
            fYTimes3_d7 <=  fYTimes3_d6;
            fYTimes3_d8 <=  fYTimes3_d7;
            fYTimes3_d9 <=  fYTimes3_d8;
            fYTimes3_d10 <=  fYTimes3_d9;
            fYTimes3_d11 <=  fYTimes3_d10;
            fYTimes3_d12 <=  fYTimes3_d11;
            fYTimes3_d13 <=  fYTimes3_d12;
            w13_d1 <=  w13;
            q13_d1 <=  q13;
            q13_d2 <=  q13_d1;
            q13_d3 <=  q13_d2;
            q13_d4 <=  q13_d3;
            q13_d5 <=  q13_d4;
            q13_d6 <=  q13_d5;
            q13_d7 <=  q13_d6;
            q13_d8 <=  q13_d7;
            q13_d9 <=  q13_d8;
            q13_d10 <=  q13_d9;
            q13_d11 <=  q13_d10;
            q13_d12 <=  q13_d11;
            q13_d13 <=  q13_d12;
            w12_d1 <=  w12;
            q12_d1 <=  q12;
            q12_d2 <=  q12_d1;
            q12_d3 <=  q12_d2;
            q12_d4 <=  q12_d3;
            q12_d5 <=  q12_d4;
            q12_d6 <=  q12_d5;
            q12_d7 <=  q12_d6;
            q12_d8 <=  q12_d7;
            q12_d9 <=  q12_d8;
            q12_d10 <=  q12_d9;
            q12_d11 <=  q12_d10;
            q12_d12 <=  q12_d11;
            w11_d1 <=  w11;
            q11_d1 <=  q11;
            q11_d2 <=  q11_d1;
            q11_d3 <=  q11_d2;
            q11_d4 <=  q11_d3;
            q11_d5 <=  q11_d4;
            q11_d6 <=  q11_d5;
            q11_d7 <=  q11_d6;
            q11_d8 <=  q11_d7;
            q11_d9 <=  q11_d8;
            q11_d10 <=  q11_d9;
            q11_d11 <=  q11_d10;
            w10_d1 <=  w10;
            q10_d1 <=  q10;
            q10_d2 <=  q10_d1;
            q10_d3 <=  q10_d2;
            q10_d4 <=  q10_d3;
            q10_d5 <=  q10_d4;
            q10_d6 <=  q10_d5;
            q10_d7 <=  q10_d6;
            q10_d8 <=  q10_d7;
            q10_d9 <=  q10_d8;
            q10_d10 <=  q10_d9;
            w9_d1 <=  w9;
            q9_d1 <=  q9;
            q9_d2 <=  q9_d1;
            q9_d3 <=  q9_d2;
            q9_d4 <=  q9_d3;
            q9_d5 <=  q9_d4;
            q9_d6 <=  q9_d5;
            q9_d7 <=  q9_d6;
            q9_d8 <=  q9_d7;
            q9_d9 <=  q9_d8;
            w8_d1 <=  w8;
            q8_d1 <=  q8;
            q8_d2 <=  q8_d1;
            q8_d3 <=  q8_d2;
            q8_d4 <=  q8_d3;
            q8_d5 <=  q8_d4;
            q8_d6 <=  q8_d5;
            q8_d7 <=  q8_d6;
            q8_d8 <=  q8_d7;
            w7_d1 <=  w7;
            q7_d1 <=  q7;
            q7_d2 <=  q7_d1;
            q7_d3 <=  q7_d2;
            q7_d4 <=  q7_d3;
            q7_d5 <=  q7_d4;
            q7_d6 <=  q7_d5;
            q7_d7 <=  q7_d6;
            w6_d1 <=  w6;
            q6_d1 <=  q6;
            q6_d2 <=  q6_d1;
            q6_d3 <=  q6_d2;
            q6_d4 <=  q6_d3;
            q6_d5 <=  q6_d4;
            q6_d6 <=  q6_d5;
            w5_d1 <=  w5;
            q5_d1 <=  q5;
            q5_d2 <=  q5_d1;
            q5_d3 <=  q5_d2;
            q5_d4 <=  q5_d3;
            q5_d5 <=  q5_d4;
            w4_d1 <=  w4;
            q4_d1 <=  q4;
            q4_d2 <=  q4_d1;
            q4_d3 <=  q4_d2;
            q4_d4 <=  q4_d3;
            w3_d1 <=  w3;
            q3_d1 <=  q3;
            q3_d2 <=  q3_d1;
            q3_d3 <=  q3_d2;
            w2_d1 <=  w2;
            q2_d1 <=  q2;
            q2_d2 <=  q2_d1;
            w1_d1 <=  w1;
            q1_d1 <=  q1;
            w0_d1 <=  w0;
            fR0_d1 <=  fR0;
            fRn1_d1 <=  fRn1;
            expR1_d1 <=  expR1;
            round_d1 <=  round;
         end if;
      end process;
   fX <= "1" & X(22 downto 0);
   fY <= "1" & Y(22 downto 0);
   -- exponent difference, sign and exception combination computed early, to have less bits to pipeline
   expR0 <= ("00" & X(30 downto 23)) - ("00" & Y(30 downto 23));
   sR <= X(31) xor Y(31);
   -- early exception handling 
   exnXY <= X(33 downto 32) & Y(33 downto 32);
   with exnXY select
      exnR0 <= 
         "01"  when "0101",                   -- normal
         "00"  when "0001" | "0010" | "0110", -- zero
         "10"  when "0100" | "1000" | "1001", -- overflow
         "11"  when others;                   -- NaN
    -- compute 3Y
   fYTimes3 <= ("00" & fY) + ("0" & fY & "0");
   w13 <=  "00" & fX;
   ----------------Synchro barrier, entering cycle 1----------------
   sel13 <= w13_d1(25 downto 22) & fY_d1(22);
   with sel13 select
   q13 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q13 select
      q13D <= 
         "000" & fY_d1            when "001" | "111",
         "00" & fY_d1 & "0"     when "010" | "110",
         "0" & fYTimes3_d1             when "011" | "101",
         (26 downto 0 => '0') when others;

   w13pad <= w13_d1 & "0";
   with q13(2) select
   w12full<= w13pad - q13D when '0',
         w13pad + q13D when others;

   w12 <= w12full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 2----------------
   sel12 <= w12_d1(25 downto 22) & fY_d2(22);
   with sel12 select
   q12 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q12 select
      q12D <= 
         "000" & fY_d2            when "001" | "111",
         "00" & fY_d2 & "0"     when "010" | "110",
         "0" & fYTimes3_d2             when "011" | "101",
         (26 downto 0 => '0') when others;

   w12pad <= w12_d1 & "0";
   with q12(2) select
   w11full<= w12pad - q12D when '0',
         w12pad + q12D when others;

   w11 <= w11full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 3----------------
   sel11 <= w11_d1(25 downto 22) & fY_d3(22);
   with sel11 select
   q11 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q11 select
      q11D <= 
         "000" & fY_d3            when "001" | "111",
         "00" & fY_d3 & "0"     when "010" | "110",
         "0" & fYTimes3_d3             when "011" | "101",
         (26 downto 0 => '0') when others;

   w11pad <= w11_d1 & "0";
   with q11(2) select
   w10full<= w11pad - q11D when '0',
         w11pad + q11D when others;

   w10 <= w10full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 4----------------
   sel10 <= w10_d1(25 downto 22) & fY_d4(22);
   with sel10 select
   q10 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q10 select
      q10D <= 
         "000" & fY_d4            when "001" | "111",
         "00" & fY_d4 & "0"     when "010" | "110",
         "0" & fYTimes3_d4             when "011" | "101",
         (26 downto 0 => '0') when others;

   w10pad <= w10_d1 & "0";
   with q10(2) select
   w9full<= w10pad - q10D when '0',
         w10pad + q10D when others;

   w9 <= w9full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 5----------------
   sel9 <= w9_d1(25 downto 22) & fY_d5(22);
   with sel9 select
   q9 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q9 select
      q9D <= 
         "000" & fY_d5            when "001" | "111",
         "00" & fY_d5 & "0"     when "010" | "110",
         "0" & fYTimes3_d5             when "011" | "101",
         (26 downto 0 => '0') when others;

   w9pad <= w9_d1 & "0";
   with q9(2) select
   w8full<= w9pad - q9D when '0',
         w9pad + q9D when others;

   w8 <= w8full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 6----------------
   sel8 <= w8_d1(25 downto 22) & fY_d6(22);
   with sel8 select
   q8 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q8 select
      q8D <= 
         "000" & fY_d6            when "001" | "111",
         "00" & fY_d6 & "0"     when "010" | "110",
         "0" & fYTimes3_d6             when "011" | "101",
         (26 downto 0 => '0') when others;

   w8pad <= w8_d1 & "0";
   with q8(2) select
   w7full<= w8pad - q8D when '0',
         w8pad + q8D when others;

   w7 <= w7full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 7----------------
   sel7 <= w7_d1(25 downto 22) & fY_d7(22);
   with sel7 select
   q7 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q7 select
      q7D <= 
         "000" & fY_d7            when "001" | "111",
         "00" & fY_d7 & "0"     when "010" | "110",
         "0" & fYTimes3_d7             when "011" | "101",
         (26 downto 0 => '0') when others;

   w7pad <= w7_d1 & "0";
   with q7(2) select
   w6full<= w7pad - q7D when '0',
         w7pad + q7D when others;

   w6 <= w6full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 8----------------
   sel6 <= w6_d1(25 downto 22) & fY_d8(22);
   with sel6 select
   q6 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q6 select
      q6D <= 
         "000" & fY_d8            when "001" | "111",
         "00" & fY_d8 & "0"     when "010" | "110",
         "0" & fYTimes3_d8             when "011" | "101",
         (26 downto 0 => '0') when others;

   w6pad <= w6_d1 & "0";
   with q6(2) select
   w5full<= w6pad - q6D when '0',
         w6pad + q6D when others;

   w5 <= w5full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 9----------------
   sel5 <= w5_d1(25 downto 22) & fY_d9(22);
   with sel5 select
   q5 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q5 select
      q5D <= 
         "000" & fY_d9            when "001" | "111",
         "00" & fY_d9 & "0"     when "010" | "110",
         "0" & fYTimes3_d9             when "011" | "101",
         (26 downto 0 => '0') when others;

   w5pad <= w5_d1 & "0";
   with q5(2) select
   w4full<= w5pad - q5D when '0',
         w5pad + q5D when others;

   w4 <= w4full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 10----------------
   sel4 <= w4_d1(25 downto 22) & fY_d10(22);
   with sel4 select
   q4 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q4 select
      q4D <= 
         "000" & fY_d10            when "001" | "111",
         "00" & fY_d10 & "0"     when "010" | "110",
         "0" & fYTimes3_d10             when "011" | "101",
         (26 downto 0 => '0') when others;

   w4pad <= w4_d1 & "0";
   with q4(2) select
   w3full<= w4pad - q4D when '0',
         w4pad + q4D when others;

   w3 <= w3full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 11----------------
   sel3 <= w3_d1(25 downto 22) & fY_d11(22);
   with sel3 select
   q3 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q3 select
      q3D <= 
         "000" & fY_d11            when "001" | "111",
         "00" & fY_d11 & "0"     when "010" | "110",
         "0" & fYTimes3_d11             when "011" | "101",
         (26 downto 0 => '0') when others;

   w3pad <= w3_d1 & "0";
   with q3(2) select
   w2full<= w3pad - q3D when '0',
         w3pad + q3D when others;

   w2 <= w2full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 12----------------
   sel2 <= w2_d1(25 downto 22) & fY_d12(22);
   with sel2 select
   q2 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q2 select
      q2D <= 
         "000" & fY_d12            when "001" | "111",
         "00" & fY_d12 & "0"     when "010" | "110",
         "0" & fYTimes3_d12             when "011" | "101",
         (26 downto 0 => '0') when others;

   w2pad <= w2_d1 & "0";
   with q2(2) select
   w1full<= w2pad - q2D when '0',
         w2pad + q2D when others;

   w1 <= w1full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 13----------------
   sel1 <= w1_d1(25 downto 22) & fY_d13(22);
   with sel1 select
   q1 <= 
      "001" when "00010" | "00011",
      "010" when "00100" | "00101" | "00111",
      "011" when "00110" | "01000" | "01001" | "01010" | "01011" | "01101" | "01111",
      "101" when "11000" | "10110" | "10111" | "10100" | "10101" | "10011" | "10001",
      "110" when "11010" | "11011" | "11001",
      "111" when "11100" | "11101",
      "000" when others;

   with q1 select
      q1D <= 
         "000" & fY_d13            when "001" | "111",
         "00" & fY_d13 & "0"     when "010" | "110",
         "0" & fYTimes3_d13             when "011" | "101",
         (26 downto 0 => '0') when others;

   w1pad <= w1_d1 & "0";
   with q1(2) select
   w0full<= w1pad - q1D when '0',
         w1pad + q1D when others;

   w0 <= w0full(24 downto 0) & "0";
   ----------------Synchro barrier, entering cycle 14----------------
   q0(2 downto 0) <= "000" when  w0_d1 = (25 downto 0 => '0')
                else w0_d1(25) & "10";
   qP13 <=      q13_d13(1 downto 0);
   qM13 <=      q13_d13(2) & "0";
   qP12 <=      q12_d12(1 downto 0);
   qM12 <=      q12_d12(2) & "0";
   qP11 <=      q11_d11(1 downto 0);
   qM11 <=      q11_d11(2) & "0";
   qP10 <=      q10_d10(1 downto 0);
   qM10 <=      q10_d10(2) & "0";
   qP9 <=      q9_d9(1 downto 0);
   qM9 <=      q9_d9(2) & "0";
   qP8 <=      q8_d8(1 downto 0);
   qM8 <=      q8_d8(2) & "0";
   qP7 <=      q7_d7(1 downto 0);
   qM7 <=      q7_d7(2) & "0";
   qP6 <=      q6_d6(1 downto 0);
   qM6 <=      q6_d6(2) & "0";
   qP5 <=      q5_d5(1 downto 0);
   qM5 <=      q5_d5(2) & "0";
   qP4 <=      q4_d4(1 downto 0);
   qM4 <=      q4_d4(2) & "0";
   qP3 <=      q3_d3(1 downto 0);
   qM3 <=      q3_d3(2) & "0";
   qP2 <=      q2_d2(1 downto 0);
   qM2 <=      q2_d2(2) & "0";
   qP1 <=      q1_d1(1 downto 0);
   qM1 <=      q1_d1(2) & "0";
   qP0 <= q0(1 downto 0);
   qM0 <= q0(2)  & "0";
   qP <= qP13 & qP12 & qP11 & qP10 & qP9 & qP8 & qP7 & qP6 & qP5 & qP4 & qP3 & qP2 & qP1 & qP0;
   qM <= qM13(0) & qM12 & qM11 & qM10 & qM9 & qM8 & qM7 & qM6 & qM5 & qM4 & qM3 & qM2 & qM1 & qM0 & "0";
   fR0 <= qP - qM;
   ----------------Synchro barrier, entering cycle 15----------------
   fR <= fR0_d1(27 downto 1);  -- odd wF
   -- normalisation
   with fR(26) select
      fRn1 <= fR(25 downto 2) & (fR(1) or fR(0)) when '1',
              fR(24 downto 0)                    when others;
   expR1 <= expR0_d15 + ("000" & (6 downto 1 => '1') & fR(26)); -- add back bias
   round <= fRn1(1) and (fRn1(2) or fRn1(0)); -- fRn1(0) is the sticky bit
   ----------------Synchro barrier, entering cycle 16----------------
   -- final rounding
   expfrac <= expR1_d1 & fRn1_d1(24 downto 2) ;
   expfracR <= expfrac + ((32 downto 1 => '0') & round_d1);
   exnR <=      "00"  when expfracR(32) = '1'   -- underflow
           else "10"  when  expfracR(32 downto 31) =  "01" -- overflow
           else "01";      -- 00, normal case
   with exnR0_d16 select
      exnRfinal <= 
         exnR   when "01", -- normal
         exnR0_d16  when others;
   R <= exnRfinal & sR_d16 & expfracR(30 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                             FPDiv_8_23_Wrapper
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2007)
--------------------------------------------------------------------------------
-- Pipeline depth: 18 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity divf_internal is
   port (
     clk   : in  std_logic;
     reset : in  std_logic;
     start : in  std_logic;
     X     : in  std_logic_vector(33 downto 0);
     Y     : in  std_logic_vector(33 downto 0);
     R     : out std_logic_vector(33 downto 0);
     done  : out std_logic;
     ready : out std_logic
  );
end entity divf_internal;

architecture arch of divf_internal is
  component FPDiv_8_23 is
    port ( 
      clk : in  std_logic;
      rst : in  std_logic;
      X   : in  std_logic_vector(8+23+2 downto 0);
      Y   : in  std_logic_vector(8+23+2 downto 0);
      R   : out std_logic_vector(8+23+2 downto 0)  
    );
  end component;
  --   
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_001_005, S_001_006, 
    S_001_007, S_001_008, S_001_009, S_001_010, S_001_011, S_001_012, 
    S_001_013, S_001_014, S_001_015, S_001_016, S_001_017, S_001_018);
  signal current_state, next_state : state_type;
  signal i_X, i_X_d1 : std_logic_vector(33 downto 0);
  signal i_Y, i_Y_d1 : std_logic_vector(33 downto 0);
  signal o_R, o_R_d1 : std_logic_vector(33 downto 0);
begin

  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      i_X_d1 <=  i_X;
      i_Y_d1 <=  i_Y;
      o_R_d1 <=  o_R;      
    end if;
  end process;
  
  i_X <= X;
  i_Y <= Y;  

  -- next state and output logic
  process (current_state, start)
  begin
    done <= '0';
    ready <= '0';
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        next_state <= S_001_002; 
      when S_001_002 =>
        next_state <= S_001_003; 
      when S_001_003 =>
        next_state <= S_001_004; 
      when S_001_004 =>        
        next_state <= S_001_005; 
      when S_001_005 =>        
        next_state <= S_001_006; 
      when S_001_006 =>        
        next_state <= S_001_007; 
      when S_001_007 =>        
        next_state <= S_001_008; 
      when S_001_008 =>        
        next_state <= S_001_009; 
      when S_001_009 =>
        next_state <= S_001_010;
      when S_001_010 =>        
        next_state <= S_001_011; 
      when S_001_011 =>        
        next_state <= S_001_012; 
      when S_001_012 =>        
        next_state <= S_001_013; 
      when S_001_013 =>        
        next_state <= S_001_014; 
      when S_001_014 =>        
        next_state <= S_001_015; 
      when S_001_015 =>        
        next_state <= S_001_016; 
      when S_001_016 =>        
        next_state <= S_001_017; 
      when S_001_017 =>        
        next_state <= S_001_018; 
      when S_001_018 =>        
        next_state <= S_EXIT; 
      when S_EXIT =>
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

   ----------------Synchro barrier, entering cycle 1----------------
   test: FPDiv_8_23  -- pipelineDepth=16 maxInDelay=0
      port map ( 
        clk => clk,
        rst => reset,
        R   => o_R,
        X   => i_X_d1,
        Y   => i_Y_d1
      );
                 
   ----------------Synchro barrier, entering cycle 18---------------
   R <= o_R_d1;

end architecture arch;

--------------------------------------------------------------------------------
--                           InputIEEE_8_23_to_8_23
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2008)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InputIEEE_8_23_to_8_23 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(31 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of InputIEEE_8_23_to_8_23 is
signal expX, expX_d1 :  std_logic_vector(7 downto 0);
signal fracX :  std_logic_vector(22 downto 0);
signal sX, sX_d1 : std_logic;
signal expZero, expZero_d1 : std_logic;
signal expInfty, expInfty_d1 : std_logic;
signal fracZero, fracZero_d1 : std_logic;
signal reprSubNormal, reprSubNormal_d1 : std_logic;
signal sfracX, sfracX_d1 :  std_logic_vector(22 downto 0);
signal fracR :  std_logic_vector(22 downto 0);
signal expR :  std_logic_vector(7 downto 0);
signal infinity : std_logic;
signal zero : std_logic;
signal NaN : std_logic;
signal exnR :  std_logic_vector(1 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            expX_d1 <=  expX;
            sX_d1 <=  sX;
            expZero_d1 <=  expZero;
            expInfty_d1 <=  expInfty;
            fracZero_d1 <=  fracZero;
            reprSubNormal_d1 <=  reprSubNormal;
            sfracX_d1 <=  sfracX;
         end if;
      end process;
   expX  <= X(30 downto 23);
   fracX  <= X(22 downto 0);
   sX  <= X(31);
   expZero  <= '1' when expX = (7 downto 0 => '0') else '0';
   expInfty  <= '1' when expX = (7 downto 0 => '1') else '0';
   fracZero <= '1' when fracX = (22 downto 0 => '0') else '0';
   reprSubNormal <= fracX(22);
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   sfracX <= fracX(21 downto 0) & '0' when (expZero='1' and reprSubNormal='1')    else fracX;
   ----------------Synchro barrier, entering cycle 1----------------
   fracR <= sfracX_d1;
   -- copy exponent. This will be OK even for subnormals, zero and infty since in such cases the exn bits will prevail
   expR <= expX_d1;
   infinity <= expInfty_d1 and fracZero_d1;
   zero <= expZero_d1 and not reprSubNormal_d1;
   NaN <= expInfty_d1 and not fracZero_d1;
   exnR <= 
           "00" when zero='1' 
      else "10" when infinity='1' 
      else "11" when NaN='1'
      else "01" ;  -- normal number
   R <= exnR & sX_d1 & expR & fracR;
end architecture arch;

--------------------------------------------------------------------------------
--                          OutputIEEE_8_23_to_8_23
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved
-- Authors: F. Ferrandi  (2009)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity OutputIEEE_8_23_to_8_23 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of OutputIEEE_8_23_to_8_23 is
signal expX, expX_d1 :  std_logic_vector(7 downto 0);
signal fracX, fracX_d1 :  std_logic_vector(22 downto 0);
signal sX, sX_d1 : std_logic;
signal exnX, exnX_d1 :  std_logic_vector(1 downto 0);
signal expZero, expZero_d1 : std_logic;
signal sfracX :  std_logic_vector(22 downto 0);
signal fracR :  std_logic_vector(22 downto 0);
signal expR :  std_logic_vector(7 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            expX_d1 <=  expX;
            fracX_d1 <=  fracX;
            sX_d1 <=  sX;
            exnX_d1 <=  exnX;
            expZero_d1 <=  expZero;
         end if;
      end process;
   expX  <= X(30 downto 23);
   fracX  <= X(22 downto 0);
   sX  <= X(31);
   exnX  <= X(33 downto 32);
   expZero  <= '1' when expX = (7 downto 0 => '0') else '0';
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   ----------------Synchro barrier, entering cycle 1----------------
   sfracX <= 
      (22 downto 0 => '0') when (exnX_d1 = "00") else
      '1' & fracX_d1(22 downto 1) when (expZero_d1 = '1' and exnX_d1 = "01") else
      fracX_d1 when (exnX_d1 = "01") else 
      (22 downto 1 => '0') & exnX_d1(0);
   fracR <= sfracX;
   expR <=
      (7 downto 0 => '0') when (exnX_d1 = "00") else
      expX_d1 when (exnX_d1 = "01") else
      (7 downto 0 => '1');
   R <= sX_d1 & expR & fracR;
end architecture arch;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.fixed_float_types.all;
use WORK.fixed_pkg.all;
use WORK.float_pkg.all;

entity divf is
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    start : in  std_logic;
    a     : in  float32;
    b     : in  float32;
    y     : out float32;
    done  : out std_logic;
    ready : out std_logic
  );
end divf;

architecture fsmd of divf is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_002_001, S_002_002, S_002_003, S_003_001);
  signal current_state, next_state: state_type;
  signal a_flopoco : std_logic_vector(8+23+2 downto 0);
  signal b_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco_eval : std_logic_vector(8+23+2 downto 0); 
  signal a_ieee    : std_logic_vector(31 downto 0);
  signal b_ieee    : std_logic_vector(31 downto 0);
  signal y_ieee    : std_logic_vector(31 downto 0);
  signal divf_0_start : std_logic;
  signal divf_0_done  : std_logic;
  signal divf_0_ready : std_logic;
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    a,
    b,
    divf_0_start, divf_0_ready, divf_0_done
  )
  begin
    done <= '0';
    ready <= '0';
    divf_0_start <= '0';
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          a_ieee <= to_std_logic_vector(a);
          b_ieee <= to_std_logic_vector(b);
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        next_state <= S_001_002;
      when S_001_002 =>
        divf_0_start <= '1';
        next_state <= S_001_003;
      when S_001_003 =>
        if ((divf_0_ready = '1') and (divf_0_start = '0')) then
          y_flopoco <= y_flopoco_eval;
          next_state <= S_001_004;
        else
          next_state <= S_001_003;
        end if;
      when S_001_004 =>
        next_state <= S_002_001;         
      when S_002_001 =>        
        y <= to_float(y_ieee, 8, 23);
        next_state <= S_EXIT; 
      when S_EXIT =>        
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;
 
  a_ieee2flopoco_0 : entity WORK.InputIEEE_8_23_to_8_23(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => a_ieee,
      R   => a_flopoco
    );

  b_ieee2flopoco_0 : entity WORK.InputIEEE_8_23_to_8_23(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => b_ieee,
      R   => b_flopoco
    );
    
  divf_internal_0 : entity WORK.divf_internal(arch)
    port map (
      clk,
      reset,
      divf_0_start,
      a_flopoco,
      b_flopoco,
      y_flopoco_eval,
      divf_0_done,
      divf_0_ready
    );
    
  y_flopoco2ieee_0 : entity WORK.OutputIEEE_8_23_to_8_23(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => y_flopoco,
      R   => y_ieee
    );
    
end fsmd;
