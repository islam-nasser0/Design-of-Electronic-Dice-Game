# Design-of-Electronic-Dice-Game
We want to design an electronic dice game which has two counters that are used to simulate the roll of the dice. Each counter counts in the sequence from 1 to 6 which represent the six faces of dice. We have some rules to make decisions if the user wins or loses in the game and we will introduce these the rules following. 

## Block Digram 

![image](https://github.com/islam-nasser0/Design-of-Electronic-Dice-Game/assets/111699435/8b948815-e800-4f37-b41c-e71208ea012c)

### i prefer to add flowchart to the system rather than explain the functionalit with words that is more expressive 
## flowchart 

![image](https://github.com/islam-nasser0/Design-of-Electronic-Dice-Game/assets/111699435/bcd74650-f10e-4dc6-9a29-62d819a91d74)

### design phase : you can find the RTL in the repo 

### after finishing the design i start to write testbench and simulate the sysyem to check the functionality

## Simulation Wave 

![image](https://github.com/islam-nasser0/Design-of-Electronic-Dice-Game/assets/111699435/eaa13458-00a5-413c-bf69-365c4f002edf)

1- Reset

First, we make reset to the dice game before we start playing to reset counters and point register. 
•	The current state => reset_state 

•	The next state => not_yet_state  ,  this mean the added value of two counters not 7 or 11 or 2 or 3 or 12  
o	as result_7_11_reg =0 & result_2_3_12_reg =0

Note: I use negative edge reset

2- not_yet_state
•	I make reset <= 1 to transfer to the next state

•	I make the control unit give an enable signal to point register to store the value coming from adder to compare it with the next value coming from adder later. 

•	I make roll <=1 to give enable to counters and start count 
To get out of not_yet_state:
- value of adder == value stored in pointer counter (Win)
- value of the adder == 7 (Lose) 
What happens in simulation, the value of adder = value stored in pointer counter =3, so we transfer to win_state 

3-Win
•	We move to win_state and the win_output <=1 
•	The output of adder become 3 and that make me move to lose state and become win_output <=0

4- lose 
•	We move to lose_state and the lose_output <=1

## synthesis in Quartus 

![image](https://github.com/islam-nasser0/Design-of-Electronic-Dice-Game/assets/111699435/0b2df15d-d16c-40bb-8622-48ae9cb711bd)

## Summary 

first ,write RTL to the dice game in VHDL an make simulation to it to ensure the functionality of the design and make synthesis to it to verify that the RTL is synthesizable and can be configured to FPGA inshallah, I made flowchart also to make understanding of design easier.


