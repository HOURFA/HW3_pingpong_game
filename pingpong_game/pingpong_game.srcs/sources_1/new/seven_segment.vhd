library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.constant_def.all;

entity seven_segment is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           plus_in : in STD_LOGIC;
           score_out : out STD_LOGIC_VECTOR (7 downto 0));
end seven_segment;

architecture Behavioral of seven_segment is

signal score        : std_logic_vector(3 downto 0);
begin

plus_process : process(plus_in)
begin
    if plus_in = '1' then
        score <= std_logic_vector((to_signed((to_integer(signed(score)) + 1),4)));
    else
        score <= score;
    end if;
end process;

score_process : process(clk,rst)
begin
    if rst = '1' then
        score_out <= "11000000";
    else
        if rising_edge(clk)then
            case score is
                when "0001" =>  score_out <= "11111001";     --1
                when "0010" =>  score_out <= "10100100";     --2
                when "0011" =>  score_out <= "10110000";     --3
                when "0100" =>  score_out <= "10011001";     --4
                when "0101" =>  score_out <= "10010010";     --5
                when "0110" =>  score_out <= "10000010";     --6
                when "0111" =>  score_out <= "11111000";     --7
                when "1000" =>  score_out <= "10000000";     --8
                when "1001" =>  score_out <= "10010000";     --9
                when "1010" =>  score_out <= "10001000";     --A
                when "1011" =>  score_out <= "10000011";     --b
                when "1100" =>  score_out <= "11000110";     --c                
                when "1101" =>  score_out <= "10100001";     --d
                when "1110" =>  score_out <= "10000110";     --E
                when "1111" =>  score_out <= "10001110";     --F
                when others  =>  score_out <= "11000000";     --0 
            end case;
        end if;
    end if;



end process;
end Behavioral;
