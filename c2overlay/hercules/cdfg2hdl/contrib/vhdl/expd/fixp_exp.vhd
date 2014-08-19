library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

package pkg_exp is
  component exp_31 is
    port (x : in  std_logic_vector(31 - 1 downto 0);
          y : out std_logic_vector(32 - 1 downto 0));
  end component;
  component exp_37 is
    port (x : in  std_logic_vector(37 - 1 downto 0);
          y : out std_logic_vector(38 - 1 downto 0));
  end component;
  component exp_40 is
    port (x : in  std_logic_vector(40 - 1 downto 0);
          y : out std_logic_vector(41 - 1 downto 0));
  end component;
  component exp_43 is
    port (x : in  std_logic_vector(43 - 1 downto 0);
          y : out std_logic_vector(44 - 1 downto 0));
  end component;
  component exp_46 is
    port (x : in  std_logic_vector(46 - 1 downto 0);
          y : out std_logic_vector(47 - 1 downto 0));
  end component;
  component exp_49 is
    port (x : in  std_logic_vector(49 - 1 downto 0);
          y : out std_logic_vector(50 - 1 downto 0));
  end component;
  component exp_52 is
    port (x : in  std_logic_vector(52 - 1 downto 0);
          y : out std_logic_vector(53 - 1 downto 0));
  end component;
  component exp_56 is
    port (x : in  std_logic_vector(56 - 1 downto 0);
          y : out std_logic_vector(57 - 1 downto 0));
  end component;
  component exp_58 is
    port (x : in  std_logic_vector(58 - 1 downto 0);
          y : out std_logic_vector(59 - 1 downto 0);
          sign : in std_logic);
  end component;
end package;

-- exp d'un nombre avec une mantisse de 59 bits dont 31 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;

entity exp_31 is
  port (x : in  std_logic_vector(31 - 1 downto 0);
        y : out std_logic_vector(32 - 1 downto 0));
end entity;

architecture arch of exp_31 is
  signal part_1 : std_logic_vector(31 - 1 downto 0);
  -- valeur lue dans la table pour ce morceau
  signal tbl_out : std_logic_vector(3 - 1 downto 0);
  -- exponentielle du morceau moins 1
  signal exp_part1 : std_logic_vector(32 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x;
  -- exponentielle de cette partie
  component1 : exp_tbl_31
    port map (x => part_1(31 - 1 downto 27),
              y => tbl_out);
  exp_part1 <= ("0" & part_1) + ("00000000000000000000000000000" & tbl_out);

  y <= exp_part1;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 37 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_31;

entity exp_37 is
  port (x : in  std_logic_vector(37 - 1 downto 0);
        y : out std_logic_vector(38 - 1 downto 0));
end entity;

architecture arch of exp_37 is
  signal part_1 : std_logic_vector(37 - 1 downto 31);
  -- valeur lue dans la table pour ce morceau
  signal tbl_out : std_logic_vector(14 - 1 downto 0);
  -- exponentielle du morceau moins 1
  signal exp_part1 : std_logic_vector(37 - 1 downto 0);
  -- exponentielle des morceaux suivants moins 1
  signal exp_part2 : std_logic_vector(32 - 1 downto 0);
  -- produit des deux signaux precedents
  signal product : std_logic_vector(21 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(37 - 1 downto 31);
  -- exponentielle de cette partie
  component1 : exp_tbl_37
    port map (x => part_1,
              y => tbl_out);
  exp_part1 <= part_1 & ("00000000000000000" & tbl_out);

  -- exponentielle de la partie restante
  component2 : exp_31
    port map (x => x(31 - 1 downto 0),
              y => exp_part2);

  -- calcul du resultat
  product <= exp_part1(37 - 1 downto 27) * exp_part2(32 - 1 downto 21);

  y <= ("0" & exp_part1) + ("000000" & exp_part2) + ("0000000000000000000000000000" & product(21 - 1 downto 11));
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 40 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_37;

entity exp_40 is
  port (x : in  std_logic_vector(40 - 1 downto 0);
        y : out std_logic_vector(41 - 1 downto 0));
end entity;

architecture arch of exp_40 is
  signal part_1 : std_logic_vector(40 - 1 downto 36);
  signal exp_part1 : std_logic_vector(4 - 1 downto 0);
  signal remainder_1 : std_logic_vector(36 - 1 downto 0);
  signal remainder_2 : std_logic_vector(36 - 1 downto 0);
  signal remainder : std_logic_vector(37 - 1 downto 0);
  signal exp_rmd : std_logic_vector(38 - 1 downto 0);
  signal product : std_logic_vector(42 - 1 downto 0);
  signal signed_part : std_logic_vector(41 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(40 - 1 downto 36);
  -- exponentielle de cette partie
  exp_part1 <= part_1;

  -- partie restante
  component2 : log_tbl_40
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(36 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_37
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= ("0" & exp_part1 & "000000000000000000000000000000000000") + ("0000000000000000000000" & product(42 - 1 downto 23));
  y <= ("000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 43 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_40;

entity exp_43 is
  port (x : in  std_logic_vector(43 - 1 downto 0);
        y : out std_logic_vector(44 - 1 downto 0));
end entity;

architecture arch of exp_43 is
  signal part_1 : std_logic_vector(43 - 1 downto 39);
  signal exp_part1 : std_logic_vector(4 - 1 downto 0);
  signal remainder_1 : std_logic_vector(39 - 1 downto 0);
  signal remainder_2 : std_logic_vector(39 - 1 downto 0);
  signal remainder : std_logic_vector(40 - 1 downto 0);
  signal exp_rmd : std_logic_vector(41 - 1 downto 0);
  signal product : std_logic_vector(45 - 1 downto 0);
  signal signed_part : std_logic_vector(44 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(43 - 1 downto 39);
  -- exponentielle de cette partie
  exp_part1 <= part_1;

  -- partie restante
  component2 : log_tbl_43
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(39 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_40
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= ("0" & exp_part1 & "000000000000000000000000000000000000000") + ("0000000000000000000" & product(45 - 1 downto 20));
  y <= ("000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 46 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_43;

entity exp_46 is
  port (x : in  std_logic_vector(46 - 1 downto 0);
        y : out std_logic_vector(47 - 1 downto 0));
end entity;

architecture arch of exp_46 is
  signal part_1 : std_logic_vector(46 - 1 downto 42);
  signal exp_part1 : std_logic_vector(4 - 1 downto 0);
  signal remainder_1 : std_logic_vector(42 - 1 downto 0);
  signal remainder_2 : std_logic_vector(42 - 1 downto 0);
  signal remainder : std_logic_vector(43 - 1 downto 0);
  signal exp_rmd : std_logic_vector(44 - 1 downto 0);
  signal product : std_logic_vector(48 - 1 downto 0);
  signal signed_part : std_logic_vector(47 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(46 - 1 downto 42);
  -- exponentielle de cette partie
  exp_part1 <= part_1;

  -- partie restante
  component2 : log_tbl_46
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(42 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_43
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= ("0" & exp_part1 & "000000000000000000000000000000000000000000") + ("0000000000000000" & product(48 - 1 downto 17));
  y <= ("000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 49 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_46;

entity exp_49 is
  port (x : in  std_logic_vector(49 - 1 downto 0);
        y : out std_logic_vector(50 - 1 downto 0));
end entity;

architecture arch of exp_49 is
  signal part_1 : std_logic_vector(49 - 1 downto 45);
  signal exp_part1 : std_logic_vector(4 - 1 downto 0);
  signal remainder_1 : std_logic_vector(45 - 1 downto 0);
  signal remainder_2 : std_logic_vector(45 - 1 downto 0);
  signal remainder : std_logic_vector(46 - 1 downto 0);
  signal exp_rmd : std_logic_vector(47 - 1 downto 0);
  signal product : std_logic_vector(51 - 1 downto 0);
  signal signed_part : std_logic_vector(50 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(49 - 1 downto 45);
  -- exponentielle de cette partie
  exp_part1 <= part_1;

  -- partie restante
  component2 : log_tbl_49
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(45 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_46
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= ("0" & exp_part1 & "000000000000000000000000000000000000000000000") + ("0000000000000" & product(51 - 1 downto 14));
  y <= ("000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 52 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_49;

entity exp_52 is
  port (x : in  std_logic_vector(52 - 1 downto 0);
        y : out std_logic_vector(53 - 1 downto 0));
end entity;

architecture arch of exp_52 is
  signal part_1 : std_logic_vector(52 - 1 downto 48);
  signal exp_part1 : std_logic_vector(4 - 1 downto 0);
  signal remainder_1 : std_logic_vector(48 - 1 downto 0);
  signal remainder_2 : std_logic_vector(48 - 1 downto 0);
  signal remainder : std_logic_vector(49 - 1 downto 0);
  signal exp_rmd : std_logic_vector(50 - 1 downto 0);
  signal product : std_logic_vector(54 - 1 downto 0);
  signal signed_part : std_logic_vector(53 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(52 - 1 downto 48);
  -- exponentielle de cette partie
  exp_part1 <= part_1;

  -- partie restante
  component2 : log_tbl_52
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(48 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_49
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= ("0" & exp_part1 & "000000000000000000000000000000000000000000000000") + ("0000000000" & product(54 - 1 downto 11));
  y <= ("000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 56 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_52;

entity exp_56 is
  port (x : in  std_logic_vector(56 - 1 downto 0);
        y : out std_logic_vector(57 - 1 downto 0));
end entity;

architecture arch of exp_56 is
  signal exp_tbl_out : std_logic_vector(52 - 1 downto 51);
  signal part_1 : std_logic_vector(56 - 1 downto 51);
  signal exp_part1 : std_logic_vector(6 - 1 downto 0);
  signal remainder_1 : std_logic_vector(51 - 1 downto 0);
  signal remainder_2 : std_logic_vector(51 - 1 downto 0);
  signal remainder : std_logic_vector(52 - 1 downto 0);
  signal exp_rmd : std_logic_vector(53 - 1 downto 0);
  signal product : std_logic_vector(59 - 1 downto 0);
  signal signed_part : std_logic_vector(57 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(56 - 1 downto 51);
  -- exponentielle de cette partie
  component1 : exp_tbl_56
    port map (x => part_1,
              y => exp_tbl_out);
  exp_part1 <= ("0" & part_1) + ("00000" & exp_tbl_out);

  -- partie restante
  component2 : log_tbl_56
    port map (x => part_1,
              y => remainder_1);
  remainder_2 <= x(51 - 1 downto 0);
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_52
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= (exp_part1 & "000000000000000000000000000000000000000000000000000") + ("000000" & product(59 - 1 downto 8));
  y <= ("0000" & exp_rmd) + signed_part;
end architecture;

-- exp d'un nombre avec une mantisse de 59 bits dont 58 non nuls
-- =============================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.pkg_exp_tbl.all;
use work.pkg_exp.exp_56;

entity exp_58 is
  port (x : in  std_logic_vector(58 - 1 downto 0);
        y : out std_logic_vector(59 - 1 downto 0);
        sign : in std_logic);
end entity;

architecture arch of exp_58 is
  signal signed_input : std_logic_vector(5 - 1 downto 0);
  signal exp_tbl_out : std_logic_vector(57 - 1 downto 54);
  signal part_1 : std_logic_vector(58 - 1 downto 54);
  signal exp_part1 : std_logic_vector(5 - 1 downto 0);
  signal remainder_1 : std_logic_vector(55 - 1 downto 0);
  signal remainder_2 : std_logic_vector(55 - 1 downto 0);
  signal remainder : std_logic_vector(56 - 1 downto 0);
  signal exp_rmd : std_logic_vector(57 - 1 downto 0);
  signal product : std_logic_vector(62 - 1 downto 0);
  signal signed_part : std_logic_vector(59 - 1 downto 0);
begin
  -- premiere partie
  part_1 <= x(58 - 1 downto 54);
  -- exponentielle de cette partie
  signed_input(4) <= sign;
  signed_input(4 - 1 downto 0) <= part_1;
  component1 : exp_tbl_58
    port map (x => signed_input,
              y => exp_tbl_out);
  exp_part1 <= ("0" & part_1) + ("00" & exp_tbl_out) when sign = '0' else ("0" & part_1) + "00001" - ("00" & exp_tbl_out);

  -- partie restante
  component2 : log_tbl_58
    port map (x => signed_input,
              y => remainder_1);
  remainder_2 <= ("0" & x(54 - 1 downto 0)) when sign = '0' else "1000000000000000000000000000000000000000000000000000000" - ("0" & x(54 - 1 downto 0));
  remainder <= ("0" & remainder_1) + ("0" & remainder_2);
  -- exponentielle de ce reste
  component3 : exp_56
    port map (x => remainder,
              y => exp_rmd);

  -- calcul du resultat
  product <= exp_part1 * exp_rmd;
  signed_part <= (exp_part1 & "000000000000000000000000000000000000000000000000000000") + ("00" & product(62 - 1 downto 5));
  y <= ("00" & exp_rmd) + signed_part when sign = '0' else ("00" & exp_rmd) - signed_part;
end architecture;

