module mux_n
	#(	parameter		DATA_WIDTH = 4)
	(	input		wire	sel,
		input		wire	[DATA_WIDTH-1:0]	X0,
		input		wire	[DATA_WIDTH-1:0]	X1,
		output	wire	[DATA_WIDTH-1:0]	OUT
	);
	
	assign	OUT	=	sel ?	X1	:	X0;
	
endmodule