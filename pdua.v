module pdua (
	input		wire			clk,
	input		wire			rst,
	input		wire	[7:0]	rd_data_pr,
	output	wire			wr_rdn_pr,
	output	wire	[7:0]	wr_data_pr,
	output	wire	[7:0]	addr_bus_pr,
	output	wire	[7:0]	PC_m,
	output	wire	[7:0]	SP_m,
	output	wire	[7:0]	DPTR_m,
	output	wire	[7:0]	A_m,
	output	wire	[7:0]	AVI_m,
	output	wire	[7:0]	TEMP_m,
	output	wire	[7:0]	CTE1_m,
	output	wire	[7:0]	ACC_m
);	
	
	wire				C, N, P, Z;
	wire				iom, intf, ir_sclr, mar_sclr, enaf, bank_wr_en, ir_en, mar_en, wr_rdn, ram_wr_rdn, mdr_alu_n, mdr_en;
	wire	[1:0]		shamt;
	wire	[2:0]		selop, busB_addr, busC_addr;
	wire	[4:0]		opcode;
	wire	[7:0]		ram_wr_data, ram_rd_data, ram_addr, bus_data_in, bus_data_out, addr_bus;
	
	control_unit	CU (
		.clk(clk),
		.rst(rst),
		.C(C),
		.N(N),
		.P(P),
		.Z(Z),
		.opcode(opcode),
		.iom(iom),
		.intf(intf),
		.enaf(enaf),
		.selop(selop),
		.shamt(shamt),
		.bank_wr_en(bank_wr_en),
		.busB_addr(busB_addr),
		.busC_addr(busC_addr),
		.ir_en(ir_en),
		.ir_sclr(ir_sclr),
		.mar_en(mar_en),
		.mar_sclr(mar_sclr),
		.wr_rdn(wr_rdn),
		.mdr_alu_n(mdr_alu_n),
		.mdr_en(mdr_en)
	);
	
	memory_system	#( .DATA_WIDTH(8)	) MEMSYS (
		.clk(clk),
		.rst(rst),
		.enaf(enaf),
		.selop(selop),
		.shamt(shamt),
		.bank_wr_en(bank_wr_en),
		.busB_addr(busB_addr),
		.busC_addr(busC_addr),
		.ir_en(ir_en),
		.ir_sclr(ir_sclr),
		.mar_en(mar_en),
		.mar_sclr(mar_sclr),
		.bus_data_in(bus_data_in),
		.mdr_alu_n(mdr_alu_n),
		.mdr_en(mdr_en),
		.bus_data_out(bus_data_out),
		.addr_bus(addr_bus),
		.opcode(opcode),
		.C(C),
		.N(N),
		.P(P),
		.Z(Z),
		.PC_m(PC_m),
		.SP_m(SP_m),
		.DPTR_m(DPTR_m),
		.A_m(A_m),
		.AVI_m(AVI_m),
		.TEMP_m(TEMP_m),
		.CTE1_m(CTE1_m),
		.ACC_m(ACC_m)
	);
	
	ram	#( .DATA_WIDTH(8)	)	Memory (
		.clk(clk),
		.wr_en(ram_wr_rdn),
		.addr(ram_addr),
		.w_data(ram_wr_data),
		.r_data(ram_rd_data)
	);
	
	mux_n	#( .DATA_WIDTH(8)	)	rd_data	(
		.sel(iom),
		.X0(ram_rd_data),
		.X1(rd_data_pr),
		.OUT(bus_data_in)
	);
	
	demux	wr_en	(
		.sel(iom),
		.IN(wr_rdn),
		.X0(ram_wr_rdn),
		.X1(wr_rdn_pr)
	);
	
	demux_n	#( .DATA_WIDTH(8)	)	wr_data	(
		.sel(iom),
		.IN(bus_data_out),
		.X0(ram_wr_data),
		.X1(wr_data_pr)
	);
	
	demux_n	#( .DATA_WIDTH(8)	)	addr	(
		.sel(iom),
		.IN(addr_bus),
		.X0(ram_addr),
		.X1(addr_bus_pr)
	);
	
endmodule 