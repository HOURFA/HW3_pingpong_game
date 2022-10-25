library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constant_def.all;

entity water_lamp is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           water_lamp_en : in STD_LOGIC;
           water_lamp_path : in STD_LOGIC;
           led_out_bus : inout STD_LOGIC_VECTOR (LED_NUM-1 downto 0));
end water_lamp;

architecture Behavioral of water_lamp is

type FSM    is (idle,left_shift,right_shift);

signal water_lamp_FSM : FSM;

begin

FSM_process : process(clk,rst,water_lamp_path)
begin
    if rst = '1' then
        water_lamp_FSM <= idle;
    else
        if rising_edge(clk)  and water_lamp_en = '1' then
            case water_lamp_path is
                when '1' => water_lamp_FSM <= left_shift;
                when '0' => water_lamp_FSM <= right_shift;
            end case;
        else
            water_lamp_FSM <= idle;
        end if;
    end if;
end process;

action_process : process(clk,rst,water_lamp_FSM)
begin
    if rst = '1' then
        led_out_bus <= (others => '0');
    else
        if rising_edge(clk)  and water_lamp_en = '1' then
            case water_lamp_FSM is
                when idle =>
                when left_shift =>
                    if led_out_bus = "00000000" then
                        led_out_bus(0) <= '1';
                    end if;
                    led_out_bus <= led_out_bus(6 downto 0) & '0';
                when right_shift =>
                    if led_out_bus = "00000000" then
                        led_out_bus(7) <= '1';
                    end if;
                    led_out_bus <=  '0' & led_out_bus(6 downto 0);                
            end case;
        end if;
    end if;
end process;

end Behavioral;
