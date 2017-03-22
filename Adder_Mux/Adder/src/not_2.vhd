library IEEE;
use IEEE.std_logic_1164.all;

entity not_2 is
	port (
		a: in STD_LOGIC;
		c: in STD_LOGIC
	);
end not_2;

architecture behavioral of not_2 is
begin
	c <= not a after 2 ns;
end behavioral;
