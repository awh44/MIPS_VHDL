library IEEE;
use IEEE.std_logic_1164.all;

entity mem_tb is
end entity;

architecture behavioral of mem_tb is
	component memory is
		port(
				address: in STD_LOGIC_VECTOR(31 downto 0);
				write_data: in STD_LOGIC_VECTOR(31 downto 0);
				MemWrite: in STD_LOGIC;
				MemRead: in STD_LOGIC;
				clock: in std_ulogic;
				read_data: out STD_LOGIC_VECTOR(31 downto 0)
			  );
	end component;

	signal address_in, data_in: std_logic_vector(31 downto 0);
	signal Write_in, Read_in: std_logic;
	signal clock_in: std_ulogic;
	signal data_out: std_logic_vector(31 downto 0);

	begin
		TopLevelToBeTested: memory
			port map(
						address => address_in,
						write_data => data_in,
						MemWrite => Write_in,
						MemRead => Read_in,
						clock => clock_in,
						read_data => data_out
					  );
		address_in <= "00000000000000000000000000000001" after 0 ns;
		data_in <= "01111111111111111111111111111111" after 0 ns; 
		Write_in <= '0' after 0 ns, '1' after 70 ns, '0' after 80 ns;
		Read_in <= '0' after 0 ns, '1' after 40 ns, '0' after 50 ns,
					  '1' after 100 ns, '0' after 110 ns;
		clock_in <= '0' after 0 ns, '1' after 15 ns, '0' after 30 ns,
						'1' after 45 ns, '0' after 60 ns, '1' after 75 ns,
						'0' after 90 ns, '1' after 105 ns, '0' after 120 ns;
end behavioral;
