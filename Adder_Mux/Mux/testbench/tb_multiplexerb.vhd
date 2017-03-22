library IEEE;
use IEEE.std_logic_1164.all;

entity tb_multiplexerb is
end entity;

architecture behavioral of tb_multiplexerb is

component multiplexerb is
		port(
				i0: in STD_LOGIC;
				i1: in STD_LOGIC;
				i2: in STD_LOGIC;
				i3: in STD_LOGIC;
				s0: in STD_LOGIC;
				s1: in STD_LOGIC;
				output: out STD_LOGIC
			 );
end component;

signal i0_in, i1_in, i2_in, i3_in, s0_in, s1_in, output_out: STD_LOGIC;

begin
	
	TopLevelToBeTested: multiplexerb
		port map(
			i0 => i0_in,
			i1 => i1_in,
			i2 => i2_in,
			i3 => i3_in,
			s0 => s0_in,
			s1 => s1_in,
			output => output_out
		);

		i0_in <= '0' after 0 ns, '1' after 15 ns;
		i1_in <= '0' after 0 ns, '1' after 45 ns;
		i2_in <= '0' after 0 ns, '1' after 75 ns;
		i3_in <= '0' after 0 ns, '1' after 105 ns;
		s0_in <= '0' after 0 ns, '1' after 30 ns, '0' after 60 ns, '1' after
90 ns, '0' after 120 ns;
		s1_in <= '0' after 0 ns, '1' after 60 ns, '0' after 120 ns;
end behavioral;
