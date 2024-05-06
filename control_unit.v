module control_unit (
	input		wire			clk,
	input		wire			rst,
	input		wire			C, N, P, Z,
	input		wire	[4:0]	opcode,
	output	wire			intf,
	output	wire			iom,
	output	wire			enaf,
	output	wire	[2:0]	selop,
	output	wire	[1:0]	shamt,
	output	wire			bank_wr_en,
	output	wire	[2:0]	busB_addr,
	output	wire	[2:0]	busC_addr,
	output	wire			ir_en,
	output	wire			ir_sclr,
	output	wire			mar_en,
	output	wire			mar_sclr,
	output	wire			wr_rdn,
	output	wire			mdr_alu_n,
	output	wire			mdr_en
);	
	
	wire						subr_sclr, flag;
	wire	[1:0]				flag_select;
	wire	[2:0]				jmp, jmp_lines, count;
	wire	[7:0]				rom_addr;
	wire	[26:0]			sub_routine;
	
	//assign	flag 	=	(flag_select == 2'b01) ? Z	: ((flag_select == 2'b10) ? N	: ((flag_select == 2'b11) ? C	: 1'b1)) ;
	//assign	jmp	=	flag ? 3'b001	:	jmp_lines;
	
	mux_4_1	flag_mux	(
		.sel(flag_select),
		.X00(1'b1),
		.X01(Z),
		.X10(N),
		.X11(C),
		.OUT(flag)
	);
	
	mux_n	#( .DATA_WIDTH(3)	)	jmp_mux	(
		.sel(flag),
		.X0(jmp_lines),
		.X1(3'b001),
		.OUT(jmp)
	);
	
	counter_3bit	routine_count (
		.clk(clk),
		.rst(rst),
		.ena(1'b1),
		.sclr(subr_sclr),
		.a(jmp),
		.count(count)
	);
	
	assign	rom_addr	=	{opcode, count};
	
	rom	instruction_set (
		.addr(rom_addr),
		.data(sub_routine)
	);
	
	assign	iom			=	{sub_routine[26]};
	assign	intf			=	{sub_routine[25]};
	assign	enaf			=	{sub_routine[24]};
	assign	selop			=	{sub_routine[23:21]};
	assign	shamt			=	{sub_routine[20:19]};
	assign	bank_wr_en	=	{sub_routine[18]};
	assign	busB_addr	=	{sub_routine[17:15]};
	assign	busC_addr	=	{sub_routine[14:12]};
	assign	ir_en			=	{sub_routine[11]};
	assign	ir_sclr		=	{sub_routine[10]};
	assign	mar_en		=	{sub_routine[9]};
	assign	mar_sclr		=	{sub_routine[8]};
	assign	wr_rdn		=	{sub_routine[7]};
	assign	mdr_alu_n	=	{sub_routine[6]};
	assign	mdr_en		=	{sub_routine[5]};
	assign	subr_sclr	=	{sub_routine[4]};
	assign	flag_select	=	{sub_routine[3:2]};
	assign	jmp_lines	=	{1'b0, sub_routine[1:0]};
	
endmodule 