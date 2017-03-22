library IEEE;
use IEEE.std_logic_1164.all;

entity clock is
	port(
			clock: out std_ulogic
		 );
end clock;

architecture behavioral of clock is
signal clk: std_ulogic := '0';
begin
	clock <= clk;
	clk_process: process(clk)
	begin
		clk <= not clk after 30 ns;
	end process clk_process;
end behavioral;
	
