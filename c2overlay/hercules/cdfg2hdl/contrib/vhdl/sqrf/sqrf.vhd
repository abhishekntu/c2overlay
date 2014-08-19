--------------------------------------------------------------------------------
--                       IntMultiAdder_48_op1_f200_uid5
--                       (IntCompressorTree_48_1_uid7)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2009-2011)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity IntMultiAdder_48_op1_f200_uid5 is
   port ( clk, rst : in std_logic;
          X0 : in  std_logic_vector(47 downto 0);
          R : out  std_logic_vector(47 downto 0)   );
end entity;

architecture arch of IntMultiAdder_48_op1_f200_uid5 is
signal l_0_s_0 :  std_logic_vector(47 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   l_0_s_0 <= X0;
   R <= X0;
end architecture;

--------------------------------------------------------------------------------
--                    IntTruncMultiplier_24_24_48_unsigned
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Sebastian Banescu, Bogdan Pasca, Radu Tudoran (2010-2011)
--------------------------------------------------------------------------------
library ieee; 
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library work;
entity IntTruncMultiplier_24_24_48_unsigned is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          Y : in  std_logic_vector(23 downto 0);
          R : out  std_logic_vector(47 downto 0)   );
end entity;

architecture arch of IntTruncMultiplier_24_24_48_unsigned is
   component IntMultiAdder_48_op1_f200_uid5 is
      port ( clk, rst : in std_logic;
             X0 : in  std_logic_vector(47 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

signal x0_0 :  std_logic_vector(17 downto 0);
signal y0_0 :  std_logic_vector(24 downto 0);
signal pxy00, pxy00_d1, pxy00_d2 :  std_logic_vector(42 downto 0);
signal x0_1, x0_1_d1 :  std_logic_vector(17 downto 0);
signal y0_1, y0_1_d1 :  std_logic_vector(24 downto 0);
signal txy01 :  std_logic_vector(42 downto 0);
signal pxy01, pxy01_d1 :  std_logic_vector(42 downto 0);
signal addOpDSP0 :  std_logic_vector(47 downto 0);
signal addRes :  std_logic_vector(47 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            pxy00_d1 <=  pxy00;
            pxy00_d2 <=  pxy00_d1;
            x0_1_d1 <=  x0_1;
            y0_1_d1 <=  y0_1;
            pxy01_d1 <=  pxy01;
         end if;
      end process;
   ----------------Synchro barrier, entering cycle 0----------------
   ----------------Synchro barrier, entering cycle 0----------------
   x0_0 <= "0" & "" & X(6 downto 0) & "0000000000";
   y0_0 <= "0" & "" & Y(23 downto 0) & "";
   pxy00 <= x0_0(17 downto 0) * y0_0(24 downto 0); --0
   ----------------Synchro barrier, entering cycle 0----------------
   x0_1 <= "0" & "" & X(23 downto 7) & "";
   y0_1 <= "0" & "" & Y(23 downto 0) & "";
   ----------------Synchro barrier, entering cycle 1----------------
   txy01 <= x0_1_d1(17 downto 0) * y0_1_d1(24 downto 0);
   pxy01 <= (txy01(42 downto 0)) + ("00000000000000000" &pxy00_d1(42 downto 17));
   ----------------Synchro barrier, entering cycle 2----------------
   addOpDSP0 <= "" & pxy01_d1(40 downto 0) & pxy00_d2(16 downto 10) & "" &  "";--3 bpadX 10 bpadY 0
   adder: IntMultiAdder_48_op1_f200_uid5  -- pipelineDepth=0 maxInDelay=4.4472e-10
      port map ( clk  => clk,
                 rst  => rst,
                 R => addRes,
                 X0 => addOpDSP0);
   R <= addRes(47 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_33_f200_uid9
--                    (IntAdderAlternative_33_f200_uid13)
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

entity IntAdder_33_f200_uid9 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(32 downto 0);
          Y : in  std_logic_vector(32 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(32 downto 0)   );
end entity;

architecture arch of IntAdder_33_f200_uid9 is
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
--                      FPMultiplier_8_23_8_23_8_23_uid2
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin 2008-2011
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPMultiplier_8_23_8_23_8_23_uid2 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPMultiplier_8_23_8_23_8_23_uid2 is
   component IntAdder_33_f200_uid9 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(32 downto 0);
             Y : in  std_logic_vector(32 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(32 downto 0)   );
   end component;

   component IntTruncMultiplier_24_24_48_unsigned is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             Y : in  std_logic_vector(23 downto 0);
             R : out  std_logic_vector(47 downto 0)   );
   end component;

signal sign, sign_d1, sign_d2 : std_logic;
signal expX :  std_logic_vector(7 downto 0);
signal expY :  std_logic_vector(7 downto 0);
signal expSumPreSub :  std_logic_vector(9 downto 0);
signal bias :  std_logic_vector(9 downto 0);
signal expSum, expSum_d1, expSum_d2 :  std_logic_vector(9 downto 0);
signal sigX :  std_logic_vector(23 downto 0);
signal sigY :  std_logic_vector(23 downto 0);
signal sigProd :  std_logic_vector(47 downto 0);
signal excSel :  std_logic_vector(3 downto 0);
signal exc, exc_d1, exc_d2 :  std_logic_vector(1 downto 0);
signal norm : std_logic;
signal expPostNorm :  std_logic_vector(9 downto 0);
signal sigProdExt :  std_logic_vector(47 downto 0);
signal expSig :  std_logic_vector(32 downto 0);
signal sticky : std_logic;
signal guard : std_logic;
signal round : std_logic;
signal expSigPostRound :  std_logic_vector(32 downto 0);
signal excPostNorm :  std_logic_vector(1 downto 0);
signal finalExc :  std_logic_vector(1 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            expSum_d1 <=  expSum;
            expSum_d2 <=  expSum_d1;
            exc_d1 <=  exc;
            exc_d2 <=  exc_d1;
         end if;
      end process;
   sign <= X(31) xor Y(31);
   expX <= X(30 downto 23);
   expY <= Y(30 downto 23);
   expSumPreSub <= ("00" & expX) + ("00" & expY);
   bias <= CONV_STD_LOGIC_VECTOR(127,10);
   expSum <= expSumPreSub - bias;
   ----------------Synchro barrier, entering cycle 0----------------
   sigX <= "1" & X(22 downto 0);
   sigY <= "1" & Y(22 downto 0);
   SignificandMultiplication: IntTruncMultiplier_24_24_48_unsigned  -- pipelineDepth=2 maxInDelay=0
      port map ( clk  => clk,
                 rst  => rst,
                 R => sigProd,
                 X => sigX,
                 Y => sigY);
   ----------------Synchro barrier, entering cycle 2----------------
   ----------------Synchro barrier, entering cycle 0----------------
   excSel <= X(33 downto 32) & Y(33 downto 32);
   with excSel select 
   exc <= "00" when  "0000" | "0001" | "0100", 
          "01" when "0101",
          "10" when "0110" | "1001" | "1010" ,
          "11" when others;
   ----------------Synchro barrier, entering cycle 2----------------
   norm <= sigProd(47);
   -- exponent update
   expPostNorm <= expSum_d2 + ("000000000" & norm);
   ----------------Synchro barrier, entering cycle 2----------------
   -- significand normalization shift
   sigProdExt <= sigProd(46 downto 0) & "0" when norm='1' else
                         sigProd(45 downto 0) & "00";
   expSig <= expPostNorm & sigProdExt(47 downto 25);
   sticky <= sigProdExt(24);
   guard <= '0' when sigProdExt(23 downto 0)="000000000000000000000000" else '1';
   round <= sticky and ( (guard and not(sigProdExt(25))) or (sigProdExt(25) ))  ;
   RoundingAdder: IntAdder_33_f200_uid9  -- pipelineDepth=0 maxInDelay=3.33188e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => round,
                 R => expSigPostRound   ,
                 X => expSig,
                 Y => "000000000000000000000000000000000");
   with expSigPostRound(32 downto 31) select
   excPostNorm <=  "01"  when  "00",
                               "10"             when "01", 
                               "00"             when "11"|"10",
                               "11"             when others;
   with exc_d2 select 
   finalExc <= exc_d2 when  "11"|"10"|"00",
                       excPostNorm when others; 
   R <= finalExc & sign_d2 & expSigPostRound(30 downto 0);
end architecture;

--------------------------------------------------------------------------------
--                  FPMultiplier_8_23_8_23_8_23_uid2_Wrapper
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2007)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity sqrf_internal is
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
end entity sqrf_internal;

architecture arch of sqrf_internal is
  component FPMultiplier_8_23_8_23_8_23_uid2 is
    port ( 
      clk : in  std_logic;
      rst : in  std_logic;
      X   : in  std_logic_vector(8+23+2 downto 0);
      Y   : in  std_logic_vector(8+23+2 downto 0);
      R   : out std_logic_vector(8+23+2 downto 0)  
    );
  end component;
  --   
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004);
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
        next_state <= S_EXIT; 
      when S_EXIT =>
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

   ----------------Synchro barrier, entering cycle 1----------------
   test: FPMultiplier_8_23_8_23_8_23_uid2  -- pipelineDepth=2 maxInDelay=0
      port map ( 
        clk => clk,
        rst => reset,
        R   => o_R,
        X   => i_X_d1,
        Y   => i_Y_d1
      );
                 
   ----------------Synchro barrier, entering cycle 4----------------
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
--library ieee_proposed;
--use ieee_proposed.fixed_float_types.all;
--use ieee_proposed.fixed_pkg.all;
--use ieee_proposed.float_pkg.all;

entity sqrf is
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    start : in  std_logic;
    a     : in  float32;
    y     : out float32;
    done  : out std_logic;
    ready : out std_logic
  );
end sqrf;

architecture fsmd of sqrf is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_002_001, S_002_002, S_002_003, S_003_001);
  signal current_state, next_state: state_type;
  signal a_flopoco : std_logic_vector(8+23+2 downto 0);
  signal b_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco_eval : std_logic_vector(8+23+2 downto 0); 
  signal a_ieee    : std_logic_vector(31 downto 0);
  signal b_ieee    : std_logic_vector(31 downto 0);
  signal y_ieee    : std_logic_vector(31 downto 0);
  signal sqrf_0_start : std_logic;
  signal sqrf_0_done  : std_logic;
  signal sqrf_0_ready : std_logic;
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
    sqrf_0_start, sqrf_0_ready, sqrf_0_done
  )
  begin
    done <= '0';
    ready <= '0';
    sqrf_0_start <= '0';
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          a_ieee <= to_std_logic_vector(a);
          b_ieee <= to_std_logic_vector(a);
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        next_state <= S_001_002;
      when S_001_002 =>
        sqrf_0_start <= '1';
        next_state <= S_001_003;
      when S_001_003 =>
        if ((sqrf_0_ready = '1') and (sqrf_0_start = '0')) then
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
    
  sqrf_internal_0 : entity WORK.sqrf_internal(arch)
    port map (
      clk,
      reset,
      sqrf_0_start,
      a_flopoco,
      b_flopoco,
      y_flopoco_eval,
      sqrf_0_done,
      sqrf_0_ready
    );
    
  y_flopoco2ieee_0 : entity WORK.OutputIEEE_8_23_to_8_23(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => y_flopoco,
      R   => y_ieee
    );
    
end fsmd;
 