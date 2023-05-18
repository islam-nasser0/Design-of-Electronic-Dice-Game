library ieee;
use ieee.std_logic_1164.all;

entity Point_Register is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        en     : in  std_logic;
        din    : in  std_logic_vector(3 downto 0);
        dout   : out std_logic_vector(3 downto 0)
    );
end Point_Register;

architecture Behavioral of Point_Register is
    signal point_reg : std_logic_vector(3 downto 0);
begin
    process (clk, rst)
    begin
        if rst = '0' then
            point_reg <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                point_reg <= din;
            end if;
        end if;
    end process;

    dout <= point_reg;
end Behavioral;
