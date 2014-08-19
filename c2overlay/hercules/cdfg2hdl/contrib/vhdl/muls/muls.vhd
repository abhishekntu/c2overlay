library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity muls is
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
end muls;

architecture fsmd of muls is
  type state_type is (S_ENTRY, S_EXIT, S_001_001);
  signal current_state, next_state: state_type;
  signal a_sgn     : std_logic;
  signal b_sgn     : std_logic;
  signal c_sgn     : std_logic;
  signal t_a_reg   : std_logic_vector(a'RANGE);
  signal t_a_next  : std_logic_vector(a'RANGE);
  signal t_b_reg   : std_logic_vector(b'RANGE);
  signal t_b_next  : std_logic_vector(b'RANGE);
  signal t_c_reg   : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
  signal t_c_next  : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
  signal t_c1_reg  : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
  signal t_c1_next : std_logic_vector(a'LENGTH+b'LENGTH-1 downto 0);
begin
  -- current state logic
  process (clk, reset)
  begin
    if (reset = '1') then
      current_state <= S_ENTRY;
      t_a_reg <= (others => '0');
      t_b_reg <= (others => '0');
      t_c_reg <= (others => '0');
      t_c1_reg <= (others => '0');
    elsif (clk = '1' and clk'EVENT) then
      current_state <= next_state;
      t_a_reg <= t_a_next;
      t_b_reg <= t_b_next;
      t_c_reg <= t_c_next;
      t_c1_reg <= t_c1_next;
    end if;
  end process;

  -- next state and output logic
  process (current_state, start,
    a, b, 
    t_a_reg, t_a_next, 
    t_b_reg, t_b_next,
    t_c_reg, t_c_next,
    t_c1_reg, t_c1_next
  )
  begin
    done <= '0';
    ready <= '0';
    t_a_next <= t_a_reg;
    t_b_next <= t_b_reg;
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
        a_sgn <= a(a'LENGTH-1);
        b_sgn <= b(b'LENGTH-1);
        c_sgn <= a_sgn xor b_sgn;
        if (a_sgn = '1') then
          t_a_next(a'LENGTH-2 downto 0) <= not a(a'LENGTH-2 downto 0);
          t_a_next(a'LENGTH-2 downto 0) <= std_logic_vector(unsigned(a(a'LENGTH-2 downto 0)) + "1");
        else
          t_a_next <= a;
        end if;
        if (b_sgn = '1') then
          t_b_next(b'LENGTH-2 downto 0) <= not b(b'LENGTH-2 downto 0);
          t_b_next(b'LENGTH-2 downto 0) <= std_logic_vector(unsigned(b(b'LENGTH-2 downto 0)) + "1");
        else
          t_b_next <= b;
        end if;
        t_c_next(a'LENGTH+b'LENGTH-3 downto 0) <= std_logic_vector(unsigned(t_a_next(a'LENGTH-2 downto 0)) * unsigned(t_b_next(b'LENGTH-2 downto 0)));
        if (c_sgn = '1') then
          t_c1_next(a'LENGTH+b'LENGTH-3 downto 0) <= not t_c_next(a'LENGTH+b'LENGTH-3 downto 0);
          t_c1_next(a'LENGTH+b'LENGTH-3 downto 0) <= std_logic_vector(unsigned(t_c_next(a'LENGTH+b'LENGTH-3 downto 0)) + "1");
        else
          t_c1_next <= t_c_next;
        end if;
        t_c1_next(a'LENGTH+b'LENGTH-2) <= c_sgn;
        t_c1_next(a'LENGTH+b'LENGTH-1) <= c_sgn;
        next_state <= S_EXIT;
      when S_EXIT =>        
        done <= '1';
        next_state <= S_ENTRY;
      when others =>
        next_state <= S_ENTRY;
    end case;
  end process;
  c <= t_c1_reg(c'LEFT downto c'RIGHT);
end fsmd;
