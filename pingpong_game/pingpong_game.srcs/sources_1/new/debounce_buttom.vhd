library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constant_def.all;


entity debounce_buttom is
    Port ( buttom_in : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           buttom_out : out STD_LOGIC);
end debounce_buttom;

architecture Behavioral of debounce_buttom is

signal        cnt : integer;                       

begin

cnt_process : process(clk,rst,cnt)
begin
    if rst = '1' then
        cnt <= 0;
        buttom_out <= '0';
    else
        if rising_edge(clk) and buttom_in = '1' then
            if cnt < DEBOUNCE_CONSTANT then
                cnt <= cnt + 1 ;
            else
               buttom_out <= '1';
            end if;
        else
            cnt <= 0;
            buttom_out <= '0';
        end if;
    end if;
end process;


end Behavioral;
