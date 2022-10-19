library IEEE;
use ieee.std_logic_1164.all;
package constant_def is
    constant CLK_CONSTANT        : integer := 100000000;        --100MHz 
    constant DIV_CLK_CONSTANT    : integer := 300000;
    constant DEBOUNCE_CONSTANT   : integer := 5000;

end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constant_def.all;


entity pingpong_game_top is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           buttom_player_B : in STD_LOGIC;
           buttom_player_A : in STD_LOGIC;
           score_A : out STD_LOGIC_VECTOR (7 downto 0);
           score_B : out STD_LOGIC_VECTOR (7 downto 0);
           water_lamp : out STD_LOGIC_VECTOR (7 downto 0));
end pingpong_game_top;

architecture Behavioral of pingpong_game_top is

begin


end Behavioral;
