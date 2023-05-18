library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity counter is
    port (
        clk: in std_logic;
        reset: in std_logic;
--        load : in std_logic;
        start_value : in integer range 1 to 6;
        enable: in std_logic;
        count_out: out std_logic_vector(3 downto 0)
    );
end counter;

architecture Behavioral of counter is
    signal count_reg: integer range 1 to 6 := 1;
begin
    process( clk, reset)
    begin
if(rising_edge(clk) ) then
    if(reset='0') then
            count_reg <= start_value;

    elsif  enable = '1' then
	    if count_reg = 6 then
            count_reg <= 1;
	    else 
		count_reg <= count_reg + 1; 
        	end if;
        

    end if;

end if;
    end process;
count_out <= std_logic_vector(to_unsigned(count_reg, 4));
end Behavioral;

--if count_reg = 6 then
  --  count_reg <= 1;
--else
--count_reg <= count_reg + 1; end if;