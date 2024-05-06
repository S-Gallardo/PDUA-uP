`timescale 1 ns/10 ps

module cu_tb();
	//Signals
	
	reg			clk_tb, rst_tb, C_tb, N_tb, P_tb, Z_tb;
	reg	[4:0]	opcode_tb;
	wire			iom_tb, intf_tb, enaf_tb, bank_wr_en_tb, ir_en_tb, ir_sclr_tb, mar_en_tb, mar_sclr_tb, wr_rdn_tb, mdr_alu_n_tb, mdr_en_tb;
	wire	[1:0]	shamt_tb;
	wire	[2:0]	selop_tb, busB_addr_tb, busC_addr_tb;
	
	control_unit	DUT (
		.clk(clk_tb),
		.rst(rst_tb),
		.C(C_tb),
		.N(N_tb),
		.P(P_tb),
		.Z(Z_tb),
		.opcode(opcode_tb),
		.iom(iom_tb),
		.intf(intf_tb),
		.enaf(enaf_tb),
		.selop(selop_tb),
		.shamt(shamt_tb),
		.bank_wr_en(bank_wr_en_tb),
		.busB_addr(busB_addr_tb),
		.busC_addr(busC_addr_tb),
		.ir_en(ir_en_tb),
		.ir_sclr(ir_sclr_tb),
		.mar_en(mar_en_tb),
		.mar_sclr(mar_sclr_tb),
		.wr_rdn(wr_rdn_tb),
		.mdr_alu_n(mdr_alu_n_tb),
		.mdr_en(mdr_en_tb)
	);
	
	//Clock generation
	initial	clk_tb = 0;
	always	#50	clk_tb = ~clk_tb;
	
	//Test signal generator
	initial
	begin
		
		rst_tb		= 1'b1;
		C_tb			= 1'b0;
		N_tb			= 1'b0;
		P_tb			= 1'b0;
		Z_tb 			= 1'b0;
		opcode_tb	= 5'b00000;
		#25
		rst_tb		= 1'b0;
		#275
		opcode_tb	= 5'b00001;
		#100
		opcode_tb	= 5'b00010;
		#100
		opcode_tb	= 5'b00011;
		#300
		opcode_tb	= 5'b00100;
		#300
		opcode_tb	= 5'b00101;
		#100
		opcode_tb	= 5'b00110;
		#300
		opcode_tb	= 5'b00111;
		#100
		opcode_tb	= 5'b01000;
		#100
		opcode_tb	= 5'b01001;
		#100
		opcode_tb	= 5'b01010;
		#300
		opcode_tb	= 5'b01011;
		#400
		opcode_tb	= 5'b01100;
		#400
		opcode_tb	= 5'b01101;
		#400
		opcode_tb	= 5'b01110;
		#800
		opcode_tb	= 5'b01111;
		#300
		opcode_tb	= 5'b10000;
		#500
		opcode_tb	= 5'b10001;
		#300
		opcode_tb	= 5'b10010;
		#400
		opcode_tb	= 5'b10011;
		#100
		opcode_tb	= 5'b10100;
		#100
		opcode_tb	= 5'b10101;
		#100
		opcode_tb	= 5'b10110;
		#100
		opcode_tb	= 5'b10111;
		#100
		opcode_tb	= 5'b11000;
		#100
		opcode_tb	= 5'b11001;
		#100
		
		//Stop simulation
		$stop;
	end
endmodule