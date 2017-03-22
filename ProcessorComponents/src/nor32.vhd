library IEEE;
use IEEE.std_logic_1164.all;

entity nor32 is
	port(
			a: in std_ulogic_vector(31 downto 0);
			o: out std_ulogic
		 );
end nor32;

architecture behavioral of nor32 is
	begin
		with a select
			o <= '1' when "00000000000000000000000000000000",
				  '0' when others;

end behavioral;
