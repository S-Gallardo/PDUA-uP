module ram
	#(	parameter		DATA_WIDTH = 4,
							ADDR_WIDTH = 8)
	(	input		wire	clk,
		input		wire	wr_en,
		input		wire	[ADDR_WIDTH-1:0]	addr,
		input		wire	[DATA_WIDTH-1:0]	w_data,
		output	wire	[DATA_WIDTH-1:0]	r_data
	);
	
	//signal declaration
	reg	[DATA_WIDTH-1:0]	ram [2**ADDR_WIDTH-1:0];
	reg	[DATA_WIDTH-1:0]	addr_reg;
	
	//write procedure
	always @(posedge clk, wr_en, addr) begin
		if (wr_en) begin
			ram[addr] <= w_data;
		end
		addr_reg <= addr;
	end
	
	//read
	assign r_data = ram[addr_reg];
	//assign r_data = ram[addr];
	
endmodule