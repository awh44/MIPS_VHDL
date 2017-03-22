library IEEE;
use IEEE.std_logic_1164.all;

entity control is
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
end control;

architecture behavioral of control is
signal opcode, funct: std_ulogic_vector(5 downto 0);
begin
	opcode <= instruction(31 downto 26);
	funct <= instruction(5 downto 0);

	RegDst <= '1' when opcode = "000000" else
				 '0' when opcode = "100011" else
				 'X';

	Jump <= '1' when opcode = "000010" else
			  '0';

	Branch <= '1' when opcode = "000100" else
				 '0';

	MemRead <= '1' when opcode = "100011" else
				  '0';

	MemtoReg <= '0' when opcode = "000000" else
					'1' when opcode = "100011" else
					'X';

	ALUCont <= "0010" when opcode = "100011" else
				  "0010" when opcode = "101011" else
				  "0110" when opcode = "000100" else
				  "0010" when (opcode = "000000" and funct = "100000") else
				  "0110" when (opcode = "000000" and funct = "100010") else
				  "0000" when (opcode = "000000" and funct = "100100") else
				  "0001" when (opcode = "000000" and funct = "100101") else
				  "0111" when (opcode = "000000" and funct = "101010") else
				  "XXXX";
	
	MemWrite <= '1' when opcode = "101011" else
					'0';

	ALUSrc <= '0' when (opcode = "000000" or opcode = "000100") else
				 '1' when (opcode = "100011" or opcode = "101011") else
				 'X';

	RegWrite <= '1' when (opcode = "000000" or opcode = "100011") else
					'0';
end behavioral;
	
