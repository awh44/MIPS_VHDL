library IEEE;
use IEEE.std_logic_1164.all;

entity reg_file is
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
end reg_file;

architecture behavioral of reg_file is
type reg_array is array(0 to 31) of std_ulogic_vector (31 downto 0);
begin
	reg_process: process(clock)
	--theoretically, these registers can be initialized to any values (except
	--	register 0); they're just set to 0 for convienence
	variable registers: reg_array := (
		X"00000000",	--0
		X"00000000",	--1
		X"00000000",	--2
		X"00000000",	--3
		X"00000000",	--4
		X"00000000",	--5
		X"00000000",	--6
		X"00000000",	--7
		X"00000000",	--8
		X"00000000",	--9
		X"00000000",	--10
		X"00000000",	--11
		X"00000000",	--12
		X"00000000",	--13
		X"00000000",	--14
		X"00000000",	--15
		X"00000000",	--16
		X"00000000",	--17
		X"00000000",	--18
		X"00000000",	--19
		X"00000000",	--20
		X"00000000",	--21
		X"00000000",	--22
		X"00000000",	--23
		X"00000000",	--24
		X"00000000",	--25
		X"00000000",	--26
		X"00000000",	--27
		X"00000000",	--28
		X"00000000",	--29
		X"00000000",	--30
		X"00000000");	--31
	variable write_reg_num: integer;
	variable read1_reg_num: integer;
	variable read2_reg_num: integer;

	--copied from memory.vhd file
	function to_integer(X: std_ulogic_vector) return INTEGER is
	variable result: INTEGER;
	begin
		result := 0;
		for i in X'range loop
			result := result * 2;
			case X(i) is
				when '0' | 'L' => null;
				when '1' | 'H' => result := result + 1;
				when others => null;
			end case;
		end loop;
		return result;
	end to_integer;

	begin
		read1_reg_num := to_integer(read_reg_1);
		read2_reg_num := to_integer(read_reg_2);
		write_reg_num := to_integer(write_reg);
		if (clock = '1') then
			if (RegWrite = '1') then
				registers(write_reg_num) := write_data;
			end if;
			read_data_1 <= registers(read1_reg_num);
			read_data_2 <= registers(read2_reg_num);
		end if;
	end process reg_process;		
end behavioral;
