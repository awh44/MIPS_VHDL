library IEEE;
use IEEE.std_logic_1164.all;

entity tb_pc is
end entity;

architecture behavioral of tb_pc is
	component clock is
		port(
				clock: out std_ulogic
			 );
	end component;

	component pc is
		port(
				new_pc: in std_ulogic_vector(31 downto 0);
				clock: in std_ulogic;
				pc_value: out std_ulogic_vector(31 downto 0)
			);
	end component;
	signal clk_out: std_ulogic;
	signal pc_in, pc_out: std_ulogic_vector(31 downto 0);
begin
	TopLevelToBeTested: clock
		port map(
					clock => clk_out
				  );
	NextThingToBeTested: pc port map(
					new_pc => pc_in,
					clock => clk_out,
					pc_value => pc_out
				  );
	pc_in <= "00000000000000000000000000000000" after 0 ns,
				"00000000000000000000000000000001" after 10 ns,
				"00000000000000000000000000000010" after 20 ns,
				"00000000000000000000000000000011" after 30 ns,
				"00000000000000000000000000000100" after 40 ns,
				"00000000000000000000000000000101" after 50 ns,
				"00000000000000000000000000000110" after 60 ns,
				"00000000000000000000000000000111" after 70 ns;
end behavioral;
