library IEEE;
use IEEE.std_logic_1164.all;

entity pc is
	port(
			new_pc: in std_ulogic_vector(31 downto 0);
			clock: in std_ulogic;
			pc_value: out std_ulogic_vector(31 downto 0)
		 );
end pc;



architecture behavioral of pc is
begin
	pc_process: process(clock)
	begin
		if (clock = '1') then
			pc_value <= new_pc;
		end if;
	end process pc_process;
end behavioral;
	
