module alu
	# ( parameter MAX_WIDTH = 8 )(
	input		wire							clk,
	input		wire							rst,
	input		wire	[MAX_WIDTH-1:0]	busA,
	input		wire	[MAX_WIDTH-1:0]	busB,
	input		wire	[2:0]					selop,
	input		wire	[1:0]					shamt,
	input		wire							enaf,
	output	wire	[MAX_WIDTH-1:0]	busC,
	output	wire							C,
	output	wire							N,
	output	wire							P,
	output	wire							Z
);
	
	wire	carry;
	wire	[MAX_WIDTH-1:0]	dataa;
	
	processing_unit	#( .N(MAX_WIDTH) ) procUnit (
		.dataa(busA),
		.datab(busB),
		.selop(selop),
		.res(dataa),
		.cout(carry)
	);
	
	shift_unit	#( .N(MAX_WIDTH) ) shiftUnit (
		.shamt(shamt),
		.dataa(dataa),
		.dataout(busC)
	);
	
	flag_register	#( .MAX_WIDTH(MAX_WIDTH) ) flagReg (
		.clk(clk),
		.rst(rst),
		.enaf(enaf),
		.dataa(dataa),
		.carry(carry),
		.C(C),
		.N(N),
		.Z(Z),
		.P(P)
	);
	
endmodule 