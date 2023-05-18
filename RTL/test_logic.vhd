library ieee;
use ieee.std_logic_1164.all;

entity test_logic is
    port (
        a: in std_logic_vector(3 downto 0);
        result_7_11,result_2_3_12: out std_logic
    );
end entity;

architecture behavioral of test_logic is
begin
    process(a)
    begin
        if (a="0111")then  
        result_7_11 <= '1';  
        result_2_3_12<= '1';
        elsif (a = "0111" or a = "1011") then  
            result_7_11 <= '1';  
             result_2_3_12<= '0';
        elsif (a = "0010" or a = "0011" or a = "1100") then 
            result_7_11 <= '0';  
            result_2_3_12 <= '1';  
        else 
        result_7_11 <= '0';  
        result_2_3_12 <= '0';              
        end if;
    end process;
end architecture;
