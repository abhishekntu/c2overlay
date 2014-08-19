library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mulu is
  port (
    clk   : in  std_logic;
    reset : in  std_logic;
    start : in  std_logic;
    a     : in  std_logic_vector;
    b     : in  std_logic_vector;
    c     : out std_logic_vector;
    done  : out std_logic;
    ready : out std_logic
  );
end mulu;

architecture fsmd of mulu is
  type state_type is (S_ENTRY, S_EXIT, S_001_001);
  signal current_state, next_state: state_type;
  signal t_c   : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
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
    a, b, t_c
  )
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
        t_c <= std_logic_vector(unsigned(a) * unsigned(b));    
        next_state <= S_EXIT;
      when S_EXIT =>        
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;
  c <= t_c(c'LEFT downto c'RIGHT);
end fsmd;
