module ir
	#(	parameter		DATA_WIDTH = 4)
	(	input		wire	clk,
		input		wire	ena,
		input		wire	rst,
		input		wire	sclr,
		input		wire	[DATA_WIDTH-1:0]	d,
		output	wire	[DATA_WIDTH-4:0]	q
	);
	
	reg	[DATA_WIDTH-1:0] q1;
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			q1 <= {DATA_WIDTH{1'b0}};
		end else if (sclr) begin
			q1 <= {DATA_WIDTH{1'b0}};
		end else if (ena) begin
			q1 <= d;
		end
	end
	
	assign	q = {q1[7:3]};
	
endmodule