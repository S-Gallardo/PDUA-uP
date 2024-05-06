module processing_unit 
	# ( parameter N = 8 )(
	input		wire	[N-1:0]	dataa,
	input		wire	[N-1:0]	datab,
	input		wire	[2:0]		selop,
	output	reg	[N-1:0]	res,
	output	wire				cout
);
	
	wire [N-1:0] zeros;
	wire [N-1:0] not_b;	
	wire [N-1:0] a_and_b;
	wire [N-1:0] a_or_b;
	wire [N-1:0] a_xor_b;
	wire [N-1:0] a_plus_b;
	wire [N-1:0] b_plus_1;
	wire [N-1:0] neg_b;
	wire c_add, c_plus1, c_negB;
	
	assign zeros	= {N{1'b0}};
	
	assign not_b	= ~datab;
	assign a_and_b	= dataa & datab;
	assign a_or_b	= dataa | datab;
	assign a_xor_b	= dataa ^ datab;
	
	add_subs #( .N(N) ) AplusB (
		.a(dataa),
		.b(datab),
		.add_sub(1'b0),
		.res(a_plus_b),
		.cout(c_add)
	);
	
	add_subs #( .N(N) ) Bplus1 (
		.a({zeros[N-1:1], 1'b1}),
		.b(datab),
		.add_sub(1'b0),
		.res(b_plus_1),
		.cout(c_plus1)
		);
	
	add_subs #( .N(N) ) negB   (
		.a(zeros),
		.b(datab),
		.add_sub(1'b1),
		.res(neg_b),
		.cout(c_negB)
	);
	
	always @(*) begin
		case (selop)
			3'b000:	res = datab;
			3'b001:	res = not_b;
			3'b010:	res = a_and_b;
			3'b011:	res = a_or_b;
			3'b100:	res = a_xor_b;
			3'b101:	res = a_plus_b;
			3'b110:	res = b_plus_1;
			default: res = neg_b;
		endcase
	end
	
	assign cout =	(selop[1:0] == 2'b01) ? c_add		:
						(selop[1:0] == 2'b10) ? c_plus1	:
						(selop[1:0] == 2'b11) ? c_negB	: 1'b0 ;

endmodule 