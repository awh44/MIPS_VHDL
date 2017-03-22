library IEEE;
use IEEE.std_logic_1164.all;

entity add_tb_alu32s is
end entity;

architecture behavioral of add_tb_alu32s is
	component alu32s is
		port(
				a: in std_ulogic_vector(31 downto 0);
				b: in std_ulogic_vector(31 downto 0);
				ALUOp: in std_ulogic_vector(3 downto 0);
				Result: out std_ulogic_vector (31 downto 0);
				CarryOut: out std_ulogic;
				Overflow: out std_ulogic;
				Zero: out std_ulogic
			  );
	end component;

	signal a_in, b_in: std_ulogic_vector(31 downto 0);
	signal op_in: std_ulogic_vector(3 downto 0);
	signal result_out: std_ulogic_vector(31 downto 0);
	signal carry_out, overflow_out, zero_out: std_ulogic;

	begin
		TopLevelToBeTested: alu32s
			port map(
						a => a_in,
						b => b_in,
						ALUOp => op_in,
						Result => result_out,
						CarryOut => carry_out,
						Overflow => overflow_out,
						Zero => zero_out
					  );

	a_in <= "00000000000000000000000000000000" after 0 ns,
			  "00000000000000000000000000000001" after 30 ns,
			  "01111111111111111111111111111111" after 60 ns,
			  "11111111111111111111111111111111" after 120 ns,
			  "11111111111111111111111111111110" after 210 ns;
	
	b_in <= "00000000000000000000000000000000" after 0 ns,
			  "00000000000000000000000000000011" after 30 ns,
			  "10000000000000000000000000000001" after 90 ns,
			  "10000000000000000000000000000000" after 150 ns,
			  "01111111111111111111111111111111" after 180 ns;
 
	op_in <= "0010" after 0 ns, "0110" after 15 ns, "0010" after 30 ns,
				"0110" after 45 ns, "0010" after 60 ns, "0110" after 75 ns,
				"0010" after 90 ns, "0110" after 105 ns, "0010" after 120 ns,
				"0110" after 135 ns, "0010" after 150 ns, "0110" after 165 ns,
				"0010" after 180 ns, "0110" after 195 ns, "0010" after 210 ns,
				"0110" after 225 ns, "0010" after 240 ns;
end behavioral;
