library IEEE;
use IEEE.std_logic_1164.all;

entity memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead: in STD_LOGIC;
		clock: in std_ulogic;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
end memory;

architecture behavioral of memory is	  

type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);

begin
  -- <<enter your statements here>>								
	mem_process: process(clock)
	--theoretically, there could be up to 2^32 /4 memory locations because
	-- the memory unit receives 32 bits from the ALU, and each memory
	-- location is seperated by 4. However, this is unfeasible, and, in
	-- reality, the program might not have access to all this memory anyway.
	-- Therefore 32 was chosen as a reasonable number of memory locations
	variable data_mem: mem_array := (
    	X"00000002", -- initialize data memory
    	X"0000000A", --1
    	X"00000000", --2
    	X"00000000", --3
    	X"00000000", --4
    	X"00000000", --5
		X"00000000", --6
 		X"00000000", --7
		X"00000000", --8
		X"00000000", --9
		X"00000000", --10
		X"00000000", --11
		X"00000000", --12
		X"00000000", --13
		X"00000000", --14
		X"00000000", --15
		X"00000000", --16
		X"00000000", --17
		X"00000000", --18
		X"00000000", --19
		X"00000000", --20
		X"00000000", --21
		X"00000000", --22
		X"00000000", --23
		X"00000000", --24
		X"00000000", --25
		X"00000000", --26
		X"00000000", --27
		X"00000000", --28
		X"00000000", --29
		X"00000000", --30
		X"00000000"  --31
	);
	variable addr: integer;  
  
	function to_integer(X: STD_LOGIC_VECTOR) return INTEGER is
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
	if (clock = '1') then
		addr := to_integer(address);
		--because addresses come in as multiples of four, but the memory array
		-- is directly sequentiali, have to divide
		addr := addr / 4;
		if (MemWrite = '1') then
			data_mem(addr) := write_data;
		elsif (MemRead = '1') then
			read_data <= data_mem(addr); --after 10 ns;
		end if;
	end if;
	end process mem_process;
end behavioral;
