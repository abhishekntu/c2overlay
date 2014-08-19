--------------------------------------------------------------------------------
--                       FPAdder_8_23_uid2_RightShifter
--                      (RightShifter_24_by_max_26_uid4)
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2008-2011)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPAdder_8_23_uid2_RightShifter is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(23 downto 0);
          S : in  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(49 downto 0)   );
end entity;

architecture arch of FPAdder_8_23_uid2_RightShifter is
signal level0 :  std_logic_vector(23 downto 0);
signal ps :  std_logic_vector(4 downto 0);
signal level1 :  std_logic_vector(24 downto 0);
signal level2 :  std_logic_vector(26 downto 0);
signal level3 :  std_logic_vector(30 downto 0);
signal level4 :  std_logic_vector(38 downto 0);
signal level5 :  std_logic_vector(54 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
         end if;
      end process;
   level0<= X;
   ps<= S;
   level1<=  (0 downto 0 => '0') & level0 when ps(0) = '1' else    level0 & (0 downto 0 => '0');
   level2<=  (1 downto 0 => '0') & level1 when ps(1) = '1' else    level1 & (1 downto 0 => '0');
   level3<=  (3 downto 0 => '0') & level2 when ps(2) = '1' else    level2 & (3 downto 0 => '0');
   level4<=  (7 downto 0 => '0') & level3 when ps(3) = '1' else    level3 & (7 downto 0 => '0');
   level5<=  (15 downto 0 => '0') & level4 when ps(4) = '1' else    level4 & (15 downto 0 => '0');
   R <= level5(54 downto 5);
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_27_f200_uid6
--                    (IntAdderAlternative_27_f200_uid10)
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

entity IntAdder_27_f200_uid6 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(26 downto 0);
          Y : in  std_logic_vector(26 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(26 downto 0)   );
end entity;

architecture arch of IntAdder_27_f200_uid6 is
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
--                   LZCShifter_28_to_28_counting_32_uid12
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Bogdan Pasca (2007)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity LZCShifter_28_to_28_counting_32_uid12 is
   port ( clk, rst : in std_logic;
          I : in  std_logic_vector(27 downto 0);
          Count : out  std_logic_vector(4 downto 0);
          O : out  std_logic_vector(27 downto 0)   );
end entity;

architecture arch of LZCShifter_28_to_28_counting_32_uid12 is
signal level5 :  std_logic_vector(27 downto 0);
signal count4, count4_d1, count4_d2 : std_logic;
signal level4, level4_d1 :  std_logic_vector(27 downto 0);
signal count3, count3_d1 : std_logic;
signal level3 :  std_logic_vector(27 downto 0);
signal count2, count2_d1 : std_logic;
signal level2 :  std_logic_vector(27 downto 0);
signal count1, count1_d1 : std_logic;
signal level1, level1_d1 :  std_logic_vector(27 downto 0);
signal count0 : std_logic;
signal level0 :  std_logic_vector(27 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            count4_d1 <=  count4;
            count4_d2 <=  count4_d1;
            level4_d1 <=  level4;
            count3_d1 <=  count3;
            count2_d1 <=  count2;
            count1_d1 <=  count1;
            level1_d1 <=  level1;
         end if;
      end process;
   level5 <= I ;
   count4<= '1' when level5(27 downto 12) = (27 downto 12=>'0') else '0';
   level4<= level5(27 downto 0) when count4='0' else level5(11 downto 0) & (15 downto 0 => '0');

   ----------------Synchro barrier, entering cycle 1----------------
   count3<= '1' when level4_d1(27 downto 20) = (27 downto 20=>'0') else '0';
   level3<= level4_d1(27 downto 0) when count3='0' else level4_d1(19 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3(27 downto 24) = (27 downto 24=>'0') else '0';
   level2<= level3(27 downto 0) when count2='0' else level3(23 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(27 downto 26) = (27 downto 26=>'0') else '0';
   level1<= level2(27 downto 0) when count1='0' else level2(25 downto 0) & (1 downto 0 => '0');

   ----------------Synchro barrier, entering cycle 2----------------
   count0<= '1' when level1_d1(27 downto 27) = (27 downto 27=>'0') else '0';
   level0<= level1_d1(27 downto 0) when count0='0' else level1_d1(26 downto 0) & (0 downto 0 => '0');

   O <= level0;
   sCount <= count4_d2 & count3_d1 & count2_d1 & count1_d1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                           IntAdder_34_f200_uid14
--                    (IntAdderAlternative_34_f200_uid18)
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

entity IntAdder_34_f200_uid14 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(33 downto 0);
          Y : in  std_logic_vector(33 downto 0);
          Cin : in std_logic;
          R : out  std_logic_vector(33 downto 0)   );
end entity;

architecture arch of IntAdder_34_f200_uid14 is
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
--                             FPAdder_8_23_uid2
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca, Florent de Dinechin (2010)
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPAdder_8_23_uid2 is
   port ( clk, rst : in std_logic;
          X : in  std_logic_vector(8+23+2 downto 0);
          Y : in  std_logic_vector(8+23+2 downto 0);
          R : out  std_logic_vector(8+23+2 downto 0)   );
end entity;

architecture arch of FPAdder_8_23_uid2 is
   component FPAdder_8_23_uid2_RightShifter is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(23 downto 0);
             S : in  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(49 downto 0)   );
   end component;

   component IntAdder_27_f200_uid6 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(26 downto 0);
             Y : in  std_logic_vector(26 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(26 downto 0)   );
   end component;

   component IntAdder_34_f200_uid14 is
      port ( clk, rst : in std_logic;
             X : in  std_logic_vector(33 downto 0);
             Y : in  std_logic_vector(33 downto 0);
             Cin : in std_logic;
             R : out  std_logic_vector(33 downto 0)   );
   end component;

   component LZCShifter_28_to_28_counting_32_uid12 is
      port ( clk, rst : in std_logic;
             I : in  std_logic_vector(27 downto 0);
             Count : out  std_logic_vector(4 downto 0);
             O : out  std_logic_vector(27 downto 0)   );
   end component;

signal excExpFracX :  std_logic_vector(32 downto 0);
signal excExpFracY :  std_logic_vector(32 downto 0);
signal eXmeY :  std_logic_vector(8 downto 0);
signal eYmeX :  std_logic_vector(8 downto 0);
signal swap : std_logic;
signal newX, newX_d1 :  std_logic_vector(33 downto 0);
signal newY :  std_logic_vector(33 downto 0);
signal expX, expX_d1 :  std_logic_vector(7 downto 0);
signal excX :  std_logic_vector(1 downto 0);
signal excY :  std_logic_vector(1 downto 0);
signal signX : std_logic;
signal signY : std_logic;
signal EffSub, EffSub_d1, EffSub_d2, EffSub_d3, EffSub_d4 : std_logic;
signal sdsXsYExnXY :  std_logic_vector(5 downto 0);
signal sdExnXY :  std_logic_vector(3 downto 0);
signal fracY :  std_logic_vector(23 downto 0);
signal excRt, excRt_d1, excRt_d2, excRt_d3, excRt_d4 :  std_logic_vector(1 downto 0);
signal signR, signR_d1, signR_d2, signR_d3, signR_d4 : std_logic;
signal expDiff :  std_logic_vector(8 downto 0);
signal shiftedOut : std_logic;
signal shiftVal :  std_logic_vector(4 downto 0);
signal shiftedFracY, shiftedFracY_d1 :  std_logic_vector(49 downto 0);
signal sticky : std_logic;
signal fracYfar :  std_logic_vector(26 downto 0);
signal fracYfarXorOp :  std_logic_vector(26 downto 0);
signal fracXfar :  std_logic_vector(26 downto 0);
signal cInAddFar : std_logic;
signal fracAddResult :  std_logic_vector(26 downto 0);
signal fracGRS :  std_logic_vector(27 downto 0);
signal extendedExpInc, extendedExpInc_d1, extendedExpInc_d2 :  std_logic_vector(9 downto 0);
signal nZerosNew :  std_logic_vector(4 downto 0);
signal shiftedFrac :  std_logic_vector(27 downto 0);
signal updatedExp :  std_logic_vector(9 downto 0);
signal eqdiffsign, eqdiffsign_d1 : std_logic;
signal expFrac :  std_logic_vector(33 downto 0);
signal stk : std_logic;
signal rnd : std_logic;
signal grd : std_logic;
signal lsb : std_logic;
signal addToRoundBit : std_logic;
signal RoundedExpFrac :  std_logic_vector(33 downto 0);
signal upExc, upExc_d1 :  std_logic_vector(1 downto 0);
signal fracR, fracR_d1 :  std_logic_vector(22 downto 0);
signal expR, expR_d1 :  std_logic_vector(7 downto 0);
signal exExpExc :  std_logic_vector(3 downto 0);
signal excRt2 :  std_logic_vector(1 downto 0);
signal excR :  std_logic_vector(1 downto 0);
signal computedR :  std_logic_vector(33 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            newX_d1 <=  newX;
            expX_d1 <=  expX;
            EffSub_d1 <=  EffSub;
            EffSub_d2 <=  EffSub_d1;
            EffSub_d3 <=  EffSub_d2;
            EffSub_d4 <=  EffSub_d3;
            excRt_d1 <=  excRt;
            excRt_d2 <=  excRt_d1;
            excRt_d3 <=  excRt_d2;
            excRt_d4 <=  excRt_d3;
            signR_d1 <=  signR;
            signR_d2 <=  signR_d1;
            signR_d3 <=  signR_d2;
            signR_d4 <=  signR_d3;
            shiftedFracY_d1 <=  shiftedFracY;
            extendedExpInc_d1 <=  extendedExpInc;
            extendedExpInc_d2 <=  extendedExpInc_d1;
            eqdiffsign_d1 <=  eqdiffsign;
            upExc_d1 <=  upExc;
            fracR_d1 <=  fracR;
            expR_d1 <=  expR;
         end if;
      end process;
-- Exponent difference and swap  --
   excExpFracX <= X(33 downto 32) & X(30 downto 0);
   excExpFracY <= Y(33 downto 32) & Y(30 downto 0);
   eXmeY <= ("0" & X(30 downto 23)) - ("0" & Y(30 downto 23));
   eYmeX <= ("0" & Y(30 downto 23)) - ("0" & X(30 downto 23));
   swap <= '0' when excExpFracX >= excExpFracY else '1';
   newX <= X     when swap = '0' else Y;
   newY <= Y     when swap = '0' else X;
   expX<= newX(30 downto 23);
   excX<= newX(33 downto 32);
   excY<= newY(33 downto 32);
   signX<= newX(31);
   signY<= newY(31);
   EffSub <= signX xor signY;
   sdsXsYExnXY <= signX & signY & excX & excY;
   sdExnXY <= excX & excY;
   fracY <= "000000000000000000000000" when excY="00" else ('1' & newY(22 downto 0));
   with sdsXsYExnXY select 
   excRt <= "00" when "000000"|"010000"|"100000"|"110000",
      "01" when "000101"|"010101"|"100101"|"110101"|"000100"|"010100"|"100100"|"110100"|"000001"|"010001"|"100001"|"110001",
      "10" when "111010"|"001010"|"001000"|"011000"|"101000"|"111000"|"000010"|"010010"|"100010"|"110010"|"001001"|"011001"|"101001"|"111001"|"000110"|"010110"|"100110"|"110110", 
      "11" when others;
   signR<= '0' when (sdsXsYExnXY="100000" or sdsXsYExnXY="010000") else signX;
   ---------------- cycle 0----------------
   expDiff <= eXmeY when swap = '0' else eYmeX;
   shiftedOut <= '1' when (expDiff >= 25) else '0';
   shiftVal <= expDiff(4 downto 0) when shiftedOut='0' else CONV_STD_LOGIC_VECTOR(26,5) ;
   RightShifterComponent: FPAdder_8_23_uid2_RightShifter  -- pipelineDepth=0 maxInDelay=3.26288e-09
      port map ( clk  => clk,
                 rst  => rst,
                 R => shiftedFracY,
                 S => shiftVal,
                 X => fracY);
   ----------------Synchro barrier, entering cycle 1----------------
   sticky <= '0' when (shiftedFracY_d1(23 downto 0)=CONV_STD_LOGIC_VECTOR(0,23)) else '1';
   ---------------- cycle 0----------------
   ----------------Synchro barrier, entering cycle 1----------------
   fracYfar <= "0" & shiftedFracY_d1(49 downto 24);
   fracYfarXorOp <= fracYfar xor (26 downto 0 => EffSub_d1);
   fracXfar <= "01" & (newX_d1(22 downto 0)) & "00";
   cInAddFar <= EffSub_d1 and not sticky;
   fracAdder: IntAdder_27_f200_uid6  -- pipelineDepth=0 maxInDelay=1.45844e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => cInAddFar,
                 R => fracAddResult,
                 X => fracXfar,
                 Y => fracYfarXorOp);
   fracGRS<= fracAddResult & sticky; 
   extendedExpInc<= ("00" & expX_d1) + '1';
   LZC_component: LZCShifter_28_to_28_counting_32_uid12  -- pipelineDepth=2 maxInDelay=2.74744e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Count => nZerosNew,
                 I => fracGRS,
                 O => shiftedFrac);
   ----------------Synchro barrier, entering cycle 3----------------
   updatedExp <= extendedExpInc_d2 - ("00000" & nZerosNew);
   eqdiffsign <= '1' when nZerosNew="11111" else '0';
   expFrac<= updatedExp & shiftedFrac(26 downto 3);
   ---------------- cycle 3----------------
   stk<= shiftedFrac(1) or shiftedFrac(0);
   rnd<= shiftedFrac(2);
   grd<= shiftedFrac(3);
   lsb<= shiftedFrac(4);
   addToRoundBit<= '0' when (lsb='0' and grd='1' and rnd='0' and stk='0')  else '1';
   roundingAdder: IntAdder_34_f200_uid14  -- pipelineDepth=0 maxInDelay=2.73216e-09
      port map ( clk  => clk,
                 rst  => rst,
                 Cin => addToRoundBit,
                 R => RoundedExpFrac,
                 X => expFrac,
                 Y => "0000000000000000000000000000000000");
   ---------------- cycle 3----------------
   upExc <= RoundedExpFrac(33 downto 32);
   fracR <= RoundedExpFrac(23 downto 1);
   expR <= RoundedExpFrac(31 downto 24);
   ----------------Synchro barrier, entering cycle 4----------------
   exExpExc <= upExc_d1 & excRt_d4;
   with (exExpExc) select 
   excRt2<= "00" when "0000"|"0100"|"1000"|"1100"|"1001"|"1101",
      "01" when "0001",
      "10" when "0010"|"0110"|"0101",
      "11" when others;
   excR <= "00" when (eqdiffsign_d1='1' and EffSub_d4='1') else excRt2;
   computedR <= excR & signR_d4 & expR_d1 & fracR_d1;
   R <= computedR;
end architecture;

--------------------------------------------------------------------------------
--                         FPAdder_8_23_uid2_Wrapper
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2007)
--------------------------------------------------------------------------------
-- Pipeline depth: 6 cycles

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity addf_internal is
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
end entity addf_internal;

architecture arch of addf_internal is
  component FPAdder_8_23_uid2 is
    port ( 
      clk : in  std_logic;
      rst : in  std_logic;
      X   : in  std_logic_vector(8+23+2 downto 0);
      Y   : in  std_logic_vector(8+23+2 downto 0);
      R   : out std_logic_vector(8+23+2 downto 0)  
    );
  end component;
  --   
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_001_005, S_001_006);
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
        next_state <= S_EXIT; 
      when S_EXIT =>
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;

   ----------------Synchro barrier, entering cycle 1----------------
   test: FPAdder_8_23_uid2  -- pipelineDepth=4 maxInDelay=0
      port map ( 
        clk => clk,
        rst => reset,
        R   => o_R,
        X   => i_X_d1,
        Y   => i_Y_d1
      );
                 
   ----------------Synchro barrier, entering cycle 6----------------
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

entity addf is
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
end addf;

architecture fsmd of addf is
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002, S_001_003, S_001_004, S_002_001, S_002_002, S_002_003, S_003_001);
  signal current_state, next_state: state_type;
  signal a_flopoco : std_logic_vector(8+23+2 downto 0);
  signal b_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco : std_logic_vector(8+23+2 downto 0);
  signal y_flopoco_eval : std_logic_vector(8+23+2 downto 0); 
  signal a_ieee    : std_logic_vector(31 downto 0);
  signal b_ieee    : std_logic_vector(31 downto 0);
  signal y_ieee    : std_logic_vector(31 downto 0);
  signal addf_0_start : std_logic;
  signal addf_0_done  : std_logic;
  signal addf_0_ready : std_logic;
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
    addf_0_start, addf_0_ready, addf_0_done
  )
  begin
    done <= '0';
    ready <= '0';
    addf_0_start <= '0';
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
        addf_0_start <= '1';
        next_state <= S_001_003;
      when S_001_003 =>
        if ((addf_0_ready = '1') and (addf_0_start = '0')) then
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
    
  addf_internal_0 : entity WORK.addf_internal(arch)
    port map (
      clk,
      reset,
      addf_0_start,
      a_flopoco,
      b_flopoco,
      y_flopoco_eval,
      addf_0_done,
      addf_0_ready
    );
    
  y_flopoco2ieee_0 : entity WORK.OutputIEEE_8_23_to_8_23(arch)
    port map (
      clk => clk,
      rst => reset,
      X   => y_flopoco,
      R   => y_ieee
    );
    
end fsmd;
 