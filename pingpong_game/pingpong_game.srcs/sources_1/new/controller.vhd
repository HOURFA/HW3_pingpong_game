library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constant_def.all;


entity controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           buttom_a : in STD_LOGIC;
           buttom_b : in STD_LOGIC;
           water_lamp_en : out STD_LOGIC;
           water_lamp_path : out STD_LOGIC;
           score : out STD_LOGIC);
end controller;

architecture Behavioral of controller is

begin


end Behavioral;
