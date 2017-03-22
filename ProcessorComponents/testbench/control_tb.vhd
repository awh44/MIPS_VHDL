library IEEE;
use IEEE.std_logic_1164.all;

entity control_tb is
end entity;

architecture behavioral of control_tb is
	component control is
		port(
				instruction: in std_ulogic_vector(31 downto 0);
				RegDst: out std_ulogic;
				Jump: out std_ulogic;
				Branch: out std_ulogic;
				MemRead: out std_ulogic;
				MemtoReg: out std_ulogic;
				ALUCont: out std_ulogic_vector(3 downto 0);
				MemWrite: out std_ulogic;
				ALUSrc: out std_ulogic;
				RegWrite: out std_ulogic
			 );
	end component;
	
	signal inst_in: std_ulogic_vector(31 downto 0);
	signal dst_out, jump_out, branch_out, mread_out, m2r_out, mwrite_out, src_out, rwrite_out: std_ulogic;
	signal cont_out: std_ulogic_vector(3 downto 0);

	begin
		TopLevelToBeTested: control
			port map(
						instruction => inst_in,
						RegDst => dst_out,
						Jump => jump_out,
						Branch => branch_out,
						MemRead => mread_out,
						MemtoReg => m2r_out,
						ALUCont => cont_out,
						MemWrite => mwrite_out,
						ALUSrc => src_out,
						RegWrite => rwrite_out
					 );
		inst_in <= "00000000000000000000000000100000" after 0 ns,
					  "00000000000000000000000000100010" after 30 ns,
					  "00000000000000000000000000100100" after 60 ns,
					  "00000000000000000000000000100101" after 90 ns,
					  "00000000000000000000000000101010" after 120 ns,
					  "10001100000000000000000000101010" after 150 ns,
					  "10101100000000000000000000100010" after 180 ns,
					  "00010000000000000000000000100100" after 210 ns,
					  "00001000000000000000000000100000" after 240 ns,
					  "00000000000000000000000000000000" after 270 ns;
end behavioral;
