library IEEE;
use IEEE.std_logic_1164.all;

entity tb_clock is
end entity;

architecture behavioral of tb_clock is
	component clock is
		port(
				clock: out std_ulogic
			 );
	end component;

	signal clk_out: std_ulogic;
begin
	TopLevelToBeTested: clock
		port map(
					clock => clk_out
				  );
end behavioral;

