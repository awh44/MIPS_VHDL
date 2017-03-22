library IEEE;
use IEEE.std_logic_1164.all;

entity reg_tb is
end entity;

architecture behavioral of reg_tb is
	component reg_file is
		port(
				read_reg_1: in std_ulogic_vector(4 downto 0);
				read_reg_2: in std_ulogic_vector(4 downto 0);
				write_reg: in std_ulogic_vector(4 downto 0);
				write_data: in std_ulogic_vector(31 downto 0);
				RegWrite: in std_ulogic;
				clock: in std_ulogic;
				read_data_1: out std_ulogic_vector(31 downto 0);
				read_data_2: out std_ulogic_vector(31 downto 0)
			 );
	end component;

	signal read1_in, read2_in, write_in: std_ulogic_vector(4 downto 0);
	signal data_in: std_ulogic_vector(31 downto 0);
	signal reg_write_in, clock_in: std_ulogic;
	signal data1_out, data2_out: std_ulogic_vector(31 downto 0);

	begin
		TopLevelToBeTested: reg_file
			port map(
						read_reg_1 => read1_in,
						read_reg_2 => read2_in,
						write_reg => write_in,
						write_data => data_in,
						RegWrite => reg_write_in,
						clock => clock_in,
						read_data_1 => data1_out,
						read_data_2 => data2_out
					  );
		read1_in <= "00000" after 0 ns, "00010" after 30 ns;
		read2_in <= "00001" after 0 ns;
		write_in <= "00001" after 0 ns;
		data_in <=  "00000000000000000000000000001000" after 0 ns;
		reg_write_in <= '0' after 0 ns, '1' after 40 ns, '0' after 50 ns;
		clock_in <= '0' after 0 ns, '1' after 15 ns, '0' after 30 ns,
						'1' after 45 ns, '0' after 60 ns, '1' after 75 ns,
						'0' after 90 ns;
end behavioral;
