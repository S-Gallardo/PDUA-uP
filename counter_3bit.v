module counter_3bit (
	input		wire			clk,
	input		wire			rst,
	input		wire			ena,
	input		wire			sclr,
	input		wire	[2:0]	a,
	output	wire	[2:0]	count
);	
	
	reg	[2:0]	q;
	wire	[2:0]	sum;
	
	nbit_adder #( .N(3) ) adder_inst (
		.a(a),
		.b(count),
		.cin(1'b0),
		.sum(sum)
	);
	
	always @(negedge clk, posedge rst) begin
		if (rst) begin
			q <= 3'b000;
		end else if (sclr) begin
			q <= 3'b000;
		end else if (ena) begin
			q <= sum;
		end
	end
	
	assign	count = q;
	
endmodule 