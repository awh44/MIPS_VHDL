library IEEE;
use IEEE.std_logic_1164.all;

entity alu32s is
	--32 bit inputs; 32 bit output
	--ALUOp determines operation:
	--	-0000 - AND
	--	-0001 - OR
	--	-0010	- add
	--	-0110	- sub
	-- -0111 - slt
	port(a: in std_ulogic_vector(31 downto 0);
		  b: in std_ulogic_vector(31 downto 0);
		  ALUOp: in std_ulogic_vector(3 downto 0);
		  Result: out std_ulogic_vector(31 downto 0);
		  CarryOut: out std_ulogic;
		  Overflow: out std_ulogic;
		  Zero: out std_ulogic
		 );
end alu32s;

architecture structural of alu32s is

	component alu1b
		port(a: in std_ulogic;
			  b: in std_ulogic;
			  CarryIn: in std_ulogic;
			  b_invert: in std_ulogic;
			  Less: in std_ulogic;
			  Operation: in std_ulogic_vector (1 downto 0);
			  Result: out std_ulogic;
			  CarryOut: out std_ulogic;
			  Overflow: out std_ulogic;
			  Set: out std_ulogic
			 );
	end component;

	component nor32
		port(a: in std_ulogic_vector(31 downto 0);
			  o: out std_ulogic
			 );
	end component;

	signal result_out: std_ulogic_vector(31 downto 0);
	signal set_out: std_ulogic_vector(31 downto 0);
	signal carry_out: std_ulogic_vector(31 downto 0);
	signal overflow_out: std_ulogic_vector(31 downto 0);

	begin
		--connect a to the lsb in a(); do the same for b and Result, as well
		-- as carry_out, overflow_out, and set_out
		--the CarryIn is 1 only when subtraction occurs; subtraction only
		-- occurs when ALUOp(2) is 1, so connect CarryIn directly to it
		--do the same for b_invert, because it's also asserted only when
		-- subtraction occurs
		--Less has to be connected to the Set output of the most significant
		-- ALU to know when it should be asserted
		--connect the final two bits of ALUOp to the corresponding 1-bit op
		-- lines
		ALU0: alu1b port map(a => a(0),
									b => b(0),
									CarryIn => ALUOp(2),
									b_invert => ALUOp(2),
									Less => set_out(31),
									Operation(1) => ALUOp(1),
									Operation(0) => ALUOp(0),
									Result => result_out(0),
									CarryOut => carry_out(0),
									Overflow => overflow_out(0),
									Set => set_out(0)
								  );
		--for the next 30 ALUs, connect a, b, and Result to the
		--	corresponding vector element; do the same for CarryOout, Overflow,
		-- and Set
		--connect the CarryIn to the previous carry_out
		--Less is always 0, because the output of the ALU for slt is always
		-- 0 or 1, which both require all bits but the least sig be 0
		--Rest follow same logic as above
		GEN: for i in 1 to 30 generate begin
			ALU1: alu1b port map(a => a(i),
										b => b(i),
										CarryIn => carry_out(i - 1),
										b_invert => ALUOp(2),
										Less => '0',
										Operation(1) => ALUOp(1),
										Operation(0) => ALUOp(0),
										Result => result_out(i),
										CarryOut => carry_out(i),
										Overflow => overflow_out(i),
										Set => set_out(i)
									  );
		end generate;
		
		--same logic as above for all inputs/outputs
		ALU31: alu1b port map(a => a(31),
									 b => b(31),
									 CarryIn => carry_out(30),
									 b_invert => ALUOp(2),
									 Less => '0',
									 Operation(1) => ALUOp(1),
									 Operation(0) => ALUOp(0),
									 Result => result_out(31),
									 CarryOut => carry_out(31),
									 Overflow => overflow_out(31),
									 Set => set_out(31)
									);
		--map from the vector to the actual output
		CO: CarryOut <= carry_out(31);
		OV: Overflow <= overflow_out(31);
		--nor all 32 bits of the result, and map that result to Zero (so that
		-- Zero is only asserted if all 32 bits are '0')
		ZO: nor32 port map(a => result_out,
								 o => Zero
								);
		--vector to actual output
		RS: Result <= result_out;
end structural;

