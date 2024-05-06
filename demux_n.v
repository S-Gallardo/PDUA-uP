module demux_n
	#(	parameter		DATA_WIDTH = 4)
	(	input		wire	sel,
		input		wire	[DATA_WIDTH-1:0]	IN,
		output	wire	[DATA_WIDTH-1:0]	X0,
		output	wire	[DATA_WIDTH-1:0]	X1
	);
	
	assign	{X1,X0}		=	sel ?	{IN,{DATA_WIDTH{1'b0}}}		:	{{DATA_WIDTH{1'b0}},IN};
	
endmodule