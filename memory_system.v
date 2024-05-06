module memory_system
	# ( parameter DATA_WIDTH = 8 )(
	input		wire							clk,
	input		wire							rst,
	input		wire							ir_sclr,
	input		wire							mar_sclr,
	input		wire	[2:0]					busB_addr,
	input		wire	[2:0]					busC_addr,
	input		wire	[2:0]					selop,
	input		wire	[1:0]					shamt,
	input		wire							mdr_alu_n,
	input		wire							enaf,
	input		wire							ir_en,
	input		wire							mar_en,
	input		wire							mdr_en,
	input		wire							bank_wr_en,
	input		wire	[DATA_WIDTH-1:0]	bus_data_in,
	output	wire	[DATA_WIDTH-1:0]	PC_m, SP_m, DPTR_m, A_m, AVI_m, TEMP_m, CTE1_m, ACC_m,
	output	wire	[DATA_WIDTH-4:0]	opcode,
	output	wire	[DATA_WIDTH-1:0]	addr_bus,
	output	wire	[DATA_WIDTH-1:0]	bus_data_out,
	output	wire							C,
	output	wire							N,
	output	wire							P,
	output	wire							Z
);
	
	wire	[DATA_WIDTH-1:0]	busA, busB, busC, bus_alu;

	assign	ACC_m			= busA;
	
	mdr	#( .DATA_WIDTH(DATA_WIDTH)	) MDR (
		.clk(clk),
		.rst(rst),
		.mdr_en(mdr_en),
		.mdr_alu_n(mdr_alu_n),
		.bus_alu(bus_alu),
		.bus_data_in(bus_data_in),
		.bus_c(busC),
		.bus_data_out(bus_data_out)
	);
	
	register_bank	#( .DATA_WIDTH(DATA_WIDTH)	) RB (
		.clk(clk),
		.wr_en(bank_wr_en),
		.w_addr(busC_addr),
		.r_addr(busB_addr),
		.w_data(busC),
		.busA(busA),
		.busB(busB),
		.PC(PC_m),
		.SP(SP_m),
		.DPTR(DPTR_m),
		.A(A_m),
		.AVI(AVI_m),
		.TEMP(TEMP_m),
		.CTE1(CTE1_m)
	);
	
	ir	#( .DATA_WIDTH(DATA_WIDTH)	) IR (
		.clk(~clk),
		.rst(rst),
		.sclr(ir_sclr),
		.ena(ir_en),
		.d(busC),
		.q(opcode)
	);
	
	mar	#( .DATA_WIDTH(DATA_WIDTH)	) MAR (
		.clk(clk),
		.rst(rst),
		.sclr(mar_sclr),
		.ena(mar_en),
		.d(busC),
		.q(addr_bus)
	);
	
	alu	#( .MAX_WIDTH(DATA_WIDTH)	) ALU (
		.clk(clk),
		.rst(rst),
		.busA(busA),
		.busB(busB),
		.selop(selop),
		.shamt(shamt),
		.enaf(enaf),
		.busC(bus_alu),
		.C(C),
		.N(N),
		.P(P),
		.Z(Z)
	);
	
endmodule 