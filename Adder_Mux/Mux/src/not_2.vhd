library IEEE;
use IEEE.std_logic_1164.all;

entity not_2 is
	port (
		l: in STD_LOGIC;
		n: out STD_LOGIC
	);
end not_2;

architecture behavioral of not_2 is
begin
	n <= not l after 0 ns;
end behavioral;
