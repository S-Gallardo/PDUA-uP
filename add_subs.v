module add_subs
	# ( parameter N = 4 )(
	input		wire	[N-1:0]	a,
	input		wire	[N-1:0]	b,
	input		wire				add_sub,
	output	wire	[N-1:0]	res,
	output	wire				cout
);
	
	wire [N-1:0] add_nsub_vector;
	wire [N-1:0] bxor;
	
	assign add_nsub_vector = {N{add_sub}};
	assign bxor = b ^ add_nsub_vector;
	
	nbit_adder #( .N(N) ) adder_inst (
	.a(a),
	.b(bxor),
	.cin(add_sub),
	.sum(res),
	.cout(cout) );

endmodule