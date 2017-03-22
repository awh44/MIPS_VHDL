library IEEE;
use IEEE.std_logic_1164.all;

entity multiplexerb is
		port(
				i0: in STD_LOGIC;
				i1: in STD_LOGIC;
				i2: in STD_LOGIC;
				i3: in STD_LOGIC;
				s0: in STD_LOGIC;
				s1: in STD_LOGIC;
				output: out STD_LOGIC
		);
end multiplexerb;

architecture concurrent_behavior of multiplexerb is
begin
	output <= ((not s1) and (not s0) and i0) or ((not s1) and s0 and i1) or (s1
and (not s0) and i2) or (s1 and s0 and i3);
end concurrent_behavior;
