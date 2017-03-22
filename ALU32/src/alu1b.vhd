-- behavioral model of the 1-bit ALU on page 234

library IEEE;
use IEEE.std_logic_1164.all;

entity alu1b is 
 port(a,b,CarryIn, b_invert, Less : in std_ulogic;
      Operation : in std_ulogic_vector (1 downto 0);
	 Result, CarryOut, Overflow, Set: out std_ulogic);
end alu1b;

architecture behavioral of alu1b is
constant gate_delay: Time:=0 ns;

signal carry_out, inter, over_out: std_ulogic;

begin
with Operation select
	inter <= (a and b) after gate_delay when "00",
				(a or b) after gate_delay when "01",
				(a xor (b xor b_invert) xor CarryIn) after gate_delay when "10",
				(a xor (b xor b_invert) xor CarryIn) after gate_delay when "11",
				'X' after gate_delay when others;
	carry_out <= ((a and (b xor b_invert)) or (a and CarryIn) or ((b xor b_invert) and CarryIn)) after gate_delay;
	CarryOut <= carry_out;
	over_out <= (CarryIn xor carry_out);
	Overflow <= over_out;
	Set <= (over_out xor inter);

with Operation select
	Result <= inter after gate_delay when "00",
				 inter after gate_delay when "01",
				 inter after gate_delay when "10",
				 Less after gate_delay when "11",
				 'X' after gate_delay when others;	

end behavioral;
