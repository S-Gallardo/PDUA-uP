module nbit_adder
	#( parameter N = 4 )(
	input		wire	[N-1:0]	a,
	input		wire	[N-1:0]	b,
	input		wire				cin,
	output	wire	[N-1:0]	sum,
	output	wire				cout
);
	
	wire [N-1:0] carry;
	
	genvar i;
	generate
		for ( i = N-1; i >= 0; i = i-1 ) begin: adder_gen
			if ( i == 0 ) begin: bit_0
				full_adder U0 ( .a(a[i]), .b(b[i]), .cin(cin), .sum(sum[i]), .cout(carry[i]) );
			end else begin: bit_i
				full_adder UI ( .a(a[i]), .b(b[i]), .cin(carry[i-1]), .sum(sum[i]), .cout(carry[i]) );
			end
		end
	endgenerate
	
	assign cout = carry[N-1];

endmodule 