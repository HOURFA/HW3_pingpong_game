library IEEE;
use ieee.std_logic_1164.all;
package constant_def is
    constant CLK_CONSTANT        : integer := 100000000;        --100MHz 
    constant DIV_CLK_CONSTANT    : integer := 35000000;         --T = 0.35s
    constant DEBOUNCE_CONSTANT   : integer := 5000;
    constant LED_NUM             : integer := 8;

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
           water_lamp_out : out STD_LOGIC_VECTOR (LED_NUM-1 downto 0));
end pingpong_game_top;

architecture Behavioral of pingpong_game_top is
component controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           buttom_left : in STD_LOGIC;
           buttom_right : in STD_LOGIC;
           led_position : in STD_LOGIC_VECTOR(LED_NUM-1 downto 0);
           water_lamp_en : inout STD_LOGIC;
           water_lamp_path : out STD_LOGIC;             -- '1' =>left_shift ¡B'0' => right_shift
           score_left : inout STD_LOGIC;
           score_right : inout STD_LOGIC);
end component;
component debounce_buttom is
    Port ( buttom_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           buttom_out : out STD_LOGIC);
end component;
component divider is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           div_clk : out STD_LOGIC);
end component;
component seven_segment is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           plus_in : in STD_LOGIC;
           score_out : out STD_LOGIC_VECTOR (7 downto 0));
end component;
component water_lamp is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           water_lamp_en : in STD_LOGIC;
           water_lamp_path : in STD_LOGIC;
           led_out_bus : inout STD_LOGIC_VECTOR (LED_NUM-1 downto 0));
end component;

signal div_clk : std_logic;


begin

divider_1: divider
    Port map( clk => clk,
           rst => rst,
           div_clk => div_clk);


end Behavioral;
