library IEEE;
use IEEE.std_logic_1164.all;

entity multiplexers is
	port(
		i0: in STD_LOGIC;
		i1: in STD_LOGIC;
		i2: in STD_LOGIC;
		i3: in STD_LOGIC;
		s0: in STD_LOGIC;
		s1: in STD_LOGIC;
		output: out STD_LOGIC
	);
end multiplexers;

architecture structural of multiplexers is

	component and_3
		port(a, b, c: in std_logic;
			  d: out std_logic);
	end component;

	component not_2
		port(l: in std_logic;
			  n: out std_logic);
	end component;

	component or_4
		port(a, b, c, d: in std_logic;
			  e: out std_logic);
	end component;
	
	signal s0_n, s1_n: STD_LOGIC;
	signal n0, n1, n2, n3: STD_LOGIC;

begin	
	NOT_S0: not_2 port map(l => s0, n => s0_n);
	NOT_S1: not_2 port map(l => s1, n => s1_n);
	I0_SEL: and_3 port map(a => s1_n, b => s0_n, c => i0, d => n0);
	I1_SEL: and_3 port map(a => s1_n, b => s0, c => i1, d => n1);
	I2_SEL: and_3 port map(a => s1, b => s0_n, c => i2, d => n2);
	I3_SEL: and_3 port map(a => s1, b => s0, c => i3, d => n3);
	SELOUT: or_4  port map(a => n0, b => n1, c => n2, d => n3, e => output);
end structural;
