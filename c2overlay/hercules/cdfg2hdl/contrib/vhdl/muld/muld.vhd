--------------------------------------------------------------------------------
--                           IntAdder_42_f200_uid11
--                     (IntAdderClassical_42_f200_uid13)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_42_f200_uid11 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(41 downto 0);
          Y : in  std_logic_vector(41 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(41 downto 0)   );
end entity;

architecture arch of IntAdder_42_f200_uid11 is
signal X_d1 :  std_logic_vector(41 downto 0);
signal Y_d1 :  std_logic_vector(41 downto 0);
signal Cin_d1 : std_logic;
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            X_d1 <=  X;
            Y_d1 <=  Y;
            Cin_d1 <=  Cin;
         end if;
      end process;
   --Classical
   ----------------Synchro barrier, entering cycle 1----------------
    R <= X_d1 + Y_d1 + Cin_d1;
end architecture;

--------------------------------------------------------------------------------
--                       IntMultiAdder_42_op4_f200_uid7
--                       (IntCompressorTree_42_4_uid9)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2009-2011)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiAdder_42_op4_f200_uid7 is
   port ( clk, rst : in std_logic;
          X0 : in  std_logic_vector(41 downto 0);
          X1 : in  std_logic_vector(41 downto 0);
          X2 : in  std_logic_vector(41 downto 0);
          X3 : in  std_logic_vector(41 downto 0);
          R : out  std_logic_vector(41 downto 0)   );
end entity;

architecture arch of IntMultiAdder_42_op4_f200_uid7 is
   component IntAdder_42_f200_uid11 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(41 downto 0);
             Y : in  std_logic_vector(41 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(41 downto 0)   );
   end component;

signal l_0_s_0 :  std_logic_vector(41 downto 0);
signal l_0_s_1 :  std_logic_vector(41 downto 0);
signal l_0_s_2 :  std_logic_vector(41 downto 0);
signal l_0_s_3 :  std_logic_vector(41 downto 0);
signal sell_1_c_0_cl_0 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_0 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_1 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_1 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_2 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_2 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_3 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_3 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_4 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_4 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_5 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_5 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_6 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_6 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_7 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_7 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_8 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_8 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_9 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_9 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_10 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_10 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_11 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_11 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_12 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_12 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_13 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_13 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_14 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_14 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_15 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_15 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_16 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_16 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_17 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_17 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_18 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_18 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_19 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_19 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_20 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_20 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_21 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_21 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_22 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_22 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_23 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_23 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_24 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_24 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_25 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_25 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_26 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_26 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_27 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_27 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_28 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_28 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_29 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_29 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_30 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_30 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_31 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_31 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_32 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_32 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_33 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_33 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_34 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_34 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_35 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_35 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_36 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_36 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_37 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_37 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_38 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_38 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_39 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_39 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_40 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_40 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_41 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_41 :  std_logic_vector(2 downto 0);
signal l_1_s_0 :  std_logic_vector(41 downto 0);
signal l_1_s_1 :  std_logic_vector(41 downto 0);
signal l_1_s_2 :  std_logic_vector(41 downto 0);
signal sell_2_c_0_cl_0 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_0 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_1 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_1 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_2 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_2 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_3 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_3 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_4 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_4 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_5 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_5 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_6 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_6 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_7 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_7 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_8 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_8 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_9 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_9 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_10 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_10 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_11 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_11 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_12 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_12 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_13 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_13 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_14 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_14 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_15 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_15 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_16 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_16 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_17 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_17 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_18 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_18 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_19 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_19 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_20 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_20 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_21 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_21 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_22 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_22 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_23 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_23 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_24 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_24 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_25 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_25 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_26 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_26 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_27 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_27 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_28 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_28 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_29 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_29 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_30 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_30 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_31 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_31 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_32 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_32 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_33 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_33 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_34 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_34 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_35 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_35 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_36 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_36 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_37 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_37 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_38 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_38 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_39 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_39 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_40 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_40 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_41 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_41 :  std_logic_vector(1 downto 0);
signal l_2_s_0 :  std_logic_vector(41 downto 0);
signal l_2_s_1 :  std_logic_vector(41 downto 0);
signal myR :  std_logic_vector(41 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   l_0_s_0 <= X0;
   l_0_s_1 <= X1;
   l_0_s_2 <= X2;
   l_0_s_3 <= X3;
   sell_1_c_0_cl_0 <= l_0_s_0(0) & l_0_s_1(0) & l_0_s_2(0) & l_0_s_3(0);
    with sell_1_c_0_cl_0 select
   l_1_c_0_cl_0 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_1 <= l_0_s_0(1) & l_0_s_1(1) & l_0_s_2(1) & l_0_s_3(1);
    with sell_1_c_0_cl_1 select
   l_1_c_0_cl_1 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_2 <= l_0_s_0(2) & l_0_s_1(2) & l_0_s_2(2) & l_0_s_3(2);
    with sell_1_c_0_cl_2 select
   l_1_c_0_cl_2 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_3 <= l_0_s_0(3) & l_0_s_1(3) & l_0_s_2(3) & l_0_s_3(3);
    with sell_1_c_0_cl_3 select
   l_1_c_0_cl_3 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_4 <= l_0_s_0(4) & l_0_s_1(4) & l_0_s_2(4) & l_0_s_3(4);
    with sell_1_c_0_cl_4 select
   l_1_c_0_cl_4 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_5 <= l_0_s_0(5) & l_0_s_1(5) & l_0_s_2(5) & l_0_s_3(5);
    with sell_1_c_0_cl_5 select
   l_1_c_0_cl_5 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_6 <= l_0_s_0(6) & l_0_s_1(6) & l_0_s_2(6) & l_0_s_3(6);
    with sell_1_c_0_cl_6 select
   l_1_c_0_cl_6 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_7 <= l_0_s_0(7) & l_0_s_1(7) & l_0_s_2(7) & l_0_s_3(7);
    with sell_1_c_0_cl_7 select
   l_1_c_0_cl_7 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_8 <= l_0_s_0(8) & l_0_s_1(8) & l_0_s_2(8) & l_0_s_3(8);
    with sell_1_c_0_cl_8 select
   l_1_c_0_cl_8 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_9 <= l_0_s_0(9) & l_0_s_1(9) & l_0_s_2(9) & l_0_s_3(9);
    with sell_1_c_0_cl_9 select
   l_1_c_0_cl_9 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_10 <= l_0_s_0(10) & l_0_s_1(10) & l_0_s_2(10) & l_0_s_3(10);
    with sell_1_c_0_cl_10 select
   l_1_c_0_cl_10 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_11 <= l_0_s_0(11) & l_0_s_1(11) & l_0_s_2(11) & l_0_s_3(11);
    with sell_1_c_0_cl_11 select
   l_1_c_0_cl_11 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_12 <= l_0_s_0(12) & l_0_s_1(12) & l_0_s_2(12) & l_0_s_3(12);
    with sell_1_c_0_cl_12 select
   l_1_c_0_cl_12 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_13 <= l_0_s_0(13) & l_0_s_1(13) & l_0_s_2(13) & l_0_s_3(13);
    with sell_1_c_0_cl_13 select
   l_1_c_0_cl_13 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_14 <= l_0_s_0(14) & l_0_s_1(14) & l_0_s_2(14) & l_0_s_3(14);
    with sell_1_c_0_cl_14 select
   l_1_c_0_cl_14 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_15 <= l_0_s_0(15) & l_0_s_1(15) & l_0_s_2(15) & l_0_s_3(15);
    with sell_1_c_0_cl_15 select
   l_1_c_0_cl_15 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_16 <= l_0_s_0(16) & l_0_s_1(16) & l_0_s_2(16) & l_0_s_3(16);
    with sell_1_c_0_cl_16 select
   l_1_c_0_cl_16 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_17 <= l_0_s_0(17) & l_0_s_1(17) & l_0_s_2(17) & l_0_s_3(17);
    with sell_1_c_0_cl_17 select
   l_1_c_0_cl_17 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_18 <= l_0_s_0(18) & l_0_s_1(18) & l_0_s_2(18) & l_0_s_3(18);
    with sell_1_c_0_cl_18 select
   l_1_c_0_cl_18 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_19 <= l_0_s_0(19) & l_0_s_1(19) & l_0_s_2(19) & l_0_s_3(19);
    with sell_1_c_0_cl_19 select
   l_1_c_0_cl_19 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_20 <= l_0_s_0(20) & l_0_s_1(20) & l_0_s_2(20) & l_0_s_3(20);
    with sell_1_c_0_cl_20 select
   l_1_c_0_cl_20 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_21 <= l_0_s_0(21) & l_0_s_1(21) & l_0_s_2(21) & l_0_s_3(21);
    with sell_1_c_0_cl_21 select
   l_1_c_0_cl_21 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_22 <= l_0_s_0(22) & l_0_s_1(22) & l_0_s_2(22) & l_0_s_3(22);
    with sell_1_c_0_cl_22 select
   l_1_c_0_cl_22 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_23 <= l_0_s_0(23) & l_0_s_1(23) & l_0_s_2(23) & l_0_s_3(23);
    with sell_1_c_0_cl_23 select
   l_1_c_0_cl_23 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_24 <= l_0_s_0(24) & l_0_s_1(24) & l_0_s_2(24) & l_0_s_3(24);
    with sell_1_c_0_cl_24 select
   l_1_c_0_cl_24 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_25 <= l_0_s_0(25) & l_0_s_1(25) & l_0_s_2(25) & l_0_s_3(25);
    with sell_1_c_0_cl_25 select
   l_1_c_0_cl_25 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_26 <= l_0_s_0(26) & l_0_s_1(26) & l_0_s_2(26) & l_0_s_3(26);
    with sell_1_c_0_cl_26 select
   l_1_c_0_cl_26 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_27 <= l_0_s_0(27) & l_0_s_1(27) & l_0_s_2(27) & l_0_s_3(27);
    with sell_1_c_0_cl_27 select
   l_1_c_0_cl_27 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_28 <= l_0_s_0(28) & l_0_s_1(28) & l_0_s_2(28) & l_0_s_3(28);
    with sell_1_c_0_cl_28 select
   l_1_c_0_cl_28 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_29 <= l_0_s_0(29) & l_0_s_1(29) & l_0_s_2(29) & l_0_s_3(29);
    with sell_1_c_0_cl_29 select
   l_1_c_0_cl_29 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_30 <= l_0_s_0(30) & l_0_s_1(30) & l_0_s_2(30) & l_0_s_3(30);
    with sell_1_c_0_cl_30 select
   l_1_c_0_cl_30 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_31 <= l_0_s_0(31) & l_0_s_1(31) & l_0_s_2(31) & l_0_s_3(31);
    with sell_1_c_0_cl_31 select
   l_1_c_0_cl_31 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_32 <= l_0_s_0(32) & l_0_s_1(32) & l_0_s_2(32) & l_0_s_3(32);
    with sell_1_c_0_cl_32 select
   l_1_c_0_cl_32 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_33 <= l_0_s_0(33) & l_0_s_1(33) & l_0_s_2(33) & l_0_s_3(33);
    with sell_1_c_0_cl_33 select
   l_1_c_0_cl_33 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_34 <= l_0_s_0(34) & l_0_s_1(34) & l_0_s_2(34) & l_0_s_3(34);
    with sell_1_c_0_cl_34 select
   l_1_c_0_cl_34 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_35 <= l_0_s_0(35) & l_0_s_1(35) & l_0_s_2(35) & l_0_s_3(35);
    with sell_1_c_0_cl_35 select
   l_1_c_0_cl_35 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_36 <= l_0_s_0(36) & l_0_s_1(36) & l_0_s_2(36) & l_0_s_3(36);
    with sell_1_c_0_cl_36 select
   l_1_c_0_cl_36 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_37 <= l_0_s_0(37) & l_0_s_1(37) & l_0_s_2(37) & l_0_s_3(37);
    with sell_1_c_0_cl_37 select
   l_1_c_0_cl_37 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_38 <= l_0_s_0(38) & l_0_s_1(38) & l_0_s_2(38) & l_0_s_3(38);
    with sell_1_c_0_cl_38 select
   l_1_c_0_cl_38 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_39 <= l_0_s_0(39) & l_0_s_1(39) & l_0_s_2(39) & l_0_s_3(39);
    with sell_1_c_0_cl_39 select
   l_1_c_0_cl_39 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_40 <= l_0_s_0(40) & l_0_s_1(40) & l_0_s_2(40) & l_0_s_3(40);
    with sell_1_c_0_cl_40 select
   l_1_c_0_cl_40 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_41 <= l_0_s_0(41) & l_0_s_1(41) & l_0_s_2(41) & l_0_s_3(41);
    with sell_1_c_0_cl_41 select
   l_1_c_0_cl_41 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   l_1_s_0 <= l_1_c_0_cl_41(0 downto 0) & l_1_c_0_cl_40(0 downto 0) & l_1_c_0_cl_39(0 downto 0) & l_1_c_0_cl_38(0 downto 0) & l_1_c_0_cl_37(0 downto 0) & l_1_c_0_cl_36(0 downto 0) & l_1_c_0_cl_35(0 downto 0) & l_1_c_0_cl_34(0 downto 0) & l_1_c_0_cl_33(0 downto 0) & l_1_c_0_cl_32(0 downto 0) & l_1_c_0_cl_31(0 downto 0) & l_1_c_0_cl_30(0 downto 0) & l_1_c_0_cl_29(0 downto 0) & l_1_c_0_cl_28(0 downto 0) & l_1_c_0_cl_27(0 downto 0) & l_1_c_0_cl_26(0 downto 0) & l_1_c_0_cl_25(0 downto 0) & l_1_c_0_cl_24(0 downto 0) & l_1_c_0_cl_23(0 downto 0) & l_1_c_0_cl_22(0 downto 0) & l_1_c_0_cl_21(0 downto 0) & l_1_c_0_cl_20(0 downto 0) & l_1_c_0_cl_19(0 downto 0) & l_1_c_0_cl_18(0 downto 0) & l_1_c_0_cl_17(0 downto 0) & l_1_c_0_cl_16(0 downto 0) & l_1_c_0_cl_15(0 downto 0) & l_1_c_0_cl_14(0 downto 0) & l_1_c_0_cl_13(0 downto 0) & l_1_c_0_cl_12(0 downto 0) & l_1_c_0_cl_11(0 downto 0) & l_1_c_0_cl_10(0 downto 0) & l_1_c_0_cl_9(0 downto 0) & l_1_c_0_cl_8(0 downto 0) & l_1_c_0_cl_7(0 downto 0) & l_1_c_0_cl_6(0 downto 0) & l_1_c_0_cl_5(0 downto 0) & l_1_c_0_cl_4(0 downto 0) & l_1_c_0_cl_3(0 downto 0) & l_1_c_0_cl_2(0 downto 0) & l_1_c_0_cl_1(0 downto 0) & l_1_c_0_cl_0(0 downto 0);
   l_1_s_1 <= l_1_c_0_cl_40(1 downto 1) & l_1_c_0_cl_39(1 downto 1) & l_1_c_0_cl_38(1 downto 1) & l_1_c_0_cl_37(1 downto 1) & l_1_c_0_cl_36(1 downto 1) & l_1_c_0_cl_35(1 downto 1) & l_1_c_0_cl_34(1 downto 1) & l_1_c_0_cl_33(1 downto 1) & l_1_c_0_cl_32(1 downto 1) & l_1_c_0_cl_31(1 downto 1) & l_1_c_0_cl_30(1 downto 1) & l_1_c_0_cl_29(1 downto 1) & l_1_c_0_cl_28(1 downto 1) & l_1_c_0_cl_27(1 downto 1) & l_1_c_0_cl_26(1 downto 1) & l_1_c_0_cl_25(1 downto 1) & l_1_c_0_cl_24(1 downto 1) & l_1_c_0_cl_23(1 downto 1) & l_1_c_0_cl_22(1 downto 1) & l_1_c_0_cl_21(1 downto 1) & l_1_c_0_cl_20(1 downto 1) & l_1_c_0_cl_19(1 downto 1) & l_1_c_0_cl_18(1 downto 1) & l_1_c_0_cl_17(1 downto 1) & l_1_c_0_cl_16(1 downto 1) & l_1_c_0_cl_15(1 downto 1) & l_1_c_0_cl_14(1 downto 1) & l_1_c_0_cl_13(1 downto 1) & l_1_c_0_cl_12(1 downto 1) & l_1_c_0_cl_11(1 downto 1) & l_1_c_0_cl_10(1 downto 1) & l_1_c_0_cl_9(1 downto 1) & l_1_c_0_cl_8(1 downto 1) & l_1_c_0_cl_7(1 downto 1) & l_1_c_0_cl_6(1 downto 1) & l_1_c_0_cl_5(1 downto 1) & l_1_c_0_cl_4(1 downto 1) & l_1_c_0_cl_3(1 downto 1) & l_1_c_0_cl_2(1 downto 1) & l_1_c_0_cl_1(1 downto 1) & l_1_c_0_cl_0(1 downto 1) & "0";
   l_1_s_2 <= l_1_c_0_cl_39(2 downto 2) & l_1_c_0_cl_38(2 downto 2) & l_1_c_0_cl_37(2 downto 2) & l_1_c_0_cl_36(2 downto 2) & l_1_c_0_cl_35(2 downto 2) & l_1_c_0_cl_34(2 downto 2) & l_1_c_0_cl_33(2 downto 2) & l_1_c_0_cl_32(2 downto 2) & l_1_c_0_cl_31(2 downto 2) & l_1_c_0_cl_30(2 downto 2) & l_1_c_0_cl_29(2 downto 2) & l_1_c_0_cl_28(2 downto 2) & l_1_c_0_cl_27(2 downto 2) & l_1_c_0_cl_26(2 downto 2) & l_1_c_0_cl_25(2 downto 2) & l_1_c_0_cl_24(2 downto 2) & l_1_c_0_cl_23(2 downto 2) & l_1_c_0_cl_22(2 downto 2) & l_1_c_0_cl_21(2 downto 2) & l_1_c_0_cl_20(2 downto 2) & l_1_c_0_cl_19(2 downto 2) & l_1_c_0_cl_18(2 downto 2) & l_1_c_0_cl_17(2 downto 2) & l_1_c_0_cl_16(2 downto 2) & l_1_c_0_cl_15(2 downto 2) & l_1_c_0_cl_14(2 downto 2) & l_1_c_0_cl_13(2 downto 2) & l_1_c_0_cl_12(2 downto 2) & l_1_c_0_cl_11(2 downto 2) & l_1_c_0_cl_10(2 downto 2) & l_1_c_0_cl_9(2 downto 2) & l_1_c_0_cl_8(2 downto 2) & l_1_c_0_cl_7(2 downto 2) & l_1_c_0_cl_6(2 downto 2) & l_1_c_0_cl_5(2 downto 2) & l_1_c_0_cl_4(2 downto 2) & l_1_c_0_cl_3(2 downto 2) & l_1_c_0_cl_2(2 downto 2) & l_1_c_0_cl_1(2 downto 2) & l_1_c_0_cl_0(2 downto 2) & "00";
   sell_2_c_0_cl_0 <= l_1_s_0(0) & l_1_s_1(0) & l_1_s_2(0);
    with sell_2_c_0_cl_0 select
   l_2_c_0_cl_0 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_1 <= l_1_s_0(1) & l_1_s_1(1) & l_1_s_2(1);
    with sell_2_c_0_cl_1 select
   l_2_c_0_cl_1 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_2 <= l_1_s_0(2) & l_1_s_1(2) & l_1_s_2(2);
    with sell_2_c_0_cl_2 select
   l_2_c_0_cl_2 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_3 <= l_1_s_0(3) & l_1_s_1(3) & l_1_s_2(3);
    with sell_2_c_0_cl_3 select
   l_2_c_0_cl_3 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_4 <= l_1_s_0(4) & l_1_s_1(4) & l_1_s_2(4);
    with sell_2_c_0_cl_4 select
   l_2_c_0_cl_4 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_5 <= l_1_s_0(5) & l_1_s_1(5) & l_1_s_2(5);
    with sell_2_c_0_cl_5 select
   l_2_c_0_cl_5 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_6 <= l_1_s_0(6) & l_1_s_1(6) & l_1_s_2(6);
    with sell_2_c_0_cl_6 select
   l_2_c_0_cl_6 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_7 <= l_1_s_0(7) & l_1_s_1(7) & l_1_s_2(7);
    with sell_2_c_0_cl_7 select
   l_2_c_0_cl_7 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_8 <= l_1_s_0(8) & l_1_s_1(8) & l_1_s_2(8);
    with sell_2_c_0_cl_8 select
   l_2_c_0_cl_8 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_9 <= l_1_s_0(9) & l_1_s_1(9) & l_1_s_2(9);
    with sell_2_c_0_cl_9 select
   l_2_c_0_cl_9 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_10 <= l_1_s_0(10) & l_1_s_1(10) & l_1_s_2(10);
    with sell_2_c_0_cl_10 select
   l_2_c_0_cl_10 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_11 <= l_1_s_0(11) & l_1_s_1(11) & l_1_s_2(11);
    with sell_2_c_0_cl_11 select
   l_2_c_0_cl_11 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_12 <= l_1_s_0(12) & l_1_s_1(12) & l_1_s_2(12);
    with sell_2_c_0_cl_12 select
   l_2_c_0_cl_12 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_13 <= l_1_s_0(13) & l_1_s_1(13) & l_1_s_2(13);
    with sell_2_c_0_cl_13 select
   l_2_c_0_cl_13 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_14 <= l_1_s_0(14) & l_1_s_1(14) & l_1_s_2(14);
    with sell_2_c_0_cl_14 select
   l_2_c_0_cl_14 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_15 <= l_1_s_0(15) & l_1_s_1(15) & l_1_s_2(15);
    with sell_2_c_0_cl_15 select
   l_2_c_0_cl_15 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_16 <= l_1_s_0(16) & l_1_s_1(16) & l_1_s_2(16);
    with sell_2_c_0_cl_16 select
   l_2_c_0_cl_16 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_17 <= l_1_s_0(17) & l_1_s_1(17) & l_1_s_2(17);
    with sell_2_c_0_cl_17 select
   l_2_c_0_cl_17 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_18 <= l_1_s_0(18) & l_1_s_1(18) & l_1_s_2(18);
    with sell_2_c_0_cl_18 select
   l_2_c_0_cl_18 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_19 <= l_1_s_0(19) & l_1_s_1(19) & l_1_s_2(19);
    with sell_2_c_0_cl_19 select
   l_2_c_0_cl_19 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_20 <= l_1_s_0(20) & l_1_s_1(20) & l_1_s_2(20);
    with sell_2_c_0_cl_20 select
   l_2_c_0_cl_20 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_21 <= l_1_s_0(21) & l_1_s_1(21) & l_1_s_2(21);
    with sell_2_c_0_cl_21 select
   l_2_c_0_cl_21 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_22 <= l_1_s_0(22) & l_1_s_1(22) & l_1_s_2(22);
    with sell_2_c_0_cl_22 select
   l_2_c_0_cl_22 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_23 <= l_1_s_0(23) & l_1_s_1(23) & l_1_s_2(23);
    with sell_2_c_0_cl_23 select
   l_2_c_0_cl_23 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_24 <= l_1_s_0(24) & l_1_s_1(24) & l_1_s_2(24);
    with sell_2_c_0_cl_24 select
   l_2_c_0_cl_24 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_25 <= l_1_s_0(25) & l_1_s_1(25) & l_1_s_2(25);
    with sell_2_c_0_cl_25 select
   l_2_c_0_cl_25 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_26 <= l_1_s_0(26) & l_1_s_1(26) & l_1_s_2(26);
    with sell_2_c_0_cl_26 select
   l_2_c_0_cl_26 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_27 <= l_1_s_0(27) & l_1_s_1(27) & l_1_s_2(27);
    with sell_2_c_0_cl_27 select
   l_2_c_0_cl_27 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_28 <= l_1_s_0(28) & l_1_s_1(28) & l_1_s_2(28);
    with sell_2_c_0_cl_28 select
   l_2_c_0_cl_28 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_29 <= l_1_s_0(29) & l_1_s_1(29) & l_1_s_2(29);
    with sell_2_c_0_cl_29 select
   l_2_c_0_cl_29 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_30 <= l_1_s_0(30) & l_1_s_1(30) & l_1_s_2(30);
    with sell_2_c_0_cl_30 select
   l_2_c_0_cl_30 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_31 <= l_1_s_0(31) & l_1_s_1(31) & l_1_s_2(31);
    with sell_2_c_0_cl_31 select
   l_2_c_0_cl_31 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_32 <= l_1_s_0(32) & l_1_s_1(32) & l_1_s_2(32);
    with sell_2_c_0_cl_32 select
   l_2_c_0_cl_32 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_33 <= l_1_s_0(33) & l_1_s_1(33) & l_1_s_2(33);
    with sell_2_c_0_cl_33 select
   l_2_c_0_cl_33 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_34 <= l_1_s_0(34) & l_1_s_1(34) & l_1_s_2(34);
    with sell_2_c_0_cl_34 select
   l_2_c_0_cl_34 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_35 <= l_1_s_0(35) & l_1_s_1(35) & l_1_s_2(35);
    with sell_2_c_0_cl_35 select
   l_2_c_0_cl_35 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_36 <= l_1_s_0(36) & l_1_s_1(36) & l_1_s_2(36);
    with sell_2_c_0_cl_36 select
   l_2_c_0_cl_36 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_37 <= l_1_s_0(37) & l_1_s_1(37) & l_1_s_2(37);
    with sell_2_c_0_cl_37 select
   l_2_c_0_cl_37 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_38 <= l_1_s_0(38) & l_1_s_1(38) & l_1_s_2(38);
    with sell_2_c_0_cl_38 select
   l_2_c_0_cl_38 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_39 <= l_1_s_0(39) & l_1_s_1(39) & l_1_s_2(39);
    with sell_2_c_0_cl_39 select
   l_2_c_0_cl_39 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_40 <= l_1_s_0(40) & l_1_s_1(40) & l_1_s_2(40);
    with sell_2_c_0_cl_40 select
   l_2_c_0_cl_40 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_41 <= l_1_s_0(41) & l_1_s_1(41) & l_1_s_2(41);
    with sell_2_c_0_cl_41 select
   l_2_c_0_cl_41 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   l_2_s_0 <= l_2_c_0_cl_41(0 downto 0) & l_2_c_0_cl_40(0 downto 0) & l_2_c_0_cl_39(0 downto 0) & l_2_c_0_cl_38(0 downto 0) & l_2_c_0_cl_37(0 downto 0) & l_2_c_0_cl_36(0 downto 0) & l_2_c_0_cl_35(0 downto 0) & l_2_c_0_cl_34(0 downto 0) & l_2_c_0_cl_33(0 downto 0) & l_2_c_0_cl_32(0 downto 0) & l_2_c_0_cl_31(0 downto 0) & l_2_c_0_cl_30(0 downto 0) & l_2_c_0_cl_29(0 downto 0) & l_2_c_0_cl_28(0 downto 0) & l_2_c_0_cl_27(0 downto 0) & l_2_c_0_cl_26(0 downto 0) & l_2_c_0_cl_25(0 downto 0) & l_2_c_0_cl_24(0 downto 0) & l_2_c_0_cl_23(0 downto 0) & l_2_c_0_cl_22(0 downto 0) & l_2_c_0_cl_21(0 downto 0) & l_2_c_0_cl_20(0 downto 0) & l_2_c_0_cl_19(0 downto 0) & l_2_c_0_cl_18(0 downto 0) & l_2_c_0_cl_17(0 downto 0) & l_2_c_0_cl_16(0 downto 0) & l_2_c_0_cl_15(0 downto 0) & l_2_c_0_cl_14(0 downto 0) & l_2_c_0_cl_13(0 downto 0) & l_2_c_0_cl_12(0 downto 0) & l_2_c_0_cl_11(0 downto 0) & l_2_c_0_cl_10(0 downto 0) & l_2_c_0_cl_9(0 downto 0) & l_2_c_0_cl_8(0 downto 0) & l_2_c_0_cl_7(0 downto 0) & l_2_c_0_cl_6(0 downto 0) & l_2_c_0_cl_5(0 downto 0) & l_2_c_0_cl_4(0 downto 0) & l_2_c_0_cl_3(0 downto 0) & l_2_c_0_cl_2(0 downto 0) & l_2_c_0_cl_1(0 downto 0) & l_2_c_0_cl_0(0 downto 0);
   l_2_s_1 <= l_2_c_0_cl_40(1 downto 1) & l_2_c_0_cl_39(1 downto 1) & l_2_c_0_cl_38(1 downto 1) & l_2_c_0_cl_37(1 downto 1) & l_2_c_0_cl_36(1 downto 1) & l_2_c_0_cl_35(1 downto 1) & l_2_c_0_cl_34(1 downto 1) & l_2_c_0_cl_33(1 downto 1) & l_2_c_0_cl_32(1 downto 1) & l_2_c_0_cl_31(1 downto 1) & l_2_c_0_cl_30(1 downto 1) & l_2_c_0_cl_29(1 downto 1) & l_2_c_0_cl_28(1 downto 1) & l_2_c_0_cl_27(1 downto 1) & l_2_c_0_cl_26(1 downto 1) & l_2_c_0_cl_25(1 downto 1) & l_2_c_0_cl_24(1 downto 1) & l_2_c_0_cl_23(1 downto 1) & l_2_c_0_cl_22(1 downto 1) & l_2_c_0_cl_21(1 downto 1) & l_2_c_0_cl_20(1 downto 1) & l_2_c_0_cl_19(1 downto 1) & l_2_c_0_cl_18(1 downto 1) & l_2_c_0_cl_17(1 downto 1) & l_2_c_0_cl_16(1 downto 1) & l_2_c_0_cl_15(1 downto 1) & l_2_c_0_cl_14(1 downto 1) & l_2_c_0_cl_13(1 downto 1) & l_2_c_0_cl_12(1 downto 1) & l_2_c_0_cl_11(1 downto 1) & l_2_c_0_cl_10(1 downto 1) & l_2_c_0_cl_9(1 downto 1) & l_2_c_0_cl_8(1 downto 1) & l_2_c_0_cl_7(1 downto 1) & l_2_c_0_cl_6(1 downto 1) & l_2_c_0_cl_5(1 downto 1) & l_2_c_0_cl_4(1 downto 1) & l_2_c_0_cl_3(1 downto 1) & l_2_c_0_cl_2(1 downto 1) & l_2_c_0_cl_1(1 downto 1) & l_2_c_0_cl_0(1 downto 1) & "0";
   FinalAdder_CompressorTree: IntAdder_42_f200_uid11  -- pipelineDepth=1 maxInDelay=4.34768e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '0',
                 R => myR,
                 X => l_2_s_0,
                 Y => l_2_s_1);

   ----------------Synchro barrier, entering cycle 1----------------
   R <= myR;
 -- delay at adder output 1.634e-09
end architecture;

--------------------------------------------------------------------------------
--                       LogicIntMultiplier_5_34_uid5_0
--                       (LogicIntMultiplier_5_34_uid5)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Sebastian Banescu (2008-2009)
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
entity LogicIntMultiplier_5_34_uid5_0 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(4 downto 0);
          Y : in  std_logic_vector(33 downto 0);
          R : out  std_logic_vector(38 downto 0)   );
end entity;

architecture arch of LogicIntMultiplier_5_34_uid5_0 is
	attribute multstyle : string;
	attribute multstyle of arch : architecture is "logic";
   component IntMultiAdder_42_op4_f200_uid7 is
      port ( clk, rst : in std_logic;
             X0 : in  std_logic_vector(41 downto 0);
             X1 : in  std_logic_vector(41 downto 0);
             X2 : in  std_logic_vector(41 downto 0);
             X3 : in  std_logic_vector(41 downto 0);
             R : out  std_logic_vector(41 downto 0)   );
   end component;

signal sX :  std_logic_vector(5 downto 0);
signal sY :  std_logic_vector(35 downto 0);
signal x0 :  std_logic_vector(2 downto 0);
signal x1 :  std_logic_vector(2 downto 0);
signal y0 :  std_logic_vector(2 downto 0);
signal y1 :  std_logic_vector(2 downto 0);
signal y2 :  std_logic_vector(2 downto 0);
signal y3 :  std_logic_vector(2 downto 0);
signal y4 :  std_logic_vector(2 downto 0);
signal y5 :  std_logic_vector(2 downto 0);
signal y6 :  std_logic_vector(2 downto 0);
signal y7 :  std_logic_vector(2 downto 0);
signal y8 :  std_logic_vector(2 downto 0);
signal y9 :  std_logic_vector(2 downto 0);
signal y10 :  std_logic_vector(2 downto 0);
signal y11 :  std_logic_vector(2 downto 0);
signal px0y0 :  std_logic_vector(5 downto 0);
signal px1y0 :  std_logic_vector(5 downto 0);
signal px0y1 :  std_logic_vector(5 downto 0);
signal px1y1 :  std_logic_vector(5 downto 0);
signal px0y2 :  std_logic_vector(5 downto 0);
signal px1y2 :  std_logic_vector(5 downto 0);
signal px0y3 :  std_logic_vector(5 downto 0);
signal px1y3 :  std_logic_vector(5 downto 0);
signal px0y4 :  std_logic_vector(5 downto 0);
signal px1y4 :  std_logic_vector(5 downto 0);
signal px0y5 :  std_logic_vector(5 downto 0);
signal px1y5 :  std_logic_vector(5 downto 0);
signal px0y6 :  std_logic_vector(5 downto 0);
signal px1y6 :  std_logic_vector(5 downto 0);
signal px0y7 :  std_logic_vector(5 downto 0);
signal px1y7 :  std_logic_vector(5 downto 0);
signal px0y8 :  std_logic_vector(5 downto 0);
signal px1y8 :  std_logic_vector(5 downto 0);
signal px0y9 :  std_logic_vector(5 downto 0);
signal px1y9 :  std_logic_vector(5 downto 0);
signal px0y10 :  std_logic_vector(5 downto 0);
signal px1y10 :  std_logic_vector(5 downto 0);
signal px0y11 :  std_logic_vector(5 downto 0);
signal px1y11 :  std_logic_vector(5 downto 0);
signal cp00 :  std_logic_vector(41 downto 0);
signal cp01 :  std_logic_vector(41 downto 0);
signal cp10 :  std_logic_vector(41 downto 0);
signal cp11 :  std_logic_vector(41 downto 0);
signal addRes :  std_logic_vector(41 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   sX <= X & "0";
   sY <= Y & "00";
   x0 <= sX(2 downto 0);
   x1 <= sX(5 downto 3);
   y0 <= sY(2 downto 0);
   y1 <= sY(5 downto 3);
   y2 <= sY(8 downto 6);
   y3 <= sY(11 downto 9);
   y4 <= sY(14 downto 12);
   y5 <= sY(17 downto 15);
   y6 <= sY(20 downto 18);
   y7 <= sY(23 downto 21);
   y8 <= sY(26 downto 24);
   y9 <= sY(29 downto 27);
   y10 <= sY(32 downto 30);
   y11 <= sY(35 downto 33);
   px0y0 <= x0 * y0;
   px1y0 <= x1 * y0;
   px0y1 <= x0 * y1;
   px1y1 <= x1 * y1;
   px0y2 <= x0 * y2;
   px1y2 <= x1 * y2;
   px0y3 <= x0 * y3;
   px1y3 <= x1 * y3;
   px0y4 <= x0 * y4;
   px1y4 <= x1 * y4;
   px0y5 <= x0 * y5;
   px1y5 <= x1 * y5;
   px0y6 <= x0 * y6;
   px1y6 <= x1 * y6;
   px0y7 <= x0 * y7;
   px1y7 <= x1 * y7;
   px0y8 <= x0 * y8;
   px1y8 <= x1 * y8;
   px0y9 <= x0 * y9;
   px1y9 <= x1 * y9;
   px0y10 <= x0 * y10;
   px1y10 <= x1 * y10;
   px0y11 <= x0 * y11;
   px1y11 <= x1 * y11;
   cp00 <= "000" & px0y11 & px0y9 & px0y7 & px0y5 & px0y3 & px0y1 & "000";
   cp01 <= "" & px1y11 & px1y9 & px1y7 & px1y5 & px1y3 & px1y1 & "000000";
   cp10 <= "000000" & px0y10 & px0y8 & px0y6 & px0y4 & px0y2 & px0y0 & "";
   cp11 <= "000" & px1y10 & px1y8 & px1y6 & px1y4 & px1y2 & px1y0 & "000";
   adder: IntMultiAdder_42_op4_f200_uid7  -- pipelineDepth=1 maxInDelay=2.75432e-09
      port map ( clk  => clk,
                 rst  => rst,
                 R => addRes,
                 X0 => cp00,
                 X1 => cp01,
                 X2 => cp10,
                 X3 => cp11);
   ----------------Synchro barrier, entering cycle 1----------------
   R<=addRes(41 downto 3);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_26_f200_uid19
--                    (IntAdderAlternative_26_f200_uid23)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_26_f200_uid19 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(25 downto 0);
          Y : in  std_logic_vector(25 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(25 downto 0)   );
end entity;

architecture arch of IntAdder_26_f200_uid19 is
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   --Alternative
    R <= X + Y + Cin;
end architecture;

--------------------------------------------------------------------------------
--                      LogicIntMultiplier_24_2_uid17_1
--                      (LogicIntMultiplier_24_2_uid17)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Sebastian Banescu (2008-2009)
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
entity LogicIntMultiplier_24_2_uid17_1 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(1 downto 0);
          R : out  std_logic_vector(25 downto 0)   );
end entity;

architecture arch of LogicIntMultiplier_24_2_uid17_1 is
	attribute multstyle : string;
	attribute multstyle of arch : architecture is "logic";
   component IntAdder_26_f200_uid19 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(25 downto 0);
             Y : in  std_logic_vector(25 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(25 downto 0)   );
   end component;

signal R0 :  std_logic_vector(25 downto 0);
signal R1 :  std_logic_vector(25 downto 0);
signal RAdder :  std_logic_vector(25 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   R0 <= ("00" & X) when Y(0)='1' else "00000000000000000000000000";
   R1 <= ( "0" & X & "0") when Y(1)='1' else "00000000000000000000000000";
   ResultAdder: IntAdder_26_f200_uid19  -- pipelineDepth=0 maxInDelay=9.7544e-10
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '0',
                 R => RAdder   ,
                 X => R0,
                 Y => R1);

   R <= RAdder;
end architecture;

--------------------------------------------------------------------------------
--                          IntAdder_106_f200_uid29
--                    (IntAdderAlternative_106_f200_uid33)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_106_f200_uid29 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(105 downto 0);
          Y : in  std_logic_vector(105 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(105 downto 0)   );
end entity;

architecture arch of IntAdder_106_f200_uid29 is
signal s_sum_l0_idx0 :  std_logic_vector(99 downto 0);
signal s_sum_l0_idx1, s_sum_l0_idx1_d1 :  std_logic_vector(7 downto 0);
signal sum_l0_idx0, sum_l0_idx0_d1 :  std_logic_vector(98 downto 0);
signal c_l0_idx0, c_l0_idx0_d1 :  std_logic_vector(0 downto 0);
signal sum_l0_idx1 :  std_logic_vector(6 downto 0);
signal c_l0_idx1 :  std_logic_vector(0 downto 0);
signal s_sum_l1_idx1 :  std_logic_vector(7 downto 0);
signal sum_l1_idx1 :  std_logic_vector(6 downto 0);
signal c_l1_idx1 :  std_logic_vector(0 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            s_sum_l0_idx1_d1 <=  s_sum_l0_idx1;
            sum_l0_idx0_d1 <=  sum_l0_idx0;
            c_l0_idx0_d1 <=  c_l0_idx0;
         end if;
      end process;
   --Alternative
   s_sum_l0_idx0 <= ( "0" & X(98 downto 0)) + ( "0" & Y(98 downto 0)) + Cin;
   s_sum_l0_idx1 <= ( "0" & X(105 downto 99)) + ( "0" & Y(105 downto 99));
   sum_l0_idx0 <= s_sum_l0_idx0(98 downto 0);
   c_l0_idx0 <= s_sum_l0_idx0(99 downto 99);
   sum_l0_idx1 <= s_sum_l0_idx1(6 downto 0);
   c_l0_idx1 <= s_sum_l0_idx1(7 downto 7);
   ----------------Synchro barrier, entering cycle 1----------------
   s_sum_l1_idx1 <=  s_sum_l0_idx1_d1 + c_l0_idx0_d1(0 downto 0);
   sum_l1_idx1 <= s_sum_l1_idx1(6 downto 0);
   c_l1_idx1 <= s_sum_l1_idx1(7 downto 7);
   R <= sum_l1_idx1(6 downto 0) & sum_l0_idx0_d1(98 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                      IntMultiAdder_106_op4_f200_uid25
--                      (IntCompressorTree_106_4_uid27)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2009-2011)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiAdder_106_op4_f200_uid25 is
   port ( clk, rst : in std_logic;
          X0 : in  std_logic_vector(105 downto 0);
          X1 : in  std_logic_vector(105 downto 0);
          X2 : in  std_logic_vector(105 downto 0);
          X3 : in  std_logic_vector(105 downto 0);
          R : out  std_logic_vector(105 downto 0)   );
end entity;

architecture arch of IntMultiAdder_106_op4_f200_uid25 is
   component IntAdder_106_f200_uid29 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(105 downto 0);
             Y : in  std_logic_vector(105 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(105 downto 0)   );
   end component;

signal l_0_s_0 :  std_logic_vector(105 downto 0);
signal l_0_s_1 :  std_logic_vector(105 downto 0);
signal l_0_s_2 :  std_logic_vector(105 downto 0);
signal l_0_s_3 :  std_logic_vector(105 downto 0);
signal sell_1_c_0_cl_0 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_0 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_1 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_1 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_2 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_2 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_3 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_3 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_4 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_4 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_5 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_5 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_6 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_6 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_7 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_7 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_8 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_8 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_9 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_9 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_10 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_10 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_11 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_11 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_12 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_12 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_13 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_13 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_14 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_14 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_15 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_15 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_16 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_16 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_17 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_17 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_18 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_18 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_19 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_19 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_20 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_20 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_21 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_21 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_22 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_22 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_23 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_23 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_24 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_24 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_25 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_25 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_26 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_26 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_27 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_27 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_28 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_28 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_29 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_29 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_30 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_30 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_31 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_31 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_32 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_32 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_33 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_33 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_34 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_34 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_35 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_35 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_36 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_36 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_37 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_37 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_38 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_38 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_39 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_39 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_40 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_40 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_41 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_41 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_42 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_42 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_43 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_43 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_44 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_44 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_45 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_45 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_46 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_46 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_47 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_47 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_48 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_48 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_49 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_49 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_50 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_50 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_51 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_51 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_52 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_52 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_53 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_53 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_54 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_54 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_55 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_55 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_56 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_56 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_57 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_57 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_58 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_58 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_59 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_59 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_60 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_60 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_61 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_61 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_62 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_62 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_63 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_63 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_64 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_64 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_65 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_65 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_66 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_66 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_67 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_67 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_68 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_68 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_69 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_69 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_70 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_70 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_71 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_71 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_72 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_72 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_73 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_73 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_74 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_74 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_75 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_75 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_76 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_76 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_77 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_77 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_78 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_78 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_79 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_79 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_80 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_80 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_81 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_81 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_82 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_82 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_83 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_83 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_84 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_84 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_85 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_85 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_86 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_86 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_87 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_87 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_88 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_88 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_89 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_89 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_90 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_90 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_91 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_91 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_92 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_92 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_93 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_93 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_94 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_94 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_95 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_95 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_96 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_96 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_97 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_97 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_98 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_98 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_99 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_99 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_100 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_100 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_101 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_101 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_102 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_102 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_103 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_103 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_104 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_104 :  std_logic_vector(2 downto 0);
signal sell_1_c_0_cl_105 :  std_logic_vector(3 downto 0);
signal l_1_c_0_cl_105 :  std_logic_vector(2 downto 0);
signal l_1_s_0 :  std_logic_vector(105 downto 0);
signal l_1_s_1 :  std_logic_vector(105 downto 0);
signal l_1_s_2 :  std_logic_vector(105 downto 0);
signal sell_2_c_0_cl_0 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_0 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_1 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_1 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_2 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_2 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_3 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_3 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_4 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_4 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_5 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_5 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_6 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_6 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_7 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_7 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_8 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_8 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_9 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_9 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_10 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_10 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_11 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_11 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_12 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_12 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_13 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_13 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_14 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_14 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_15 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_15 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_16 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_16 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_17 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_17 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_18 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_18 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_19 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_19 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_20 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_20 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_21 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_21 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_22 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_22 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_23 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_23 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_24 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_24 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_25 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_25 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_26 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_26 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_27 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_27 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_28 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_28 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_29 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_29 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_30 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_30 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_31 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_31 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_32 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_32 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_33 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_33 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_34 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_34 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_35 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_35 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_36 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_36 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_37 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_37 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_38 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_38 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_39 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_39 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_40 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_40 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_41 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_41 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_42 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_42 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_43 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_43 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_44 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_44 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_45 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_45 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_46 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_46 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_47 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_47 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_48 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_48 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_49 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_49 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_50 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_50 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_51 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_51 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_52 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_52 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_53 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_53 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_54 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_54 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_55 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_55 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_56 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_56 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_57 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_57 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_58 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_58 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_59 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_59 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_60 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_60 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_61 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_61 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_62 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_62 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_63 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_63 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_64 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_64 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_65 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_65 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_66 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_66 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_67 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_67 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_68 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_68 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_69 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_69 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_70 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_70 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_71 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_71 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_72 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_72 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_73 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_73 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_74 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_74 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_75 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_75 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_76 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_76 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_77 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_77 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_78 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_78 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_79 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_79 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_80 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_80 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_81 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_81 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_82 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_82 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_83 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_83 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_84 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_84 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_85 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_85 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_86 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_86 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_87 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_87 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_88 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_88 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_89 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_89 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_90 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_90 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_91 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_91 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_92 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_92 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_93 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_93 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_94 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_94 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_95 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_95 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_96 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_96 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_97 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_97 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_98 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_98 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_99 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_99 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_100 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_100 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_101 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_101 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_102 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_102 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_103 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_103 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_104 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_104 :  std_logic_vector(1 downto 0);
signal sell_2_c_0_cl_105 :  std_logic_vector(2 downto 0);
signal l_2_c_0_cl_105 :  std_logic_vector(1 downto 0);
signal l_2_s_0 :  std_logic_vector(105 downto 0);
signal l_2_s_1 :  std_logic_vector(105 downto 0);
signal myR :  std_logic_vector(105 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   l_0_s_0 <= X0;
   l_0_s_1 <= X1;
   l_0_s_2 <= X2;
   l_0_s_3 <= X3;
   sell_1_c_0_cl_0 <= l_0_s_0(0) & l_0_s_1(0) & l_0_s_2(0) & l_0_s_3(0);
    with sell_1_c_0_cl_0 select
   l_1_c_0_cl_0 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_1 <= l_0_s_0(1) & l_0_s_1(1) & l_0_s_2(1) & l_0_s_3(1);
    with sell_1_c_0_cl_1 select
   l_1_c_0_cl_1 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_2 <= l_0_s_0(2) & l_0_s_1(2) & l_0_s_2(2) & l_0_s_3(2);
    with sell_1_c_0_cl_2 select
   l_1_c_0_cl_2 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_3 <= l_0_s_0(3) & l_0_s_1(3) & l_0_s_2(3) & l_0_s_3(3);
    with sell_1_c_0_cl_3 select
   l_1_c_0_cl_3 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_4 <= l_0_s_0(4) & l_0_s_1(4) & l_0_s_2(4) & l_0_s_3(4);
    with sell_1_c_0_cl_4 select
   l_1_c_0_cl_4 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_5 <= l_0_s_0(5) & l_0_s_1(5) & l_0_s_2(5) & l_0_s_3(5);
    with sell_1_c_0_cl_5 select
   l_1_c_0_cl_5 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_6 <= l_0_s_0(6) & l_0_s_1(6) & l_0_s_2(6) & l_0_s_3(6);
    with sell_1_c_0_cl_6 select
   l_1_c_0_cl_6 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_7 <= l_0_s_0(7) & l_0_s_1(7) & l_0_s_2(7) & l_0_s_3(7);
    with sell_1_c_0_cl_7 select
   l_1_c_0_cl_7 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_8 <= l_0_s_0(8) & l_0_s_1(8) & l_0_s_2(8) & l_0_s_3(8);
    with sell_1_c_0_cl_8 select
   l_1_c_0_cl_8 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_9 <= l_0_s_0(9) & l_0_s_1(9) & l_0_s_2(9) & l_0_s_3(9);
    with sell_1_c_0_cl_9 select
   l_1_c_0_cl_9 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_10 <= l_0_s_0(10) & l_0_s_1(10) & l_0_s_2(10) & l_0_s_3(10);
    with sell_1_c_0_cl_10 select
   l_1_c_0_cl_10 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_11 <= l_0_s_0(11) & l_0_s_1(11) & l_0_s_2(11) & l_0_s_3(11);
    with sell_1_c_0_cl_11 select
   l_1_c_0_cl_11 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_12 <= l_0_s_0(12) & l_0_s_1(12) & l_0_s_2(12) & l_0_s_3(12);
    with sell_1_c_0_cl_12 select
   l_1_c_0_cl_12 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_13 <= l_0_s_0(13) & l_0_s_1(13) & l_0_s_2(13) & l_0_s_3(13);
    with sell_1_c_0_cl_13 select
   l_1_c_0_cl_13 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_14 <= l_0_s_0(14) & l_0_s_1(14) & l_0_s_2(14) & l_0_s_3(14);
    with sell_1_c_0_cl_14 select
   l_1_c_0_cl_14 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_15 <= l_0_s_0(15) & l_0_s_1(15) & l_0_s_2(15) & l_0_s_3(15);
    with sell_1_c_0_cl_15 select
   l_1_c_0_cl_15 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_16 <= l_0_s_0(16) & l_0_s_1(16) & l_0_s_2(16) & l_0_s_3(16);
    with sell_1_c_0_cl_16 select
   l_1_c_0_cl_16 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_17 <= l_0_s_0(17) & l_0_s_1(17) & l_0_s_2(17) & l_0_s_3(17);
    with sell_1_c_0_cl_17 select
   l_1_c_0_cl_17 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_18 <= l_0_s_0(18) & l_0_s_1(18) & l_0_s_2(18) & l_0_s_3(18);
    with sell_1_c_0_cl_18 select
   l_1_c_0_cl_18 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_19 <= l_0_s_0(19) & l_0_s_1(19) & l_0_s_2(19) & l_0_s_3(19);
    with sell_1_c_0_cl_19 select
   l_1_c_0_cl_19 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_20 <= l_0_s_0(20) & l_0_s_1(20) & l_0_s_2(20) & l_0_s_3(20);
    with sell_1_c_0_cl_20 select
   l_1_c_0_cl_20 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_21 <= l_0_s_0(21) & l_0_s_1(21) & l_0_s_2(21) & l_0_s_3(21);
    with sell_1_c_0_cl_21 select
   l_1_c_0_cl_21 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_22 <= l_0_s_0(22) & l_0_s_1(22) & l_0_s_2(22) & l_0_s_3(22);
    with sell_1_c_0_cl_22 select
   l_1_c_0_cl_22 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_23 <= l_0_s_0(23) & l_0_s_1(23) & l_0_s_2(23) & l_0_s_3(23);
    with sell_1_c_0_cl_23 select
   l_1_c_0_cl_23 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_24 <= l_0_s_0(24) & l_0_s_1(24) & l_0_s_2(24) & l_0_s_3(24);
    with sell_1_c_0_cl_24 select
   l_1_c_0_cl_24 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_25 <= l_0_s_0(25) & l_0_s_1(25) & l_0_s_2(25) & l_0_s_3(25);
    with sell_1_c_0_cl_25 select
   l_1_c_0_cl_25 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_26 <= l_0_s_0(26) & l_0_s_1(26) & l_0_s_2(26) & l_0_s_3(26);
    with sell_1_c_0_cl_26 select
   l_1_c_0_cl_26 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_27 <= l_0_s_0(27) & l_0_s_1(27) & l_0_s_2(27) & l_0_s_3(27);
    with sell_1_c_0_cl_27 select
   l_1_c_0_cl_27 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_28 <= l_0_s_0(28) & l_0_s_1(28) & l_0_s_2(28) & l_0_s_3(28);
    with sell_1_c_0_cl_28 select
   l_1_c_0_cl_28 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_29 <= l_0_s_0(29) & l_0_s_1(29) & l_0_s_2(29) & l_0_s_3(29);
    with sell_1_c_0_cl_29 select
   l_1_c_0_cl_29 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_30 <= l_0_s_0(30) & l_0_s_1(30) & l_0_s_2(30) & l_0_s_3(30);
    with sell_1_c_0_cl_30 select
   l_1_c_0_cl_30 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_31 <= l_0_s_0(31) & l_0_s_1(31) & l_0_s_2(31) & l_0_s_3(31);
    with sell_1_c_0_cl_31 select
   l_1_c_0_cl_31 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_32 <= l_0_s_0(32) & l_0_s_1(32) & l_0_s_2(32) & l_0_s_3(32);
    with sell_1_c_0_cl_32 select
   l_1_c_0_cl_32 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_33 <= l_0_s_0(33) & l_0_s_1(33) & l_0_s_2(33) & l_0_s_3(33);
    with sell_1_c_0_cl_33 select
   l_1_c_0_cl_33 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_34 <= l_0_s_0(34) & l_0_s_1(34) & l_0_s_2(34) & l_0_s_3(34);
    with sell_1_c_0_cl_34 select
   l_1_c_0_cl_34 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_35 <= l_0_s_0(35) & l_0_s_1(35) & l_0_s_2(35) & l_0_s_3(35);
    with sell_1_c_0_cl_35 select
   l_1_c_0_cl_35 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_36 <= l_0_s_0(36) & l_0_s_1(36) & l_0_s_2(36) & l_0_s_3(36);
    with sell_1_c_0_cl_36 select
   l_1_c_0_cl_36 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_37 <= l_0_s_0(37) & l_0_s_1(37) & l_0_s_2(37) & l_0_s_3(37);
    with sell_1_c_0_cl_37 select
   l_1_c_0_cl_37 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_38 <= l_0_s_0(38) & l_0_s_1(38) & l_0_s_2(38) & l_0_s_3(38);
    with sell_1_c_0_cl_38 select
   l_1_c_0_cl_38 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_39 <= l_0_s_0(39) & l_0_s_1(39) & l_0_s_2(39) & l_0_s_3(39);
    with sell_1_c_0_cl_39 select
   l_1_c_0_cl_39 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_40 <= l_0_s_0(40) & l_0_s_1(40) & l_0_s_2(40) & l_0_s_3(40);
    with sell_1_c_0_cl_40 select
   l_1_c_0_cl_40 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_41 <= l_0_s_0(41) & l_0_s_1(41) & l_0_s_2(41) & l_0_s_3(41);
    with sell_1_c_0_cl_41 select
   l_1_c_0_cl_41 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_42 <= l_0_s_0(42) & l_0_s_1(42) & l_0_s_2(42) & l_0_s_3(42);
    with sell_1_c_0_cl_42 select
   l_1_c_0_cl_42 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_43 <= l_0_s_0(43) & l_0_s_1(43) & l_0_s_2(43) & l_0_s_3(43);
    with sell_1_c_0_cl_43 select
   l_1_c_0_cl_43 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_44 <= l_0_s_0(44) & l_0_s_1(44) & l_0_s_2(44) & l_0_s_3(44);
    with sell_1_c_0_cl_44 select
   l_1_c_0_cl_44 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_45 <= l_0_s_0(45) & l_0_s_1(45) & l_0_s_2(45) & l_0_s_3(45);
    with sell_1_c_0_cl_45 select
   l_1_c_0_cl_45 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_46 <= l_0_s_0(46) & l_0_s_1(46) & l_0_s_2(46) & l_0_s_3(46);
    with sell_1_c_0_cl_46 select
   l_1_c_0_cl_46 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_47 <= l_0_s_0(47) & l_0_s_1(47) & l_0_s_2(47) & l_0_s_3(47);
    with sell_1_c_0_cl_47 select
   l_1_c_0_cl_47 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_48 <= l_0_s_0(48) & l_0_s_1(48) & l_0_s_2(48) & l_0_s_3(48);
    with sell_1_c_0_cl_48 select
   l_1_c_0_cl_48 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_49 <= l_0_s_0(49) & l_0_s_1(49) & l_0_s_2(49) & l_0_s_3(49);
    with sell_1_c_0_cl_49 select
   l_1_c_0_cl_49 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_50 <= l_0_s_0(50) & l_0_s_1(50) & l_0_s_2(50) & l_0_s_3(50);
    with sell_1_c_0_cl_50 select
   l_1_c_0_cl_50 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_51 <= l_0_s_0(51) & l_0_s_1(51) & l_0_s_2(51) & l_0_s_3(51);
    with sell_1_c_0_cl_51 select
   l_1_c_0_cl_51 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_52 <= l_0_s_0(52) & l_0_s_1(52) & l_0_s_2(52) & l_0_s_3(52);
    with sell_1_c_0_cl_52 select
   l_1_c_0_cl_52 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_53 <= l_0_s_0(53) & l_0_s_1(53) & l_0_s_2(53) & l_0_s_3(53);
    with sell_1_c_0_cl_53 select
   l_1_c_0_cl_53 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_54 <= l_0_s_0(54) & l_0_s_1(54) & l_0_s_2(54) & l_0_s_3(54);
    with sell_1_c_0_cl_54 select
   l_1_c_0_cl_54 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_55 <= l_0_s_0(55) & l_0_s_1(55) & l_0_s_2(55) & l_0_s_3(55);
    with sell_1_c_0_cl_55 select
   l_1_c_0_cl_55 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_56 <= l_0_s_0(56) & l_0_s_1(56) & l_0_s_2(56) & l_0_s_3(56);
    with sell_1_c_0_cl_56 select
   l_1_c_0_cl_56 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_57 <= l_0_s_0(57) & l_0_s_1(57) & l_0_s_2(57) & l_0_s_3(57);
    with sell_1_c_0_cl_57 select
   l_1_c_0_cl_57 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_58 <= l_0_s_0(58) & l_0_s_1(58) & l_0_s_2(58) & l_0_s_3(58);
    with sell_1_c_0_cl_58 select
   l_1_c_0_cl_58 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_59 <= l_0_s_0(59) & l_0_s_1(59) & l_0_s_2(59) & l_0_s_3(59);
    with sell_1_c_0_cl_59 select
   l_1_c_0_cl_59 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_60 <= l_0_s_0(60) & l_0_s_1(60) & l_0_s_2(60) & l_0_s_3(60);
    with sell_1_c_0_cl_60 select
   l_1_c_0_cl_60 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_61 <= l_0_s_0(61) & l_0_s_1(61) & l_0_s_2(61) & l_0_s_3(61);
    with sell_1_c_0_cl_61 select
   l_1_c_0_cl_61 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_62 <= l_0_s_0(62) & l_0_s_1(62) & l_0_s_2(62) & l_0_s_3(62);
    with sell_1_c_0_cl_62 select
   l_1_c_0_cl_62 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_63 <= l_0_s_0(63) & l_0_s_1(63) & l_0_s_2(63) & l_0_s_3(63);
    with sell_1_c_0_cl_63 select
   l_1_c_0_cl_63 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_64 <= l_0_s_0(64) & l_0_s_1(64) & l_0_s_2(64) & l_0_s_3(64);
    with sell_1_c_0_cl_64 select
   l_1_c_0_cl_64 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_65 <= l_0_s_0(65) & l_0_s_1(65) & l_0_s_2(65) & l_0_s_3(65);
    with sell_1_c_0_cl_65 select
   l_1_c_0_cl_65 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_66 <= l_0_s_0(66) & l_0_s_1(66) & l_0_s_2(66) & l_0_s_3(66);
    with sell_1_c_0_cl_66 select
   l_1_c_0_cl_66 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_67 <= l_0_s_0(67) & l_0_s_1(67) & l_0_s_2(67) & l_0_s_3(67);
    with sell_1_c_0_cl_67 select
   l_1_c_0_cl_67 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_68 <= l_0_s_0(68) & l_0_s_1(68) & l_0_s_2(68) & l_0_s_3(68);
    with sell_1_c_0_cl_68 select
   l_1_c_0_cl_68 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_69 <= l_0_s_0(69) & l_0_s_1(69) & l_0_s_2(69) & l_0_s_3(69);
    with sell_1_c_0_cl_69 select
   l_1_c_0_cl_69 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_70 <= l_0_s_0(70) & l_0_s_1(70) & l_0_s_2(70) & l_0_s_3(70);
    with sell_1_c_0_cl_70 select
   l_1_c_0_cl_70 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_71 <= l_0_s_0(71) & l_0_s_1(71) & l_0_s_2(71) & l_0_s_3(71);
    with sell_1_c_0_cl_71 select
   l_1_c_0_cl_71 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_72 <= l_0_s_0(72) & l_0_s_1(72) & l_0_s_2(72) & l_0_s_3(72);
    with sell_1_c_0_cl_72 select
   l_1_c_0_cl_72 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_73 <= l_0_s_0(73) & l_0_s_1(73) & l_0_s_2(73) & l_0_s_3(73);
    with sell_1_c_0_cl_73 select
   l_1_c_0_cl_73 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_74 <= l_0_s_0(74) & l_0_s_1(74) & l_0_s_2(74) & l_0_s_3(74);
    with sell_1_c_0_cl_74 select
   l_1_c_0_cl_74 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_75 <= l_0_s_0(75) & l_0_s_1(75) & l_0_s_2(75) & l_0_s_3(75);
    with sell_1_c_0_cl_75 select
   l_1_c_0_cl_75 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_76 <= l_0_s_0(76) & l_0_s_1(76) & l_0_s_2(76) & l_0_s_3(76);
    with sell_1_c_0_cl_76 select
   l_1_c_0_cl_76 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_77 <= l_0_s_0(77) & l_0_s_1(77) & l_0_s_2(77) & l_0_s_3(77);
    with sell_1_c_0_cl_77 select
   l_1_c_0_cl_77 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_78 <= l_0_s_0(78) & l_0_s_1(78) & l_0_s_2(78) & l_0_s_3(78);
    with sell_1_c_0_cl_78 select
   l_1_c_0_cl_78 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_79 <= l_0_s_0(79) & l_0_s_1(79) & l_0_s_2(79) & l_0_s_3(79);
    with sell_1_c_0_cl_79 select
   l_1_c_0_cl_79 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_80 <= l_0_s_0(80) & l_0_s_1(80) & l_0_s_2(80) & l_0_s_3(80);
    with sell_1_c_0_cl_80 select
   l_1_c_0_cl_80 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_81 <= l_0_s_0(81) & l_0_s_1(81) & l_0_s_2(81) & l_0_s_3(81);
    with sell_1_c_0_cl_81 select
   l_1_c_0_cl_81 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_82 <= l_0_s_0(82) & l_0_s_1(82) & l_0_s_2(82) & l_0_s_3(82);
    with sell_1_c_0_cl_82 select
   l_1_c_0_cl_82 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_83 <= l_0_s_0(83) & l_0_s_1(83) & l_0_s_2(83) & l_0_s_3(83);
    with sell_1_c_0_cl_83 select
   l_1_c_0_cl_83 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_84 <= l_0_s_0(84) & l_0_s_1(84) & l_0_s_2(84) & l_0_s_3(84);
    with sell_1_c_0_cl_84 select
   l_1_c_0_cl_84 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_85 <= l_0_s_0(85) & l_0_s_1(85) & l_0_s_2(85) & l_0_s_3(85);
    with sell_1_c_0_cl_85 select
   l_1_c_0_cl_85 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_86 <= l_0_s_0(86) & l_0_s_1(86) & l_0_s_2(86) & l_0_s_3(86);
    with sell_1_c_0_cl_86 select
   l_1_c_0_cl_86 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_87 <= l_0_s_0(87) & l_0_s_1(87) & l_0_s_2(87) & l_0_s_3(87);
    with sell_1_c_0_cl_87 select
   l_1_c_0_cl_87 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_88 <= l_0_s_0(88) & l_0_s_1(88) & l_0_s_2(88) & l_0_s_3(88);
    with sell_1_c_0_cl_88 select
   l_1_c_0_cl_88 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_89 <= l_0_s_0(89) & l_0_s_1(89) & l_0_s_2(89) & l_0_s_3(89);
    with sell_1_c_0_cl_89 select
   l_1_c_0_cl_89 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_90 <= l_0_s_0(90) & l_0_s_1(90) & l_0_s_2(90) & l_0_s_3(90);
    with sell_1_c_0_cl_90 select
   l_1_c_0_cl_90 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_91 <= l_0_s_0(91) & l_0_s_1(91) & l_0_s_2(91) & l_0_s_3(91);
    with sell_1_c_0_cl_91 select
   l_1_c_0_cl_91 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_92 <= l_0_s_0(92) & l_0_s_1(92) & l_0_s_2(92) & l_0_s_3(92);
    with sell_1_c_0_cl_92 select
   l_1_c_0_cl_92 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_93 <= l_0_s_0(93) & l_0_s_1(93) & l_0_s_2(93) & l_0_s_3(93);
    with sell_1_c_0_cl_93 select
   l_1_c_0_cl_93 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_94 <= l_0_s_0(94) & l_0_s_1(94) & l_0_s_2(94) & l_0_s_3(94);
    with sell_1_c_0_cl_94 select
   l_1_c_0_cl_94 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_95 <= l_0_s_0(95) & l_0_s_1(95) & l_0_s_2(95) & l_0_s_3(95);
    with sell_1_c_0_cl_95 select
   l_1_c_0_cl_95 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_96 <= l_0_s_0(96) & l_0_s_1(96) & l_0_s_2(96) & l_0_s_3(96);
    with sell_1_c_0_cl_96 select
   l_1_c_0_cl_96 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_97 <= l_0_s_0(97) & l_0_s_1(97) & l_0_s_2(97) & l_0_s_3(97);
    with sell_1_c_0_cl_97 select
   l_1_c_0_cl_97 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_98 <= l_0_s_0(98) & l_0_s_1(98) & l_0_s_2(98) & l_0_s_3(98);
    with sell_1_c_0_cl_98 select
   l_1_c_0_cl_98 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_99 <= l_0_s_0(99) & l_0_s_1(99) & l_0_s_2(99) & l_0_s_3(99);
    with sell_1_c_0_cl_99 select
   l_1_c_0_cl_99 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_100 <= l_0_s_0(100) & l_0_s_1(100) & l_0_s_2(100) & l_0_s_3(100);
    with sell_1_c_0_cl_100 select
   l_1_c_0_cl_100 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_101 <= l_0_s_0(101) & l_0_s_1(101) & l_0_s_2(101) & l_0_s_3(101);
    with sell_1_c_0_cl_101 select
   l_1_c_0_cl_101 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_102 <= l_0_s_0(102) & l_0_s_1(102) & l_0_s_2(102) & l_0_s_3(102);
    with sell_1_c_0_cl_102 select
   l_1_c_0_cl_102 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_103 <= l_0_s_0(103) & l_0_s_1(103) & l_0_s_2(103) & l_0_s_3(103);
    with sell_1_c_0_cl_103 select
   l_1_c_0_cl_103 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_104 <= l_0_s_0(104) & l_0_s_1(104) & l_0_s_2(104) & l_0_s_3(104);
    with sell_1_c_0_cl_104 select
   l_1_c_0_cl_104 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   sell_1_c_0_cl_105 <= l_0_s_0(105) & l_0_s_1(105) & l_0_s_2(105) & l_0_s_3(105);
    with sell_1_c_0_cl_105 select
   l_1_c_0_cl_105 <= 
   "000" when "0000",   "001" when "0001",   "001" when "0010",   "010" when "0011",   "001" when "0100",   "010" when "0101",   "010" when "0110",   "011" when "0111",   "001" when "1000",   "010" when "1001",   "010" when "1010",   "011" when "1011",   "010" when "1100",   "011" when "1101",   "011" when "1110",   "100" when "1111",   "000" when others;
   l_1_s_0 <= l_1_c_0_cl_105(0 downto 0) & l_1_c_0_cl_104(0 downto 0) & l_1_c_0_cl_103(0 downto 0) & l_1_c_0_cl_102(0 downto 0) & l_1_c_0_cl_101(0 downto 0) & l_1_c_0_cl_100(0 downto 0) & l_1_c_0_cl_99(0 downto 0) & l_1_c_0_cl_98(0 downto 0) & l_1_c_0_cl_97(0 downto 0) & l_1_c_0_cl_96(0 downto 0) & l_1_c_0_cl_95(0 downto 0) & l_1_c_0_cl_94(0 downto 0) & l_1_c_0_cl_93(0 downto 0) & l_1_c_0_cl_92(0 downto 0) & l_1_c_0_cl_91(0 downto 0) & l_1_c_0_cl_90(0 downto 0) & l_1_c_0_cl_89(0 downto 0) & l_1_c_0_cl_88(0 downto 0) & l_1_c_0_cl_87(0 downto 0) & l_1_c_0_cl_86(0 downto 0) & l_1_c_0_cl_85(0 downto 0) & l_1_c_0_cl_84(0 downto 0) & l_1_c_0_cl_83(0 downto 0) & l_1_c_0_cl_82(0 downto 0) & l_1_c_0_cl_81(0 downto 0) & l_1_c_0_cl_80(0 downto 0) & l_1_c_0_cl_79(0 downto 0) & l_1_c_0_cl_78(0 downto 0) & l_1_c_0_cl_77(0 downto 0) & l_1_c_0_cl_76(0 downto 0) & l_1_c_0_cl_75(0 downto 0) & l_1_c_0_cl_74(0 downto 0) & l_1_c_0_cl_73(0 downto 0) & l_1_c_0_cl_72(0 downto 0) & l_1_c_0_cl_71(0 downto 0) & l_1_c_0_cl_70(0 downto 0) & l_1_c_0_cl_69(0 downto 0) & l_1_c_0_cl_68(0 downto 0) & l_1_c_0_cl_67(0 downto 0) & l_1_c_0_cl_66(0 downto 0) & l_1_c_0_cl_65(0 downto 0) & l_1_c_0_cl_64(0 downto 0) & l_1_c_0_cl_63(0 downto 0) & l_1_c_0_cl_62(0 downto 0) & l_1_c_0_cl_61(0 downto 0) & l_1_c_0_cl_60(0 downto 0) & l_1_c_0_cl_59(0 downto 0) & l_1_c_0_cl_58(0 downto 0) & l_1_c_0_cl_57(0 downto 0) & l_1_c_0_cl_56(0 downto 0) & l_1_c_0_cl_55(0 downto 0) & l_1_c_0_cl_54(0 downto 0) & l_1_c_0_cl_53(0 downto 0) & l_1_c_0_cl_52(0 downto 0) & l_1_c_0_cl_51(0 downto 0) & l_1_c_0_cl_50(0 downto 0) & l_1_c_0_cl_49(0 downto 0) & l_1_c_0_cl_48(0 downto 0) & l_1_c_0_cl_47(0 downto 0) & l_1_c_0_cl_46(0 downto 0) & l_1_c_0_cl_45(0 downto 0) & l_1_c_0_cl_44(0 downto 0) & l_1_c_0_cl_43(0 downto 0) & l_1_c_0_cl_42(0 downto 0) & l_1_c_0_cl_41(0 downto 0) & l_1_c_0_cl_40(0 downto 0) & l_1_c_0_cl_39(0 downto 0) & l_1_c_0_cl_38(0 downto 0) & l_1_c_0_cl_37(0 downto 0) & l_1_c_0_cl_36(0 downto 0) & l_1_c_0_cl_35(0 downto 0) & l_1_c_0_cl_34(0 downto 0) & l_1_c_0_cl_33(0 downto 0) & l_1_c_0_cl_32(0 downto 0) & l_1_c_0_cl_31(0 downto 0) & l_1_c_0_cl_30(0 downto 0) & l_1_c_0_cl_29(0 downto 0) & l_1_c_0_cl_28(0 downto 0) & l_1_c_0_cl_27(0 downto 0) & l_1_c_0_cl_26(0 downto 0) & l_1_c_0_cl_25(0 downto 0) & l_1_c_0_cl_24(0 downto 0) & l_1_c_0_cl_23(0 downto 0) & l_1_c_0_cl_22(0 downto 0) & l_1_c_0_cl_21(0 downto 0) & l_1_c_0_cl_20(0 downto 0) & l_1_c_0_cl_19(0 downto 0) & l_1_c_0_cl_18(0 downto 0) & l_1_c_0_cl_17(0 downto 0) & l_1_c_0_cl_16(0 downto 0) & l_1_c_0_cl_15(0 downto 0) & l_1_c_0_cl_14(0 downto 0) & l_1_c_0_cl_13(0 downto 0) & l_1_c_0_cl_12(0 downto 0) & l_1_c_0_cl_11(0 downto 0) & l_1_c_0_cl_10(0 downto 0) & l_1_c_0_cl_9(0 downto 0) & l_1_c_0_cl_8(0 downto 0) & l_1_c_0_cl_7(0 downto 0) & l_1_c_0_cl_6(0 downto 0) & l_1_c_0_cl_5(0 downto 0) & l_1_c_0_cl_4(0 downto 0) & l_1_c_0_cl_3(0 downto 0) & l_1_c_0_cl_2(0 downto 0) & l_1_c_0_cl_1(0 downto 0) & l_1_c_0_cl_0(0 downto 0);
   l_1_s_1 <= l_1_c_0_cl_104(1 downto 1) & l_1_c_0_cl_103(1 downto 1) & l_1_c_0_cl_102(1 downto 1) & l_1_c_0_cl_101(1 downto 1) & l_1_c_0_cl_100(1 downto 1) & l_1_c_0_cl_99(1 downto 1) & l_1_c_0_cl_98(1 downto 1) & l_1_c_0_cl_97(1 downto 1) & l_1_c_0_cl_96(1 downto 1) & l_1_c_0_cl_95(1 downto 1) & l_1_c_0_cl_94(1 downto 1) & l_1_c_0_cl_93(1 downto 1) & l_1_c_0_cl_92(1 downto 1) & l_1_c_0_cl_91(1 downto 1) & l_1_c_0_cl_90(1 downto 1) & l_1_c_0_cl_89(1 downto 1) & l_1_c_0_cl_88(1 downto 1) & l_1_c_0_cl_87(1 downto 1) & l_1_c_0_cl_86(1 downto 1) & l_1_c_0_cl_85(1 downto 1) & l_1_c_0_cl_84(1 downto 1) & l_1_c_0_cl_83(1 downto 1) & l_1_c_0_cl_82(1 downto 1) & l_1_c_0_cl_81(1 downto 1) & l_1_c_0_cl_80(1 downto 1) & l_1_c_0_cl_79(1 downto 1) & l_1_c_0_cl_78(1 downto 1) & l_1_c_0_cl_77(1 downto 1) & l_1_c_0_cl_76(1 downto 1) & l_1_c_0_cl_75(1 downto 1) & l_1_c_0_cl_74(1 downto 1) & l_1_c_0_cl_73(1 downto 1) & l_1_c_0_cl_72(1 downto 1) & l_1_c_0_cl_71(1 downto 1) & l_1_c_0_cl_70(1 downto 1) & l_1_c_0_cl_69(1 downto 1) & l_1_c_0_cl_68(1 downto 1) & l_1_c_0_cl_67(1 downto 1) & l_1_c_0_cl_66(1 downto 1) & l_1_c_0_cl_65(1 downto 1) & l_1_c_0_cl_64(1 downto 1) & l_1_c_0_cl_63(1 downto 1) & l_1_c_0_cl_62(1 downto 1) & l_1_c_0_cl_61(1 downto 1) & l_1_c_0_cl_60(1 downto 1) & l_1_c_0_cl_59(1 downto 1) & l_1_c_0_cl_58(1 downto 1) & l_1_c_0_cl_57(1 downto 1) & l_1_c_0_cl_56(1 downto 1) & l_1_c_0_cl_55(1 downto 1) & l_1_c_0_cl_54(1 downto 1) & l_1_c_0_cl_53(1 downto 1) & l_1_c_0_cl_52(1 downto 1) & l_1_c_0_cl_51(1 downto 1) & l_1_c_0_cl_50(1 downto 1) & l_1_c_0_cl_49(1 downto 1) & l_1_c_0_cl_48(1 downto 1) & l_1_c_0_cl_47(1 downto 1) & l_1_c_0_cl_46(1 downto 1) & l_1_c_0_cl_45(1 downto 1) & l_1_c_0_cl_44(1 downto 1) & l_1_c_0_cl_43(1 downto 1) & l_1_c_0_cl_42(1 downto 1) & l_1_c_0_cl_41(1 downto 1) & l_1_c_0_cl_40(1 downto 1) & l_1_c_0_cl_39(1 downto 1) & l_1_c_0_cl_38(1 downto 1) & l_1_c_0_cl_37(1 downto 1) & l_1_c_0_cl_36(1 downto 1) & l_1_c_0_cl_35(1 downto 1) & l_1_c_0_cl_34(1 downto 1) & l_1_c_0_cl_33(1 downto 1) & l_1_c_0_cl_32(1 downto 1) & l_1_c_0_cl_31(1 downto 1) & l_1_c_0_cl_30(1 downto 1) & l_1_c_0_cl_29(1 downto 1) & l_1_c_0_cl_28(1 downto 1) & l_1_c_0_cl_27(1 downto 1) & l_1_c_0_cl_26(1 downto 1) & l_1_c_0_cl_25(1 downto 1) & l_1_c_0_cl_24(1 downto 1) & l_1_c_0_cl_23(1 downto 1) & l_1_c_0_cl_22(1 downto 1) & l_1_c_0_cl_21(1 downto 1) & l_1_c_0_cl_20(1 downto 1) & l_1_c_0_cl_19(1 downto 1) & l_1_c_0_cl_18(1 downto 1) & l_1_c_0_cl_17(1 downto 1) & l_1_c_0_cl_16(1 downto 1) & l_1_c_0_cl_15(1 downto 1) & l_1_c_0_cl_14(1 downto 1) & l_1_c_0_cl_13(1 downto 1) & l_1_c_0_cl_12(1 downto 1) & l_1_c_0_cl_11(1 downto 1) & l_1_c_0_cl_10(1 downto 1) & l_1_c_0_cl_9(1 downto 1) & l_1_c_0_cl_8(1 downto 1) & l_1_c_0_cl_7(1 downto 1) & l_1_c_0_cl_6(1 downto 1) & l_1_c_0_cl_5(1 downto 1) & l_1_c_0_cl_4(1 downto 1) & l_1_c_0_cl_3(1 downto 1) & l_1_c_0_cl_2(1 downto 1) & l_1_c_0_cl_1(1 downto 1) & l_1_c_0_cl_0(1 downto 1) & "0";
   l_1_s_2 <= l_1_c_0_cl_103(2 downto 2) & l_1_c_0_cl_102(2 downto 2) & l_1_c_0_cl_101(2 downto 2) & l_1_c_0_cl_100(2 downto 2) & l_1_c_0_cl_99(2 downto 2) & l_1_c_0_cl_98(2 downto 2) & l_1_c_0_cl_97(2 downto 2) & l_1_c_0_cl_96(2 downto 2) & l_1_c_0_cl_95(2 downto 2) & l_1_c_0_cl_94(2 downto 2) & l_1_c_0_cl_93(2 downto 2) & l_1_c_0_cl_92(2 downto 2) & l_1_c_0_cl_91(2 downto 2) & l_1_c_0_cl_90(2 downto 2) & l_1_c_0_cl_89(2 downto 2) & l_1_c_0_cl_88(2 downto 2) & l_1_c_0_cl_87(2 downto 2) & l_1_c_0_cl_86(2 downto 2) & l_1_c_0_cl_85(2 downto 2) & l_1_c_0_cl_84(2 downto 2) & l_1_c_0_cl_83(2 downto 2) & l_1_c_0_cl_82(2 downto 2) & l_1_c_0_cl_81(2 downto 2) & l_1_c_0_cl_80(2 downto 2) & l_1_c_0_cl_79(2 downto 2) & l_1_c_0_cl_78(2 downto 2) & l_1_c_0_cl_77(2 downto 2) & l_1_c_0_cl_76(2 downto 2) & l_1_c_0_cl_75(2 downto 2) & l_1_c_0_cl_74(2 downto 2) & l_1_c_0_cl_73(2 downto 2) & l_1_c_0_cl_72(2 downto 2) & l_1_c_0_cl_71(2 downto 2) & l_1_c_0_cl_70(2 downto 2) & l_1_c_0_cl_69(2 downto 2) & l_1_c_0_cl_68(2 downto 2) & l_1_c_0_cl_67(2 downto 2) & l_1_c_0_cl_66(2 downto 2) & l_1_c_0_cl_65(2 downto 2) & l_1_c_0_cl_64(2 downto 2) & l_1_c_0_cl_63(2 downto 2) & l_1_c_0_cl_62(2 downto 2) & l_1_c_0_cl_61(2 downto 2) & l_1_c_0_cl_60(2 downto 2) & l_1_c_0_cl_59(2 downto 2) & l_1_c_0_cl_58(2 downto 2) & l_1_c_0_cl_57(2 downto 2) & l_1_c_0_cl_56(2 downto 2) & l_1_c_0_cl_55(2 downto 2) & l_1_c_0_cl_54(2 downto 2) & l_1_c_0_cl_53(2 downto 2) & l_1_c_0_cl_52(2 downto 2) & l_1_c_0_cl_51(2 downto 2) & l_1_c_0_cl_50(2 downto 2) & l_1_c_0_cl_49(2 downto 2) & l_1_c_0_cl_48(2 downto 2) & l_1_c_0_cl_47(2 downto 2) & l_1_c_0_cl_46(2 downto 2) & l_1_c_0_cl_45(2 downto 2) & l_1_c_0_cl_44(2 downto 2) & l_1_c_0_cl_43(2 downto 2) & l_1_c_0_cl_42(2 downto 2) & l_1_c_0_cl_41(2 downto 2) & l_1_c_0_cl_40(2 downto 2) & l_1_c_0_cl_39(2 downto 2) & l_1_c_0_cl_38(2 downto 2) & l_1_c_0_cl_37(2 downto 2) & l_1_c_0_cl_36(2 downto 2) & l_1_c_0_cl_35(2 downto 2) & l_1_c_0_cl_34(2 downto 2) & l_1_c_0_cl_33(2 downto 2) & l_1_c_0_cl_32(2 downto 2) & l_1_c_0_cl_31(2 downto 2) & l_1_c_0_cl_30(2 downto 2) & l_1_c_0_cl_29(2 downto 2) & l_1_c_0_cl_28(2 downto 2) & l_1_c_0_cl_27(2 downto 2) & l_1_c_0_cl_26(2 downto 2) & l_1_c_0_cl_25(2 downto 2) & l_1_c_0_cl_24(2 downto 2) & l_1_c_0_cl_23(2 downto 2) & l_1_c_0_cl_22(2 downto 2) & l_1_c_0_cl_21(2 downto 2) & l_1_c_0_cl_20(2 downto 2) & l_1_c_0_cl_19(2 downto 2) & l_1_c_0_cl_18(2 downto 2) & l_1_c_0_cl_17(2 downto 2) & l_1_c_0_cl_16(2 downto 2) & l_1_c_0_cl_15(2 downto 2) & l_1_c_0_cl_14(2 downto 2) & l_1_c_0_cl_13(2 downto 2) & l_1_c_0_cl_12(2 downto 2) & l_1_c_0_cl_11(2 downto 2) & l_1_c_0_cl_10(2 downto 2) & l_1_c_0_cl_9(2 downto 2) & l_1_c_0_cl_8(2 downto 2) & l_1_c_0_cl_7(2 downto 2) & l_1_c_0_cl_6(2 downto 2) & l_1_c_0_cl_5(2 downto 2) & l_1_c_0_cl_4(2 downto 2) & l_1_c_0_cl_3(2 downto 2) & l_1_c_0_cl_2(2 downto 2) & l_1_c_0_cl_1(2 downto 2) & l_1_c_0_cl_0(2 downto 2) & "00";
   sell_2_c_0_cl_0 <= l_1_s_0(0) & l_1_s_1(0) & l_1_s_2(0);
    with sell_2_c_0_cl_0 select
   l_2_c_0_cl_0 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_1 <= l_1_s_0(1) & l_1_s_1(1) & l_1_s_2(1);
    with sell_2_c_0_cl_1 select
   l_2_c_0_cl_1 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_2 <= l_1_s_0(2) & l_1_s_1(2) & l_1_s_2(2);
    with sell_2_c_0_cl_2 select
   l_2_c_0_cl_2 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_3 <= l_1_s_0(3) & l_1_s_1(3) & l_1_s_2(3);
    with sell_2_c_0_cl_3 select
   l_2_c_0_cl_3 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_4 <= l_1_s_0(4) & l_1_s_1(4) & l_1_s_2(4);
    with sell_2_c_0_cl_4 select
   l_2_c_0_cl_4 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_5 <= l_1_s_0(5) & l_1_s_1(5) & l_1_s_2(5);
    with sell_2_c_0_cl_5 select
   l_2_c_0_cl_5 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_6 <= l_1_s_0(6) & l_1_s_1(6) & l_1_s_2(6);
    with sell_2_c_0_cl_6 select
   l_2_c_0_cl_6 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_7 <= l_1_s_0(7) & l_1_s_1(7) & l_1_s_2(7);
    with sell_2_c_0_cl_7 select
   l_2_c_0_cl_7 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_8 <= l_1_s_0(8) & l_1_s_1(8) & l_1_s_2(8);
    with sell_2_c_0_cl_8 select
   l_2_c_0_cl_8 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_9 <= l_1_s_0(9) & l_1_s_1(9) & l_1_s_2(9);
    with sell_2_c_0_cl_9 select
   l_2_c_0_cl_9 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_10 <= l_1_s_0(10) & l_1_s_1(10) & l_1_s_2(10);
    with sell_2_c_0_cl_10 select
   l_2_c_0_cl_10 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_11 <= l_1_s_0(11) & l_1_s_1(11) & l_1_s_2(11);
    with sell_2_c_0_cl_11 select
   l_2_c_0_cl_11 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_12 <= l_1_s_0(12) & l_1_s_1(12) & l_1_s_2(12);
    with sell_2_c_0_cl_12 select
   l_2_c_0_cl_12 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_13 <= l_1_s_0(13) & l_1_s_1(13) & l_1_s_2(13);
    with sell_2_c_0_cl_13 select
   l_2_c_0_cl_13 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_14 <= l_1_s_0(14) & l_1_s_1(14) & l_1_s_2(14);
    with sell_2_c_0_cl_14 select
   l_2_c_0_cl_14 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_15 <= l_1_s_0(15) & l_1_s_1(15) & l_1_s_2(15);
    with sell_2_c_0_cl_15 select
   l_2_c_0_cl_15 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_16 <= l_1_s_0(16) & l_1_s_1(16) & l_1_s_2(16);
    with sell_2_c_0_cl_16 select
   l_2_c_0_cl_16 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_17 <= l_1_s_0(17) & l_1_s_1(17) & l_1_s_2(17);
    with sell_2_c_0_cl_17 select
   l_2_c_0_cl_17 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_18 <= l_1_s_0(18) & l_1_s_1(18) & l_1_s_2(18);
    with sell_2_c_0_cl_18 select
   l_2_c_0_cl_18 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_19 <= l_1_s_0(19) & l_1_s_1(19) & l_1_s_2(19);
    with sell_2_c_0_cl_19 select
   l_2_c_0_cl_19 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_20 <= l_1_s_0(20) & l_1_s_1(20) & l_1_s_2(20);
    with sell_2_c_0_cl_20 select
   l_2_c_0_cl_20 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_21 <= l_1_s_0(21) & l_1_s_1(21) & l_1_s_2(21);
    with sell_2_c_0_cl_21 select
   l_2_c_0_cl_21 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_22 <= l_1_s_0(22) & l_1_s_1(22) & l_1_s_2(22);
    with sell_2_c_0_cl_22 select
   l_2_c_0_cl_22 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_23 <= l_1_s_0(23) & l_1_s_1(23) & l_1_s_2(23);
    with sell_2_c_0_cl_23 select
   l_2_c_0_cl_23 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_24 <= l_1_s_0(24) & l_1_s_1(24) & l_1_s_2(24);
    with sell_2_c_0_cl_24 select
   l_2_c_0_cl_24 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_25 <= l_1_s_0(25) & l_1_s_1(25) & l_1_s_2(25);
    with sell_2_c_0_cl_25 select
   l_2_c_0_cl_25 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_26 <= l_1_s_0(26) & l_1_s_1(26) & l_1_s_2(26);
    with sell_2_c_0_cl_26 select
   l_2_c_0_cl_26 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_27 <= l_1_s_0(27) & l_1_s_1(27) & l_1_s_2(27);
    with sell_2_c_0_cl_27 select
   l_2_c_0_cl_27 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_28 <= l_1_s_0(28) & l_1_s_1(28) & l_1_s_2(28);
    with sell_2_c_0_cl_28 select
   l_2_c_0_cl_28 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_29 <= l_1_s_0(29) & l_1_s_1(29) & l_1_s_2(29);
    with sell_2_c_0_cl_29 select
   l_2_c_0_cl_29 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_30 <= l_1_s_0(30) & l_1_s_1(30) & l_1_s_2(30);
    with sell_2_c_0_cl_30 select
   l_2_c_0_cl_30 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_31 <= l_1_s_0(31) & l_1_s_1(31) & l_1_s_2(31);
    with sell_2_c_0_cl_31 select
   l_2_c_0_cl_31 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_32 <= l_1_s_0(32) & l_1_s_1(32) & l_1_s_2(32);
    with sell_2_c_0_cl_32 select
   l_2_c_0_cl_32 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_33 <= l_1_s_0(33) & l_1_s_1(33) & l_1_s_2(33);
    with sell_2_c_0_cl_33 select
   l_2_c_0_cl_33 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_34 <= l_1_s_0(34) & l_1_s_1(34) & l_1_s_2(34);
    with sell_2_c_0_cl_34 select
   l_2_c_0_cl_34 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_35 <= l_1_s_0(35) & l_1_s_1(35) & l_1_s_2(35);
    with sell_2_c_0_cl_35 select
   l_2_c_0_cl_35 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_36 <= l_1_s_0(36) & l_1_s_1(36) & l_1_s_2(36);
    with sell_2_c_0_cl_36 select
   l_2_c_0_cl_36 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_37 <= l_1_s_0(37) & l_1_s_1(37) & l_1_s_2(37);
    with sell_2_c_0_cl_37 select
   l_2_c_0_cl_37 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_38 <= l_1_s_0(38) & l_1_s_1(38) & l_1_s_2(38);
    with sell_2_c_0_cl_38 select
   l_2_c_0_cl_38 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_39 <= l_1_s_0(39) & l_1_s_1(39) & l_1_s_2(39);
    with sell_2_c_0_cl_39 select
   l_2_c_0_cl_39 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_40 <= l_1_s_0(40) & l_1_s_1(40) & l_1_s_2(40);
    with sell_2_c_0_cl_40 select
   l_2_c_0_cl_40 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_41 <= l_1_s_0(41) & l_1_s_1(41) & l_1_s_2(41);
    with sell_2_c_0_cl_41 select
   l_2_c_0_cl_41 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_42 <= l_1_s_0(42) & l_1_s_1(42) & l_1_s_2(42);
    with sell_2_c_0_cl_42 select
   l_2_c_0_cl_42 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_43 <= l_1_s_0(43) & l_1_s_1(43) & l_1_s_2(43);
    with sell_2_c_0_cl_43 select
   l_2_c_0_cl_43 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_44 <= l_1_s_0(44) & l_1_s_1(44) & l_1_s_2(44);
    with sell_2_c_0_cl_44 select
   l_2_c_0_cl_44 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_45 <= l_1_s_0(45) & l_1_s_1(45) & l_1_s_2(45);
    with sell_2_c_0_cl_45 select
   l_2_c_0_cl_45 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_46 <= l_1_s_0(46) & l_1_s_1(46) & l_1_s_2(46);
    with sell_2_c_0_cl_46 select
   l_2_c_0_cl_46 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_47 <= l_1_s_0(47) & l_1_s_1(47) & l_1_s_2(47);
    with sell_2_c_0_cl_47 select
   l_2_c_0_cl_47 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_48 <= l_1_s_0(48) & l_1_s_1(48) & l_1_s_2(48);
    with sell_2_c_0_cl_48 select
   l_2_c_0_cl_48 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_49 <= l_1_s_0(49) & l_1_s_1(49) & l_1_s_2(49);
    with sell_2_c_0_cl_49 select
   l_2_c_0_cl_49 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_50 <= l_1_s_0(50) & l_1_s_1(50) & l_1_s_2(50);
    with sell_2_c_0_cl_50 select
   l_2_c_0_cl_50 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_51 <= l_1_s_0(51) & l_1_s_1(51) & l_1_s_2(51);
    with sell_2_c_0_cl_51 select
   l_2_c_0_cl_51 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_52 <= l_1_s_0(52) & l_1_s_1(52) & l_1_s_2(52);
    with sell_2_c_0_cl_52 select
   l_2_c_0_cl_52 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_53 <= l_1_s_0(53) & l_1_s_1(53) & l_1_s_2(53);
    with sell_2_c_0_cl_53 select
   l_2_c_0_cl_53 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_54 <= l_1_s_0(54) & l_1_s_1(54) & l_1_s_2(54);
    with sell_2_c_0_cl_54 select
   l_2_c_0_cl_54 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_55 <= l_1_s_0(55) & l_1_s_1(55) & l_1_s_2(55);
    with sell_2_c_0_cl_55 select
   l_2_c_0_cl_55 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_56 <= l_1_s_0(56) & l_1_s_1(56) & l_1_s_2(56);
    with sell_2_c_0_cl_56 select
   l_2_c_0_cl_56 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_57 <= l_1_s_0(57) & l_1_s_1(57) & l_1_s_2(57);
    with sell_2_c_0_cl_57 select
   l_2_c_0_cl_57 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_58 <= l_1_s_0(58) & l_1_s_1(58) & l_1_s_2(58);
    with sell_2_c_0_cl_58 select
   l_2_c_0_cl_58 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_59 <= l_1_s_0(59) & l_1_s_1(59) & l_1_s_2(59);
    with sell_2_c_0_cl_59 select
   l_2_c_0_cl_59 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_60 <= l_1_s_0(60) & l_1_s_1(60) & l_1_s_2(60);
    with sell_2_c_0_cl_60 select
   l_2_c_0_cl_60 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_61 <= l_1_s_0(61) & l_1_s_1(61) & l_1_s_2(61);
    with sell_2_c_0_cl_61 select
   l_2_c_0_cl_61 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_62 <= l_1_s_0(62) & l_1_s_1(62) & l_1_s_2(62);
    with sell_2_c_0_cl_62 select
   l_2_c_0_cl_62 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_63 <= l_1_s_0(63) & l_1_s_1(63) & l_1_s_2(63);
    with sell_2_c_0_cl_63 select
   l_2_c_0_cl_63 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_64 <= l_1_s_0(64) & l_1_s_1(64) & l_1_s_2(64);
    with sell_2_c_0_cl_64 select
   l_2_c_0_cl_64 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_65 <= l_1_s_0(65) & l_1_s_1(65) & l_1_s_2(65);
    with sell_2_c_0_cl_65 select
   l_2_c_0_cl_65 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_66 <= l_1_s_0(66) & l_1_s_1(66) & l_1_s_2(66);
    with sell_2_c_0_cl_66 select
   l_2_c_0_cl_66 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_67 <= l_1_s_0(67) & l_1_s_1(67) & l_1_s_2(67);
    with sell_2_c_0_cl_67 select
   l_2_c_0_cl_67 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_68 <= l_1_s_0(68) & l_1_s_1(68) & l_1_s_2(68);
    with sell_2_c_0_cl_68 select
   l_2_c_0_cl_68 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_69 <= l_1_s_0(69) & l_1_s_1(69) & l_1_s_2(69);
    with sell_2_c_0_cl_69 select
   l_2_c_0_cl_69 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_70 <= l_1_s_0(70) & l_1_s_1(70) & l_1_s_2(70);
    with sell_2_c_0_cl_70 select
   l_2_c_0_cl_70 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_71 <= l_1_s_0(71) & l_1_s_1(71) & l_1_s_2(71);
    with sell_2_c_0_cl_71 select
   l_2_c_0_cl_71 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_72 <= l_1_s_0(72) & l_1_s_1(72) & l_1_s_2(72);
    with sell_2_c_0_cl_72 select
   l_2_c_0_cl_72 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_73 <= l_1_s_0(73) & l_1_s_1(73) & l_1_s_2(73);
    with sell_2_c_0_cl_73 select
   l_2_c_0_cl_73 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_74 <= l_1_s_0(74) & l_1_s_1(74) & l_1_s_2(74);
    with sell_2_c_0_cl_74 select
   l_2_c_0_cl_74 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_75 <= l_1_s_0(75) & l_1_s_1(75) & l_1_s_2(75);
    with sell_2_c_0_cl_75 select
   l_2_c_0_cl_75 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_76 <= l_1_s_0(76) & l_1_s_1(76) & l_1_s_2(76);
    with sell_2_c_0_cl_76 select
   l_2_c_0_cl_76 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_77 <= l_1_s_0(77) & l_1_s_1(77) & l_1_s_2(77);
    with sell_2_c_0_cl_77 select
   l_2_c_0_cl_77 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_78 <= l_1_s_0(78) & l_1_s_1(78) & l_1_s_2(78);
    with sell_2_c_0_cl_78 select
   l_2_c_0_cl_78 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_79 <= l_1_s_0(79) & l_1_s_1(79) & l_1_s_2(79);
    with sell_2_c_0_cl_79 select
   l_2_c_0_cl_79 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_80 <= l_1_s_0(80) & l_1_s_1(80) & l_1_s_2(80);
    with sell_2_c_0_cl_80 select
   l_2_c_0_cl_80 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_81 <= l_1_s_0(81) & l_1_s_1(81) & l_1_s_2(81);
    with sell_2_c_0_cl_81 select
   l_2_c_0_cl_81 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_82 <= l_1_s_0(82) & l_1_s_1(82) & l_1_s_2(82);
    with sell_2_c_0_cl_82 select
   l_2_c_0_cl_82 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_83 <= l_1_s_0(83) & l_1_s_1(83) & l_1_s_2(83);
    with sell_2_c_0_cl_83 select
   l_2_c_0_cl_83 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_84 <= l_1_s_0(84) & l_1_s_1(84) & l_1_s_2(84);
    with sell_2_c_0_cl_84 select
   l_2_c_0_cl_84 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_85 <= l_1_s_0(85) & l_1_s_1(85) & l_1_s_2(85);
    with sell_2_c_0_cl_85 select
   l_2_c_0_cl_85 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_86 <= l_1_s_0(86) & l_1_s_1(86) & l_1_s_2(86);
    with sell_2_c_0_cl_86 select
   l_2_c_0_cl_86 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_87 <= l_1_s_0(87) & l_1_s_1(87) & l_1_s_2(87);
    with sell_2_c_0_cl_87 select
   l_2_c_0_cl_87 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_88 <= l_1_s_0(88) & l_1_s_1(88) & l_1_s_2(88);
    with sell_2_c_0_cl_88 select
   l_2_c_0_cl_88 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_89 <= l_1_s_0(89) & l_1_s_1(89) & l_1_s_2(89);
    with sell_2_c_0_cl_89 select
   l_2_c_0_cl_89 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_90 <= l_1_s_0(90) & l_1_s_1(90) & l_1_s_2(90);
    with sell_2_c_0_cl_90 select
   l_2_c_0_cl_90 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_91 <= l_1_s_0(91) & l_1_s_1(91) & l_1_s_2(91);
    with sell_2_c_0_cl_91 select
   l_2_c_0_cl_91 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_92 <= l_1_s_0(92) & l_1_s_1(92) & l_1_s_2(92);
    with sell_2_c_0_cl_92 select
   l_2_c_0_cl_92 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_93 <= l_1_s_0(93) & l_1_s_1(93) & l_1_s_2(93);
    with sell_2_c_0_cl_93 select
   l_2_c_0_cl_93 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_94 <= l_1_s_0(94) & l_1_s_1(94) & l_1_s_2(94);
    with sell_2_c_0_cl_94 select
   l_2_c_0_cl_94 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_95 <= l_1_s_0(95) & l_1_s_1(95) & l_1_s_2(95);
    with sell_2_c_0_cl_95 select
   l_2_c_0_cl_95 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_96 <= l_1_s_0(96) & l_1_s_1(96) & l_1_s_2(96);
    with sell_2_c_0_cl_96 select
   l_2_c_0_cl_96 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_97 <= l_1_s_0(97) & l_1_s_1(97) & l_1_s_2(97);
    with sell_2_c_0_cl_97 select
   l_2_c_0_cl_97 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_98 <= l_1_s_0(98) & l_1_s_1(98) & l_1_s_2(98);
    with sell_2_c_0_cl_98 select
   l_2_c_0_cl_98 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_99 <= l_1_s_0(99) & l_1_s_1(99) & l_1_s_2(99);
    with sell_2_c_0_cl_99 select
   l_2_c_0_cl_99 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_100 <= l_1_s_0(100) & l_1_s_1(100) & l_1_s_2(100);
    with sell_2_c_0_cl_100 select
   l_2_c_0_cl_100 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_101 <= l_1_s_0(101) & l_1_s_1(101) & l_1_s_2(101);
    with sell_2_c_0_cl_101 select
   l_2_c_0_cl_101 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_102 <= l_1_s_0(102) & l_1_s_1(102) & l_1_s_2(102);
    with sell_2_c_0_cl_102 select
   l_2_c_0_cl_102 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_103 <= l_1_s_0(103) & l_1_s_1(103) & l_1_s_2(103);
    with sell_2_c_0_cl_103 select
   l_2_c_0_cl_103 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_104 <= l_1_s_0(104) & l_1_s_1(104) & l_1_s_2(104);
    with sell_2_c_0_cl_104 select
   l_2_c_0_cl_104 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   sell_2_c_0_cl_105 <= l_1_s_0(105) & l_1_s_1(105) & l_1_s_2(105);
    with sell_2_c_0_cl_105 select
   l_2_c_0_cl_105 <= 
   "00" when "000",   "01" when "001",   "01" when "010",   "10" when "011",   "01" when "100",   "10" when "101",   "10" when "110",   "11" when "111",   "00" when others;
   l_2_s_0 <= l_2_c_0_cl_105(0 downto 0) & l_2_c_0_cl_104(0 downto 0) & l_2_c_0_cl_103(0 downto 0) & l_2_c_0_cl_102(0 downto 0) & l_2_c_0_cl_101(0 downto 0) & l_2_c_0_cl_100(0 downto 0) & l_2_c_0_cl_99(0 downto 0) & l_2_c_0_cl_98(0 downto 0) & l_2_c_0_cl_97(0 downto 0) & l_2_c_0_cl_96(0 downto 0) & l_2_c_0_cl_95(0 downto 0) & l_2_c_0_cl_94(0 downto 0) & l_2_c_0_cl_93(0 downto 0) & l_2_c_0_cl_92(0 downto 0) & l_2_c_0_cl_91(0 downto 0) & l_2_c_0_cl_90(0 downto 0) & l_2_c_0_cl_89(0 downto 0) & l_2_c_0_cl_88(0 downto 0) & l_2_c_0_cl_87(0 downto 0) & l_2_c_0_cl_86(0 downto 0) & l_2_c_0_cl_85(0 downto 0) & l_2_c_0_cl_84(0 downto 0) & l_2_c_0_cl_83(0 downto 0) & l_2_c_0_cl_82(0 downto 0) & l_2_c_0_cl_81(0 downto 0) & l_2_c_0_cl_80(0 downto 0) & l_2_c_0_cl_79(0 downto 0) & l_2_c_0_cl_78(0 downto 0) & l_2_c_0_cl_77(0 downto 0) & l_2_c_0_cl_76(0 downto 0) & l_2_c_0_cl_75(0 downto 0) & l_2_c_0_cl_74(0 downto 0) & l_2_c_0_cl_73(0 downto 0) & l_2_c_0_cl_72(0 downto 0) & l_2_c_0_cl_71(0 downto 0) & l_2_c_0_cl_70(0 downto 0) & l_2_c_0_cl_69(0 downto 0) & l_2_c_0_cl_68(0 downto 0) & l_2_c_0_cl_67(0 downto 0) & l_2_c_0_cl_66(0 downto 0) & l_2_c_0_cl_65(0 downto 0) & l_2_c_0_cl_64(0 downto 0) & l_2_c_0_cl_63(0 downto 0) & l_2_c_0_cl_62(0 downto 0) & l_2_c_0_cl_61(0 downto 0) & l_2_c_0_cl_60(0 downto 0) & l_2_c_0_cl_59(0 downto 0) & l_2_c_0_cl_58(0 downto 0) & l_2_c_0_cl_57(0 downto 0) & l_2_c_0_cl_56(0 downto 0) & l_2_c_0_cl_55(0 downto 0) & l_2_c_0_cl_54(0 downto 0) & l_2_c_0_cl_53(0 downto 0) & l_2_c_0_cl_52(0 downto 0) & l_2_c_0_cl_51(0 downto 0) & l_2_c_0_cl_50(0 downto 0) & l_2_c_0_cl_49(0 downto 0) & l_2_c_0_cl_48(0 downto 0) & l_2_c_0_cl_47(0 downto 0) & l_2_c_0_cl_46(0 downto 0) & l_2_c_0_cl_45(0 downto 0) & l_2_c_0_cl_44(0 downto 0) & l_2_c_0_cl_43(0 downto 0) & l_2_c_0_cl_42(0 downto 0) & l_2_c_0_cl_41(0 downto 0) & l_2_c_0_cl_40(0 downto 0) & l_2_c_0_cl_39(0 downto 0) & l_2_c_0_cl_38(0 downto 0) & l_2_c_0_cl_37(0 downto 0) & l_2_c_0_cl_36(0 downto 0) & l_2_c_0_cl_35(0 downto 0) & l_2_c_0_cl_34(0 downto 0) & l_2_c_0_cl_33(0 downto 0) & l_2_c_0_cl_32(0 downto 0) & l_2_c_0_cl_31(0 downto 0) & l_2_c_0_cl_30(0 downto 0) & l_2_c_0_cl_29(0 downto 0) & l_2_c_0_cl_28(0 downto 0) & l_2_c_0_cl_27(0 downto 0) & l_2_c_0_cl_26(0 downto 0) & l_2_c_0_cl_25(0 downto 0) & l_2_c_0_cl_24(0 downto 0) & l_2_c_0_cl_23(0 downto 0) & l_2_c_0_cl_22(0 downto 0) & l_2_c_0_cl_21(0 downto 0) & l_2_c_0_cl_20(0 downto 0) & l_2_c_0_cl_19(0 downto 0) & l_2_c_0_cl_18(0 downto 0) & l_2_c_0_cl_17(0 downto 0) & l_2_c_0_cl_16(0 downto 0) & l_2_c_0_cl_15(0 downto 0) & l_2_c_0_cl_14(0 downto 0) & l_2_c_0_cl_13(0 downto 0) & l_2_c_0_cl_12(0 downto 0) & l_2_c_0_cl_11(0 downto 0) & l_2_c_0_cl_10(0 downto 0) & l_2_c_0_cl_9(0 downto 0) & l_2_c_0_cl_8(0 downto 0) & l_2_c_0_cl_7(0 downto 0) & l_2_c_0_cl_6(0 downto 0) & l_2_c_0_cl_5(0 downto 0) & l_2_c_0_cl_4(0 downto 0) & l_2_c_0_cl_3(0 downto 0) & l_2_c_0_cl_2(0 downto 0) & l_2_c_0_cl_1(0 downto 0) & l_2_c_0_cl_0(0 downto 0);
   l_2_s_1 <= l_2_c_0_cl_104(1 downto 1) & l_2_c_0_cl_103(1 downto 1) & l_2_c_0_cl_102(1 downto 1) & l_2_c_0_cl_101(1 downto 1) & l_2_c_0_cl_100(1 downto 1) & l_2_c_0_cl_99(1 downto 1) & l_2_c_0_cl_98(1 downto 1) & l_2_c_0_cl_97(1 downto 1) & l_2_c_0_cl_96(1 downto 1) & l_2_c_0_cl_95(1 downto 1) & l_2_c_0_cl_94(1 downto 1) & l_2_c_0_cl_93(1 downto 1) & l_2_c_0_cl_92(1 downto 1) & l_2_c_0_cl_91(1 downto 1) & l_2_c_0_cl_90(1 downto 1) & l_2_c_0_cl_89(1 downto 1) & l_2_c_0_cl_88(1 downto 1) & l_2_c_0_cl_87(1 downto 1) & l_2_c_0_cl_86(1 downto 1) & l_2_c_0_cl_85(1 downto 1) & l_2_c_0_cl_84(1 downto 1) & l_2_c_0_cl_83(1 downto 1) & l_2_c_0_cl_82(1 downto 1) & l_2_c_0_cl_81(1 downto 1) & l_2_c_0_cl_80(1 downto 1) & l_2_c_0_cl_79(1 downto 1) & l_2_c_0_cl_78(1 downto 1) & l_2_c_0_cl_77(1 downto 1) & l_2_c_0_cl_76(1 downto 1) & l_2_c_0_cl_75(1 downto 1) & l_2_c_0_cl_74(1 downto 1) & l_2_c_0_cl_73(1 downto 1) & l_2_c_0_cl_72(1 downto 1) & l_2_c_0_cl_71(1 downto 1) & l_2_c_0_cl_70(1 downto 1) & l_2_c_0_cl_69(1 downto 1) & l_2_c_0_cl_68(1 downto 1) & l_2_c_0_cl_67(1 downto 1) & l_2_c_0_cl_66(1 downto 1) & l_2_c_0_cl_65(1 downto 1) & l_2_c_0_cl_64(1 downto 1) & l_2_c_0_cl_63(1 downto 1) & l_2_c_0_cl_62(1 downto 1) & l_2_c_0_cl_61(1 downto 1) & l_2_c_0_cl_60(1 downto 1) & l_2_c_0_cl_59(1 downto 1) & l_2_c_0_cl_58(1 downto 1) & l_2_c_0_cl_57(1 downto 1) & l_2_c_0_cl_56(1 downto 1) & l_2_c_0_cl_55(1 downto 1) & l_2_c_0_cl_54(1 downto 1) & l_2_c_0_cl_53(1 downto 1) & l_2_c_0_cl_52(1 downto 1) & l_2_c_0_cl_51(1 downto 1) & l_2_c_0_cl_50(1 downto 1) & l_2_c_0_cl_49(1 downto 1) & l_2_c_0_cl_48(1 downto 1) & l_2_c_0_cl_47(1 downto 1) & l_2_c_0_cl_46(1 downto 1) & l_2_c_0_cl_45(1 downto 1) & l_2_c_0_cl_44(1 downto 1) & l_2_c_0_cl_43(1 downto 1) & l_2_c_0_cl_42(1 downto 1) & l_2_c_0_cl_41(1 downto 1) & l_2_c_0_cl_40(1 downto 1) & l_2_c_0_cl_39(1 downto 1) & l_2_c_0_cl_38(1 downto 1) & l_2_c_0_cl_37(1 downto 1) & l_2_c_0_cl_36(1 downto 1) & l_2_c_0_cl_35(1 downto 1) & l_2_c_0_cl_34(1 downto 1) & l_2_c_0_cl_33(1 downto 1) & l_2_c_0_cl_32(1 downto 1) & l_2_c_0_cl_31(1 downto 1) & l_2_c_0_cl_30(1 downto 1) & l_2_c_0_cl_29(1 downto 1) & l_2_c_0_cl_28(1 downto 1) & l_2_c_0_cl_27(1 downto 1) & l_2_c_0_cl_26(1 downto 1) & l_2_c_0_cl_25(1 downto 1) & l_2_c_0_cl_24(1 downto 1) & l_2_c_0_cl_23(1 downto 1) & l_2_c_0_cl_22(1 downto 1) & l_2_c_0_cl_21(1 downto 1) & l_2_c_0_cl_20(1 downto 1) & l_2_c_0_cl_19(1 downto 1) & l_2_c_0_cl_18(1 downto 1) & l_2_c_0_cl_17(1 downto 1) & l_2_c_0_cl_16(1 downto 1) & l_2_c_0_cl_15(1 downto 1) & l_2_c_0_cl_14(1 downto 1) & l_2_c_0_cl_13(1 downto 1) & l_2_c_0_cl_12(1 downto 1) & l_2_c_0_cl_11(1 downto 1) & l_2_c_0_cl_10(1 downto 1) & l_2_c_0_cl_9(1 downto 1) & l_2_c_0_cl_8(1 downto 1) & l_2_c_0_cl_7(1 downto 1) & l_2_c_0_cl_6(1 downto 1) & l_2_c_0_cl_5(1 downto 1) & l_2_c_0_cl_4(1 downto 1) & l_2_c_0_cl_3(1 downto 1) & l_2_c_0_cl_2(1 downto 1) & l_2_c_0_cl_1(1 downto 1) & l_2_c_0_cl_0(1 downto 1) & "0";
   FinalAdder_CompressorTree: IntAdder_106_f200_uid29  -- pipelineDepth=1 maxInDelay=2.03808e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => '0',
                 R => myR,
                 X => l_2_s_0,
                 Y => l_2_s_1);

   ----------------Synchro barrier, entering cycle 1----------------
   R <= myR;
 -- delay at adder output 8.29e-10
end architecture;

--------------------------------------------------------------------------------
--                   IntTruncMultiplier_53_53_106_unsigned
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Sebastian Banescu, Bogdan Pasca, Radu Tudoran (2010-2011)
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library work;
entity IntTruncMultiplier_53_53_106_unsigned is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(52 downto 0);
          Y : in  std_logic_vector(52 downto 0);
          R : out  std_logic_vector(105 downto 0)   );
end entity;

architecture arch of IntTruncMultiplier_53_53_106_unsigned is
   component IntMultiAdder_106_op4_f200_uid25 is
      port ( clk, rst : in std_logic;
             X0 : in  std_logic_vector(105 downto 0);
             X1 : in  std_logic_vector(105 downto 0);
             X2 : in  std_logic_vector(105 downto 0);
             X3 : in  std_logic_vector(105 downto 0);
             R : out  std_logic_vector(105 downto 0)   );
   end component;

   component LogicIntMultiplier_24_2_uid17_1 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(1 downto 0);
             R : out  std_logic_vector(25 downto 0)   );
   end component;

   component LogicIntMultiplier_5_34_uid5_0 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(4 downto 0);
             Y : in  std_logic_vector(33 downto 0);
             R : out  std_logic_vector(38 downto 0)   );
   end component;

signal x0_0 :  std_logic_vector(17 downto 0);
signal y0_0 :  std_logic_vector(24 downto 0);
signal pxy00, pxy00_d1, pxy00_d2, pxy00_d3, pxy00_d4 :  std_logic_vector(42 downto 0);
signal x0_1, x0_1_d1 :  std_logic_vector(17 downto 0);
signal y0_1, y0_1_d1 :  std_logic_vector(24 downto 0);
signal txy01 :  std_logic_vector(42 downto 0);
signal pxy01, pxy01_d1, pxy01_d2, pxy01_d3 :  std_logic_vector(42 downto 0);
signal x0_2, x0_2_d1, x0_2_d2 :  std_logic_vector(24 downto 0);
signal y0_2, y0_2_d1, y0_2_d2 :  std_logic_vector(17 downto 0);
signal txy02 :  std_logic_vector(42 downto 0);
signal pxy02, pxy02_d1, pxy02_d2 :  std_logic_vector(42 downto 0);
signal x0_3, x0_3_d1, x0_3_d2, x0_3_d3 :  std_logic_vector(24 downto 0);
signal y0_3, y0_3_d1, y0_3_d2, y0_3_d3 :  std_logic_vector(17 downto 0);
signal txy03 :  std_logic_vector(42 downto 0);
signal pxy03, pxy03_d1 :  std_logic_vector(42 downto 0);
signal addOpDSP0 :  std_logic_vector(105 downto 0);
signal x3_0 :  std_logic_vector(24 downto 0);
signal y3_0 :  std_logic_vector(17 downto 0);
signal pxy30, pxy30_d1, pxy30_d2, pxy30_d3 :  std_logic_vector(42 downto 0);
signal x3_1, x3_1_d1 :  std_logic_vector(24 downto 0);
signal y3_1, y3_1_d1 :  std_logic_vector(17 downto 0);
signal txy31 :  std_logic_vector(42 downto 0);
signal pxy31, pxy31_d1, pxy31_d2 :  std_logic_vector(42 downto 0);
signal x3_2, x3_2_d1, x3_2_d2 :  std_logic_vector(24 downto 0);
signal y3_2, y3_2_d1, y3_2_d2 :  std_logic_vector(17 downto 0);
signal txy32 :  std_logic_vector(42 downto 0);
signal pxy32, pxy32_d1 :  std_logic_vector(42 downto 0);
signal addOpDSP1, addOpDSP1_d1 :  std_logic_vector(105 downto 0);
signal x_0 :  std_logic_vector(4 downto 0);
signal y_0 :  std_logic_vector(33 downto 0);
signal result0 :  std_logic_vector(38 downto 0);
signal addOpSlice0, addOpSlice0_d1, addOpSlice0_d2, addOpSlice0_d3 :  std_logic_vector(105 downto 0);
signal x_1 :  std_logic_vector(23 downto 0);
signal y_1 :  std_logic_vector(1 downto 0);
signal result1 :  std_logic_vector(25 downto 0);
signal addOpSlice1, addOpSlice1_d1, addOpSlice1_d2, addOpSlice1_d3, addOpSlice1_d4 :  std_logic_vector(105 downto 0);
signal addRes :  std_logic_vector(105 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            pxy00_d1 <=  pxy00;
            pxy00_d2 <=  pxy00_d1;
            pxy00_d3 <=  pxy00_d2;
            pxy00_d4 <=  pxy00_d3;
            x0_1_d1 <=  x0_1;
            y0_1_d1 <=  y0_1;
            pxy01_d1 <=  pxy01;
            pxy01_d2 <=  pxy01_d1;
            pxy01_d3 <=  pxy01_d2;
            x0_2_d1 <=  x0_2;
            x0_2_d2 <=  x0_2_d1;
            y0_2_d1 <=  y0_2;
            y0_2_d2 <=  y0_2_d1;
            pxy02_d1 <=  pxy02;
            pxy02_d2 <=  pxy02_d1;
            x0_3_d1 <=  x0_3;
            x0_3_d2 <=  x0_3_d1;
            x0_3_d3 <=  x0_3_d2;
            y0_3_d1 <=  y0_3;
            y0_3_d2 <=  y0_3_d1;
            y0_3_d3 <=  y0_3_d2;
            pxy03_d1 <=  pxy03;
            pxy30_d1 <=  pxy30;
            pxy30_d2 <=  pxy30_d1;
            pxy30_d3 <=  pxy30_d2;
            x3_1_d1 <=  x3_1;
            y3_1_d1 <=  y3_1;
            pxy31_d1 <=  pxy31;
            pxy31_d2 <=  pxy31_d1;
            x3_2_d1 <=  x3_2;
            x3_2_d2 <=  x3_2_d1;
            y3_2_d1 <=  y3_2;
            y3_2_d2 <=  y3_2_d1;
            pxy32_d1 <=  pxy32;
            addOpDSP1_d1 <=  addOpDSP1;
            addOpSlice0_d1 <=  addOpSlice0;
            addOpSlice0_d2 <=  addOpSlice0_d1;
            addOpSlice0_d3 <=  addOpSlice0_d2;
            addOpSlice1_d1 <=  addOpSlice1;
            addOpSlice1_d2 <=  addOpSlice1_d1;
            addOpSlice1_d3 <=  addOpSlice1_d2;
            addOpSlice1_d4 <=  addOpSlice1_d3;
         end if;
      end process;
   ----------------Synchro barrier, entering cycle 0----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x0_0 <= "0" & "" & X(11 downto 0) & "00000";
   y0_0 <= "0" & "" & Y(18 downto 0) & "00000";
   pxy00 <= x0_0(17 downto 0) * y0_0(24 downto 0); --0
   ----------------Synchro barrier, entering cycle 0----------------
   x0_1 <= "0" & "" & X(28 downto 12) & "";
   y0_1 <= "0" & "" & Y(18 downto 0) & "00000";
   ----------------Synchro barrier, entering cycle 1----------------
   txy01 <= x0_1_d1(17 downto 0) * y0_1_d1(24 downto 0);
   pxy01 <= (txy01(42 downto 0)) + ("00000000000000000" &pxy00_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 4----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x0_2 <= "0" & "" & X(28 downto 5) & "";
   y0_2 <= "0" & "" & Y(35 downto 19) & "";
   ----------------Synchro barrier, entering cycle 2----------------
   txy02 <= x0_2_d2(24 downto 0) * y0_2_d2(17 downto 0);
   pxy02 <= (txy02(42 downto 0)) + ("00000000000000000" &pxy01_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 4----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x0_3 <= "0" & "" & X(28 downto 5) & "";
   y0_3 <= "0" & "" & Y(52 downto 36) & "";
   ----------------Synchro barrier, entering cycle 3----------------
   txy03 <= x0_3_d3(24 downto 0) * y0_3_d3(17 downto 0);
   pxy03 <= (txy03(42 downto 0)) + ("00000000000000000" &pxy02_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 4----------------
   addOpDSP0 <= "000000000000000000000000" & pxy03_d1(40 downto 0) & pxy02_d2(16 downto 0) & pxy01_d3(16 downto 0) & pxy00_d4(16 downto 10) & "" &  "";--3 bpadX 5 bpadY 5
   ----------------Synchro barrier, entering cycle 0----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x3_0 <= "0" & "" & X(52 downto 29) & "";
   y3_0 <= "0" & "" & Y(18 downto 2) & "";
   pxy30 <= x3_0(24 downto 0) * y3_0(17 downto 0); --0
   ----------------Synchro barrier, entering cycle 0----------------
   x3_1 <= "0" & "" & X(52 downto 29) & "";
   y3_1 <= "0" & "" & Y(35 downto 19) & "";
   ----------------Synchro barrier, entering cycle 1----------------
   txy31 <= x3_1_d1(24 downto 0) * y3_1_d1(17 downto 0);
   pxy31 <= (txy31(42 downto 0)) + ("00000000000000000" &pxy30_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 3----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x3_2 <= "0" & "" & X(52 downto 29) & "";
   y3_2 <= "0" & "" & Y(52 downto 36) & "";
   ----------------Synchro barrier, entering cycle 2----------------
   txy32 <= x3_2_d2(24 downto 0) * y3_2_d2(17 downto 0);
   pxy32 <= (txy32(42 downto 0)) + ("00000000000000000" &pxy31_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 3----------------
   addOpDSP1 <= "" & pxy32_d1(40 downto 0) & pxy31_d2(16 downto 0) & pxy30_d3(16 downto 0) & "0000000000000000000000000000000" &  "";--3 bpadX 0 bpadY 0
   ----------------Synchro barrier, entering cycle 0----------------
   x_0 <= X(4 downto 0);
   y_0 <= Y(52 downto 19);
   Mult0: LogicIntMultiplier_5_34_uid5_0  -- pipelineDepth=1 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => result0,
                 X => x_0,
                 Y => y_0);
   ----------------Synchro barrier, entering cycle 1----------------
   addOpSlice0 <= "000000000000000000000000000000000000000000000000" & result0 & "0000000000000000000";
   ----------------Synchro barrier, entering cycle 0----------------
   x_1 <= X(52 downto 29);
   y_1 <= Y(1 downto 0);
   Mult1: LogicIntMultiplier_24_2_uid17_1  -- pipelineDepth=0 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => result1,
                 X => x_1,
                 Y => y_1);
   addOpSlice1 <= "000000000000000000000000000000000000000000000000000" & result1 & "00000000000000000000000000000";
   ----------------Synchro barrier, entering cycle 4----------------
   adder: IntMultiAdder_106_op4_f200_uid25  -- pipelineDepth=1 maxInDelay=4.4472e-10
      port map ( clk  => clk,
                 rst  => rst,
                 R => addRes,
                 X0 => addOpDSP0,
                 X1 => addOpDSP1_d1,
                 X2 => addOpSlice0_d3,
                 X3 => addOpSlice1_d4);
   ----------------Synchro barrier, entering cycle 5----------------
   R <= addRes(105 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_65_f200_uid35
--                     (IntAdderClassical_65_f200_uid37)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntAdder_65_f200_uid35 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(64 downto 0);
          Y : in  std_logic_vector(64 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(64 downto 0)   );
end entity;

architecture arch of IntAdder_65_f200_uid35 is
signal X_d1 :  std_logic_vector(64 downto 0);
signal Y_d1 :  std_logic_vector(64 downto 0);
signal Cin_d1 : std_logic;
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            X_d1 <=  X;
            Y_d1 <=  Y;
            Cin_d1 <=  Cin;
         end if;
      end process;
   --Classical
   ----------------Synchro barrier, entering cycle 1----------------
    R <= X_d1 + Y_d1 + Cin_d1;
end architecture;

--------------------------------------------------------------------------------
--                    FPMultiplier_11_52_11_52_11_52_uid2
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2011
--------------------------------------------------------------------------------
-- Pipeline depth: 6 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMultiplier_11_52_11_52_11_52_uid2 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(11+52+2 downto 0);
          Y : in  std_logic_vector(11+52+2 downto 0);
          R : out  std_logic_vector(11+52+2 downto 0)   );
end entity;

architecture arch of FPMultiplier_11_52_11_52_11_52_uid2 is
   component IntAdder_65_f200_uid35 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(64 downto 0);
             Y : in  std_logic_vector(64 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(64 downto 0)   );
   end component;

   component IntTruncMultiplier_53_53_106_unsigned is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(52 downto 0);
             Y : in  std_logic_vector(52 downto 0);
             R : out  std_logic_vector(105 downto 0)   );
   end component;

signal sign, sign_d1, sign_d2, sign_d3, sign_d4, sign_d5, sign_d6 : std_logic;
signal expX :  std_logic_vector(10 downto 0);
signal expY :  std_logic_vector(10 downto 0);
signal expSumPreSub :  std_logic_vector(12 downto 0);
signal bias :  std_logic_vector(12 downto 0);
signal expSum, expSum_d1, expSum_d2, expSum_d3, expSum_d4, expSum_d5 :  std_logic_vector(12 downto 0);
signal sigX :  std_logic_vector(52 downto 0);
signal sigY :  std_logic_vector(52 downto 0);
signal sigProd :  std_logic_vector(105 downto 0);
signal excSel :  std_logic_vector(3 downto 0);
signal exc, exc_d1, exc_d2, exc_d3, exc_d4, exc_d5, exc_d6 :  std_logic_vector(1 downto 0);
signal norm : std_logic;
signal expPostNorm :  std_logic_vector(12 downto 0);
signal sigProdExt :  std_logic_vector(105 downto 0);
signal expSig :  std_logic_vector(64 downto 0);
signal sticky : std_logic;
signal guard : std_logic;
signal round : std_logic;
signal expSigPostRound :  std_logic_vector(64 downto 0);
signal excPostNorm :  std_logic_vector(1 downto 0);
signal finalExc :  std_logic_vector(1 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            sign_d3 <=  sign_d2;
            sign_d4 <=  sign_d3;
            sign_d5 <=  sign_d4;
            sign_d6 <=  sign_d5;
            expSum_d1 <=  expSum;
            expSum_d2 <=  expSum_d1;
            expSum_d3 <=  expSum_d2;
            expSum_d4 <=  expSum_d3;
            expSum_d5 <=  expSum_d4;
            exc_d1 <=  exc;
            exc_d2 <=  exc_d1;
            exc_d3 <=  exc_d2;
            exc_d4 <=  exc_d3;
            exc_d5 <=  exc_d4;
            exc_d6 <=  exc_d5;
         end if;
      end process;
   sign <= X(63) xor Y(63);
   expX <= X(62 downto 52);
   expY <= Y(62 downto 52);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(1023,13);
   expSum <= expSumPreSub - bias;
   ----------------Synchro barrier, entering cycle 0----------------
   sigX <= "1" & X(51 downto 0);
   sigY <= "1" & Y(51 downto 0);
   SignificandMultiplication: IntTruncMultiplier_53_53_106_unsigned  -- pipelineDepth=5 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => sigProd,
                 X => sigX,
                 Y => sigY);
   ----------------Synchro barrier, entering cycle 5----------------
   ----------------Synchro barrier, entering cycle 0----------------
   excSel <= X(65 downto 64) & Y(65 downto 64);
   with excSel select 
   exc <= "00" when  "0000" | "0001" | "0100", 
          "01" when "0101",
          "10" when "0110" | "1001" | "1010" ,
          "11" when others;
   ----------------Synchro barrier, entering cycle 5----------------
   norm <= sigProd(105);
   -- exponent update
   expPostNorm <= expSum_d5 + ("000000000000" & norm);
   ----------------Synchro barrier, entering cycle 5----------------
   -- significand normalization shift
   sigProdExt <= sigProd(104 downto 0) & "0" when norm='1' else
                         sigProd(103 downto 0) & "00";
   expSig <= expPostNorm & sigProdExt(105 downto 54);
   sticky <= sigProdExt(53);
   guard <= '0' when sigProdExt(52 downto 0)="00000000000000000000000000000000000000000000000000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(54))) or (sigProdExt(54) ))  ;
   RoundingAdder: IntAdder_65_f200_uid35  -- pipelineDepth=1 maxInDelay=3.81416e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => round,
                 R => expSigPostRound   ,
                 X => expSig,
                 Y => "00000000000000000000000000000000000000000000000000000000000000000");
   ----------------Synchro barrier, entering cycle 6----------------
   with expSigPostRound(64 downto 63) select
   excPostNorm <=  "01"  when  "00",
                               "10"             when "01", 
                               "00"             when "11"|"10",
                               "11"             when others;
   with exc_d6 select 
   finalExc <= exc_d6 when  "11"|"10"|"00",
                       excPostNorm when others; 
   R <= finalExc & sign_d6 & expSigPostRound(62 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                FPMultiplier_11_52_11_52_11_52_uid2_Wrapper
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2007)
--------------------------------------------------------------------------------
-- Pipeline depth: 8 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity muld_internal is
   port ( 
     clk   : in  std_logic;
     reset : in  std_logic;
     start : in  std_logic;
     X     : in  std_logic_vector(65 downto 0);
     Y     : in  std_logic_vector(65 downto 0);
     R     : out std_logic_vector(65 downto 0);
     done  : out std_logic;
     ready : out std_logic
  );
end entity muld_internal;

architecture arch of muld_internal is
  component FPMultiplier_11_52_11_52_11_52_uid2 is
    port ( 
      clk : in  std_logic;
      rst : in  std_logic;
      X   : in  std_logic_vector(11+52+2 downto 0);
      Y   : in  std_logic_vector(11+52+2 downto 0);
      R   : out std_logic_vector(11+52+2 downto 0)  
    );
  end component;
  --   
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_001_005, S_001_006, S_001_007, S_001_008);
  signal current_state, next_state : state_type;
  signal i_X, i_X_d1 : std_logic_vector(65 downto 0);
  signal i_Y, i_Y_d1 : std_logic_vector(65 downto 0);
  signal o_R, o_R_d1 : std_logic_vector(65 downto 0);
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
        next_state <= S_EXIT; 
      when S_EXIT =>
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

   ----------------Synchro barrier, entering cycle 1----------------
   test: FPMultiplier_11_52_11_52_11_52_uid2  -- pipelineDepth=6 maxInDelay=0
      port map ( 
        clk => clk,
        rst => reset,
        R   => o_R,
        X   => i_X_d1,
        Y   => i_Y_d1
      );
                 
   ----------------Synchro barrier, entering cycle 8----------------
   R <= o_R_d1;

end architecture arch;

--------------------------------------------------------------------------------
--                          InputIEEE_11_52_to_11_52
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2008)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity InputIEEE_11_52_to_11_52 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(63 downto 0);
          R : out  std_logic_vector(11+52+2 downto 0)   );
end entity;

architecture arch of InputIEEE_11_52_to_11_52 is
signal expX, expX_d1 :  std_logic_vector(10 downto 0);
signal fracX :  std_logic_vector(51 downto 0);
signal sX, sX_d1 : std_logic;
signal expZero, expZero_d1 : std_logic;
signal expInfty, expInfty_d1 : std_logic;
signal fracZero, fracZero_d1 : std_logic;
signal reprSubNormal, reprSubNormal_d1 : std_logic;
signal sfracX, sfracX_d1 :  std_logic_vector(51 downto 0);
signal fracR :  std_logic_vector(51 downto 0);
signal expR :  std_logic_vector(10 downto 0);
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
   expX  <= X(62 downto 52);
   fracX  <= X(51 downto 0);
   sX  <= X(63);
   expZero  <= '1' when expX = (10 downto 0 => '0') else '0';
   expInfty  <= '1' when expX = (10 downto 0 => '1') else '0';
   fracZero <= '1' when fracX = (51 downto 0 => '0') else '0';
   reprSubNormal <= fracX(51);
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   sfracX <= fracX(50 downto 0) & '0' when (expZero='1' and reprSubNormal='1')    else fracX;
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
--                         OutputIEEE_11_52_to_11_52
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: F. Ferrandi  (2009)
--------------------------------------------------------------------------------
-- Pipeline depth: 1 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--library std;
--use std.textio.all;
--library work;

entity OutputIEEE_11_52_to_11_52 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(11+52+2 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of OutputIEEE_11_52_to_11_52 is
signal expX, expX_d1 :  std_logic_vector(10 downto 0);
signal fracX, fracX_d1 :  std_logic_vector(51 downto 0);
signal sX, sX_d1 : std_logic;
signal exnX, exnX_d1 :  std_logic_vector(1 downto 0);
signal expZero, expZero_d1 : std_logic;
signal sfracX :  std_logic_vector(51 downto 0);
signal fracR :  std_logic_vector(51 downto 0);
signal expR :  std_logic_vector(10 downto 0);
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
   expX  <= X(62 downto 52);
   fracX  <= X(51 downto 0);
   sX  <= X(63);
   exnX  <= X(65 downto 64);
   expZero  <= '1' when expX = (10 downto 0 => '0') else '0';
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   ----------------Synchro barrier, entering cycle 1----------------
   sfracX <= 
      (51 downto 0 => '0') when (exnX_d1 = "00") else
      '1' & fracX_d1(51 downto 1) when (expZero_d1 = '1' and exnX_d1 = "01") else
      fracX_d1 when (exnX_d1 = "01") else 
      (51 downto 1 => '0') & exnX_d1(0);
   fracR <= sfracX;
   expR <=  
      (10 downto 0 => '0') when (exnX_d1 = "00") else
      expX_d1 when (exnX_d1 = "01") else 
      (10 downto 0 => '1');
   R <= sX_d1 & expR & fracR; 
end architecture arch;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use WORK.fixed_float_types.all;
use WORK.fixed_pkg.all;
use WORK.float_pkg.all;
--library ieee_proposed;
--use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
--use ieee_proposed.float_pkg.all;

entity muld is
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    start : in  std_logic;
    a     : in  float64;
    b     : in  float64;
    y     : out float64;
    done  : out std_logic;
    ready : out std_logic
  );
end muld;

architecture fsmd of muld is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_002_001, S_002_002, S_002_003, S_003_001);
  signal current_state, next_state: state_type;
  signal a_flopoco : std_logic_vector(11+52+2 downto 0);
  signal b_flopoco : std_logic_vector(11+52+2 downto 0);
  signal y_flopoco : std_logic_vector(11+52+2 downto 0);
  signal y_flopoco_eval : std_logic_vector(11+52+2 downto 0); 
  signal a_ieee    : std_logic_vector(63 downto 0);
  signal b_ieee    : std_logic_vector(63 downto 0);
  signal y_ieee    : std_logic_vector(63 downto 0);
  signal muld_0_start : std_logic;
  signal muld_0_done  : std_logic;
  signal muld_0_ready : std_logic;
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
    muld_0_start, muld_0_ready, muld_0_done
  )
  begin
    done <= '0';
    ready <= '0';
    muld_0_start <= '0';
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
        muld_0_start <= '1';
        next_state <= S_001_003;
      when S_001_003 =>
        if ((muld_0_ready = '1') and (muld_0_start = '0')) then
          y_flopoco <= y_flopoco_eval;
          next_state <= S_001_004;
        else
          next_state <= S_001_003;
        end if;
      when S_001_004 =>
        next_state <= S_002_001;         
      when S_002_001 =>        
        y <= to_float(y_ieee, 11, 52);
        next_state <= S_EXIT; 
      when S_EXIT =>        
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;
 
  a_ieee2flopoco_0 : entity WORK.InputIEEE_11_52_to_11_52(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => a_ieee,
      R   => a_flopoco
    );

  b_ieee2flopoco_0 : entity WORK.InputIEEE_11_52_to_11_52(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => b_ieee,
      R   => b_flopoco
    );
    
  muld_internal_0 : entity WORK.muld_internal(arch)
    port map (
      clk,
      reset,
      muld_0_start,
      a_flopoco,
      b_flopoco,
      y_flopoco_eval,
      muld_0_done,
      muld_0_ready
    );
    
  y_flopoco2ieee_0 : entity WORK.OutputIEEE_11_52_to_11_52(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => y_flopoco,
      R   => y_ieee
    );
    
end fsmd;
