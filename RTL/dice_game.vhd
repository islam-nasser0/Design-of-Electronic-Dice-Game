library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- ports 
entity dice_game is
    port (
      clk : in std_logic;
      reset : in std_logic;
      roll : in std_logic; -- roll starts counters to count
      win : out std_logic; -- win flag 
      lose : out std_logic -- lose flag 
    );
  end entity dice_game;
  
  architecture rtl of dice_game is
  
-- counter module => counts from 1 to 6
component counter is
    port (
        clk: in std_logic;
        reset: in std_logic;
--        load : in std_logic;
        start_value : in integer range 1 to 6;
        enable: in std_logic;
        count_out: out std_logic_vector(3 downto 0)
    );
end component;

-- adder module => add the output of counter1 + counter2 , op=0 addition , op=1 subtraction

component addsub is
    port( OP: in std_logic;
           A,B  : in std_logic_vector(3 downto 0);
           R  : out std_logic_vector(3 downto 0)
           );
end component;

-- point_reg module => to store output of adder in case of not_yet_case

component Point_Register is
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        en     : in  std_logic;
        din    : in  std_logic_vector(3 downto 0);
        dout   : out std_logic_vector(3 downto 0)
    );
end component;

-- comparator module => to compare the point_reg with adder output 

component comparator is
    port (
        a, b: in std_logic_vector(3 downto 0);
        result: out std_logic
    );
end component;

-- test_logic module => test if adder_out =3,7 win ... if adder_out = 2,3,12 lose

component test_logic is
    port (
        a: in std_logic_vector(3 downto 0);
        result_7_11,result_2_3_12: out std_logic
    );
end component;

-- controller module => control all previous modules through control signals and ASM

component controller is
    port(
        clk         : in std_logic;
        reset       : in std_logic;
        roll       : in std_logic;    
        comparator       : in std_logic;   -- signal from comparator if point_reg == adder_out , comparator =1  
        result_7_11         : in std_logic; -- comming from test_logic if adder== 7,11 , result_7_11 =1
        result_2_3_12       : in std_logic;  -- comming from test_logic if adder== 2,3,12 , result_2_3_12 =1  
        en     : out std_logic; -- control signal to point_reg to store 
        en_counter     : out std_logic; -- control signal to counters to start count
        win     : out std_logic;    -- win flag 
        lose     : out std_logic   -- lose flag
    
    );
    end component;

-- internal signals 

signal enable_counter,enable_reg,test_logic_out_1,test_logic_out_2,comparator_out,win_internal,lose_internal  : std_logic; 
signal  count_1 , count_2 , adder_out , reg_out: std_logic_vector(3 downto 0);

begin
-- note : we make counter1 to start from 1 and counter2 to start from 2 to can have all ASM states in simulation wave 
counter1: counter
port map (
clk,
reset,
1, -- counter starts from 1 
enable_counter,
count_1
);

 counter2: counter
port map (
clk,
reset,
2, -- counter starts from 2 
enable_counter, -- control signal from control unit 
count_2
);

adder: addsub
port map (
'0', -- op = 0 to make add operation 
count_1, -- out of counter 1 
count_2, -- out of counter 2
adder_out -- adder out
);

register_1 :Point_Register 
port map(
clk,
reset,
enable_reg, -- control signal from control unit 
adder_out, -- adder out 
reg_out -- point_reg output 
);

comparator_1 : comparator 
port map(
adder_out,
reg_out,
comparator_out -- =1 if adder_out = reg_out
);

test_logic_1 : test_logic 
port map(
adder_out,
test_logic_out_1, -- test if adder_out =3,7 win 
test_logic_out_2 -- test if adder_out = 2,3,12 lose
);

-- explained above this module 
controlunit : controller
port map(
clk,
reset,
roll, 
comparator_out,
test_logic_out_1,
test_logic_out_2,
enable_reg,
enable_counter,
win_internal,
lose_internal 
);
-- assign internal signals to ports
win <= win_internal;
lose <= lose_internal;
end architecture rtl;
  