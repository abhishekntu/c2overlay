library IEEE;
use IEEE.std_logic_1164.all;


package xmodz_pkg is 
  
  FUNCTION   or_reduce(arg : STD_LOGIC_VECTOR) RETURN STD_LOGIC;
  -- Result subtype: STD_LOGIC.
  -- Result: Result of or'ing all of the bits of the vector.
  
  FUNCTION  nor_reduce(arg : STD_LOGIC_VECTOR) RETURN STD_LOGIC;
  -- Result subtype: STD_LOGIC.
  -- Result: Result of nor'ing all of the bits of the vector.

end xmodz_pkg;

package body xmodz_pkg is
 
  FUNCTION or_reduce(arg: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
    VARIABLE result: STD_LOGIC;
  BEGIN
    result := '0';
    FOR i IN arg'RANGE LOOP
      result := result OR arg(i);
    END LOOP;
    RETURN result;
  END;
  
  FUNCTION nor_reduce(arg: STD_LOGIC_VECTOR) RETURN STD_LOGIC IS
    VARIABLE result: STD_LOGIC;
  BEGIN
    result := NOT or_reduce(arg);
    RETURN result;
  END;
  
end xmodz_pkg;


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;
--use WORK.std_logic_textio.all;
use WORK.xmodz_pkg.all;

entity xmodz is
  generic (
    mode : string := "REGISTERED";
--    mode : string := "COMBINATIONAL";
    N : integer := 8
  );
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    x     : in  std_logic_vector(N-1 downto 0);
    z     : in  std_logic_vector(N-1 downto 0);
    outp  : out std_logic_vector(N-1 downto 0);
    done  : out std_logic
  );
end xmodz;

architecture fsmd of xmodz is
  type arr_type  is array (0 to N+1) of std_logic_vector(N-1 downto 0);
  type arr2_type is array (0 to N+1) of std_logic_vector(2*N-1 downto 0);
  signal a     : arr_type  := (others => (others => '0'));  
  signal b     : arr_type  := (others => (others => '0'));  
  signal t     : arr_type  := (others => (others => '0'));  
  signal u     : arr2_type := (others => (others => '0'));  
  signal theta : arr2_type := (others => (others => '0'));  
  signal count : std_logic_vector(N-1 downto 0);
  signal done_int : std_logic;
begin
 
  a(0)     <= x;
  theta(0)(2*N-1 downto N) <= z;
  theta(0)(  N-1 downto 0) <= (others => '0');

  -- Combinational part of x mod z for variable z
  gen_stages: for i in 0 to N generate
    process (a(i), theta(i), b(i))
    begin
      if ((a(i) >= theta(i)(N-1 downto 0)) and (nor_reduce(theta(i)(2*N-1 downto N)) = '1')) then
        b(i) <= theta(i)(N-1 downto 0);
      else
        b(i) <= (others => '0');      
      end if;
      --
      t(i) <= std_logic_vector(unsigned(a(i)) - unsigned(b(i)));
      u(i)(2*N-2 downto 0) <= theta(i)(2*N-1 downto 1);
      u(i)(2*N-1)          <= '0';
      --
    end process;
    --
    regs: if mode = "REGISTERED" generate
      process (clk)
      begin
        if (clk = '1' and clk'EVENT) then
          a(i+1)     <= t(i);  
          theta(i+1) <= u(i);
        end if;
      end process;
    end generate regs;
    --
    noregs : if mode = "COMBINATIONAL" generate
      a(i+1)     <= t(i);
      theta(i+1) <= u(i);
    end generate noregs;
  end generate gen_stages;
  
  outp <= a(N+1);
  
  regs_done : if mode = "REGISTERED" generate
    process (clk, reset, done_int)
    begin
      if (reset = '1') then      
        count <= (others => '0');      
        done_int <= '0';
      elsif (clk = '1' and clk'EVENT) then
        count <= std_logic_vector(unsigned(count) + to_unsigned(1,N));
        if (count = std_logic_vector(to_unsigned(N+1,N))) then
          done_int <= '1';
        else
          done_int <= '0';
        end if;
      end if;
    end process;
  end generate regs_done;

  done <= done_int;
  
  noregs_done : if mode = "COMBINATIONAL" generate
    process (clk, reset)
    begin
      if (reset = '1' or done_int = '1') then      
        done_int <= '0';
      elsif (clk = '1' and clk'EVENT) then
        done_int <= '1';
      end if;
    end process;
  end generate noregs_done;

end fsmd;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity remu is
  generic (
    mode  : string  := "REGISTERED";
--    mode  : string  := "COMBINATIONAL";
    W     : integer := 8
  );
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    start : in  std_logic;
    x     : in  std_logic_vector;
    z     : in  std_logic_vector;
    outp  : out std_logic_vector;
    done  : out std_logic;
    ready : out std_logic
  );
end remu;

architecture fsmd of remu is
  component xmodz is
    generic (
      mode : string := "REGISTERED";
--      mode : string := "COMBINATIONAL";
      N : integer := 8
    );
    port (
      clk   : in  std_logic;
      reset : in  std_logic;
      x     : in  std_logic_vector(N-1 downto 0);
      z     : in  std_logic_vector(N-1 downto 0);
      outp  : out std_logic_vector(N-1 downto 0);
      done  : out std_logic
    );
  end component;
  --   
  type state_type is (S_ENTRY, S_EXIT, S_001_001, S_001_002);
  signal current_state, next_state : state_type;
  signal count : std_logic_vector(W-1 downto 0);
  signal done_int : std_logic;
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
  
  regs: if mode = "REGISTERED" generate
    -- next state and output logic
    process (current_state, start, 
      x, z, done_int)
    begin
      done <= '0';
      ready <= '0';
      case current_state is
        when S_ENTRY =>
          ready <= '1';
          if (start = '1') then
--            count <= (others => '0');
            next_state <= S_001_001;
          else
            next_state <= S_ENTRY;
          end if;
        when S_001_001 =>
--          count <= std_logic_vector(unsigned(count) + to_unsigned(1,W));
          if (done_int = '1') then
            next_state <= S_001_002;
          else
            next_state <= S_001_001;
          end if;
        when S_001_002 =>
          next_state <= S_EXIT;
        when S_EXIT =>
          done <= '1';
          next_state <= S_ENTRY;
        when others =>
          next_state <= S_ENTRY;
      end case;
    end process;
  end generate regs;

  noregs: if mode = "COMBINATIONAL" generate
    -- next state and output logic
    process (current_state, start, 
      x, z)
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
          next_state <= S_EXIT;
        when S_EXIT =>
          done <= '1';
          next_state <= S_ENTRY;        
        when others =>
          next_state <= S_ENTRY;
      end case;
    end process;
  end generate noregs;
  
  test : xmodz
    generic map (
      mode => mode,
      N    => x'LEFT-x'RIGHT+1
    )
    port map ( 
      clk   => clk,
      reset => start,
      x     => x,
      z     => z,
      outp  => outp,
      done  => done_int
    );

end fsmd;
