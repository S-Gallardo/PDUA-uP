module demux(
		input		wire	sel,
		input		wire	IN,
		output	wire	X0,
		output	wire	X1
	);
	
	assign	{X1,X0}		=	sel ?	{IN,1'b0}	:	{1'b0,IN};
	
endmodule