library ieee;
use ieee.std_logic_1164.all;

entity controller is
port(
    clk         : in std_logic;
    reset       : in std_logic;
    roll       : in std_logic;    
    comparator       : in std_logic;    
    result_7_11         : in std_logic;
    result_2_3_12       : in std_logic;    
    en     : out std_logic;
    en_counter     : out std_logic;
--    load_counter : out std_logic;
    win     : out std_logic;    
    lose     : out std_logic  

);
end controller;

architecture behavior of controller is

    -- Define states
    type state_type is (reset_state, win_state, lose_state, not_yet_state);
    signal current_state, next_state : state_type;
    signal result_7_11_reg,result_2_3_12_reg : std_logic;
    -- Define state outputs
--    signal red_output, yellow_output, green_output : std_logic;
    
    -- Define timer counter
--    signal timer_counter : integer range 0 to 100000 := 0;
    
begin

    -- State machine process
    process(clk, reset,roll)
    begin
        
        -- Reset state machine on reset signal
        if reset = '0' then
            current_state <= reset_state;
            result_7_11_reg<='0';
            result_2_3_12_reg<='0';            
--            timer_counter <= 0;
        -- State transition logic    
        elsif rising_edge(clk) then
            current_state <= next_state;
            if (roll='0') then 
            result_7_11_reg<=result_7_11;
            result_2_3_12_reg<=result_2_3_12; end if;
end if;
end process;  --result_7_11,result_2_3_12

    process ( current_state, result_7_11_reg, result_2_3_12_reg,comparator )   begin      
            case current_state is
                when reset_state =>
                    if ((result_7_11_reg='1' and result_2_3_12_reg= '0') or (result_7_11_reg='1' and result_2_3_12_reg= '1')) then
                        next_state <= win_state;
                        --timer_counter <= 0;
                    elsif (result_7_11_reg = '0' and result_2_3_12_reg = '1') then
                        next_state <= lose_state;
                        --timer_counter <= timer_counter + 1;
                    else 
                        next_state <= not_yet_state;
                    end if;
                when win_state =>
                    if ((result_7_11_reg='1' and result_2_3_12_reg= '0') or (result_7_11_reg='1' and result_2_3_12_reg= '1')) then
                        next_state <= win_state;
                        --timer_counter <= 0;
                    elsif (result_7_11_reg='0' and result_2_3_12_reg= '1') then
                        next_state <= lose_state;
                        --timer_counter <= timer_counter + 1;
                    else 
                        next_state <= not_yet_state;
                    end if;
                when lose_state =>
                    if ((result_7_11_reg='1' and result_2_3_12_reg= '0') or (result_7_11_reg='1' and result_2_3_12_reg= '1')) then
                        next_state <= win_state; 
                    elsif (result_7_11_reg='0' and result_2_3_12_reg= '1')then
                        next_state <= lose_state;
                        --timer_counter <= timer_counter + 1;
                    else 
                        next_state <= not_yet_state;
                     end if;
                when not_yet_state =>
                    if (comparator = '1') then 
                        next_state <= win_state;
                    elsif (result_7_11_reg='1' and result_2_3_12_reg= '1') then 
                        next_state <= lose_state;
                    else 
                        next_state <= not_yet_state;
                    end if;                    
            end case;        
    end process;
    process(current_state,roll)

    begin
        case current_state is
            when reset_state =>
             win<= '0';
             lose<='0';
             en<='0';
             when win_state =>
             if (roll='1') then 
             win<= '0';
             lose<='0';
             en<='0';             
             else 
             win<= '1';
             lose<='0';
             en<='0';end if;
             when lose_state =>
             if (roll='1') then 
             win<= '0';
             lose<='0';
             en<='0';             
             else 
             win<= '0';
             lose<='1';
             en<='0';end if;
             when not_yet_state =>
             if (roll='1') then 
             win<= '0';
             lose<='0';
             en<='0';             
             else 
             win<= '0';
             lose<='0';
             en<='1';end if;
                
        end case;
    end process;

en_counter <= '1' when roll='1' else '0';

end behavior;
