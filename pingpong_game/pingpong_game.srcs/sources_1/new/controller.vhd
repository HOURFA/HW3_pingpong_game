library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constant_def.all;


entity controller is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           buttom_left : in STD_LOGIC;
           buttom_right : in STD_LOGIC;
           led_position : in STD_LOGIC_VECTOR(LED_NUM-1 downto 0);
           water_lamp_en : inout STD_LOGIC;
           water_lamp_path : out STD_LOGIC;             -- '1' =>left_shift 、'0' => right_shift
           score_left : inout STD_LOGIC;
           score_right : inout STD_LOGIC);
end controller;

architecture Behavioral of controller is

type FSM is (score_judge , left_hit , right_hit);

signal SYSTEM_FSM : FSM;
signal hit_act_left , hit_act_right: std_logic_vector(1 downto 0);             -- "10" => error_hit 、 "01" => correct_hit 、 "00" =>wait_hit

begin

FSM_PROCESS :process(rst,clk,buttom_left,buttom_right,led_position)
begin

    if rst = '1' then
        SYSTEM_FSM <= left_hit;
    else
        if rising_edge(clk)then
            case SYSTEM_FSM is 
                when score_judge =>                 --when error_hit = 1 someone is error hit => anotherone score add 1
                    if score_right = '1' then
                        SYSTEM_FSM <= left_hit;
                    elsif score_left = '1' then
                        SYSTEM_FSM <= right_hit;
                    else
                        SYSTEM_FSM <= score_judge;
                    end if;
                when left_hit =>
                    case hit_act_left is
                        when "10" => SYSTEM_FSM <= score_judge;
                        when "01" => SYSTEM_FSM <= right_hit;
                        when others => SYSTEM_FSM <= left_hit;
                    end case;
                when right_hit =>
                    case hit_act_right is
                        when "10" => SYSTEM_FSM <= score_judge;
                        when "01" => SYSTEM_FSM <= left_hit;
                        when others => SYSTEM_FSM <= right_hit;
                    end case;                
            end case;
        end if;
    end if;
end process;
ACT_PROCESS :process(rst,clk,buttom_left,buttom_right,led_position,water_lamp_en)
begin

    if rst = '1' then
        SYSTEM_FSM <= left_hit;
    else
        if rising_edge(clk)then
            case SYSTEM_FSM is 
                when score_judge =>                 --when hit_act = 10 someone is error hit => anotherone score add 1
                    water_lamp_en <= '0';
                    if hit_act_left = "10" then        
                        score_right <= '1';
                    else
                        score_right <= '0';
                    end if;
                    if hit_act_right = "10" then
                        score_left <= '1';
                    else
                        score_left <= '0';
                    end if;
                when left_hit =>
                    water_lamp_path <= '1';     -- left_shift
                    if water_lamp_en = '0' then
                        if buttom_right = '1'then    --  發球
                            water_lamp_en <= '1';
                        end if;
                    else                    
                        if led_position(0) = '1' and buttom_left = '1'then                   --'only' this situation is correct
                            hit_act_left <= "01";
                        else
                            hit_act_left <= "10";
                        end if;
                    end if;
                when right_hit =>
                    water_lamp_path <= '0';     --right_shift
                    if water_lamp_en = '0' then
                        if buttom_left = '1' then  --發球
                            water_lamp_en <= '1';
                        end if;
                    else
                        if led_position(LED_NUM - 1) = '1' and buttom_right = '1'then       --'only' this situation is correct
                            hit_act_right <= "01";
                        else
                            hit_act_right <= "10";
                        end if;
                   end if;
            end case;
        end if;
    end if;

end process;

end Behavioral;
