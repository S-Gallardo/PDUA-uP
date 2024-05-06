module mdr
	#(	parameter		DATA_WIDTH = 4)
	(	input		wire	clk,
		input		wire	rst,
		input		wire	mdr_en,
		input		wire	mdr_alu_n,
		input		wire	[DATA_WIDTH-1:0]	bus_alu,
		input		wire	[DATA_WIDTH-1:0]	bus_data_in,
		output	wire	[DATA_WIDTH-1:0]	bus_c,
		output	wire	[DATA_WIDTH-1:0]	bus_data_out
	);
	
	//signal declaration
	reg	[DATA_WIDTH-1:0]	q1, q2;
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			q1 <= {DATA_WIDTH{1'b0}};
		end else if (mdr_en) begin
			q1 <= bus_data_in;
		end
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			q2 <= {DATA_WIDTH{1'b0}};
		end else if (mdr_en) begin
			q2 <= bus_alu;
		end
	end
	
	assign	bus_data_out = q2;

	assign	bus_c =	mdr_alu_n ? q1 : bus_alu ;
	
endmodule