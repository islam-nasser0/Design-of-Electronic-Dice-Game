library ieee;
use ieee.std_logic_1164.all;

entity comparator is
    port (
        a, b: in std_logic_vector(3 downto 0);
        result: out std_logic
    );
end entity;

architecture behavioral of comparator is
begin
    process(a, b)
    begin
        if (a = b) then
            result <= '1';  -- set result to high if a = b
        else
            result <= '0';  -- set result to low if a != b
        end if;
    end process;
end architecture;
