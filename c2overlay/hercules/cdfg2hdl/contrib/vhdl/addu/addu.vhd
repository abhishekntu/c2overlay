library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity addu is
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
end addu;

architecture fsmd of addu is
  type state_type is (S_ENTRY, S_EXIT, S_001_001);
  signal current_state, next_state: state_type;
  signal t_c_reg   : std_logic_vector(a'LENGTH-1 downto 0);
  signal t_c_next  : std_logic_vector(a'LENGTH-1 downto 0);
  signal t_c1_reg  : std_logic_vector(a'LENGTH downto 0);
  signal t_c1_next : std_logic_vector(a'LENGTH downto 0);
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
      t_c_reg <= (others => '0');
      t_c1_reg <= (others => '0');
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      t_c_reg <= t_c_next;
      t_c1_reg <= t_c1_next;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    a, b, 
    t_c_reg, t_c_next,
    t_c1_reg, t_c1_next
  )
  begin
    done <= '0';
    ready <= '0';
    t_c_next <= t_c_reg;
    t_c1_next <= t_c1_reg;
    case current_state is
      when S_ENTRY =>
        ready <= '1';
        if (start = '1') then
          next_state <= S_001_001;
        else
          next_state <= S_ENTRY;
        end if;
      when S_001_001 =>
        t_c1_next <= ('0' & a) + ('0' & b);
        t_c_next <= t_c1_next(a'RANGE);
        next_state <= S_EXIT;
      when S_EXIT =>        
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;
  c <= t_c_reg(c'LEFT downto c'RIGHT);
end fsmd;
