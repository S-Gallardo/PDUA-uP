module mux_4_1(
		input		wire	[1:0]	sel,
		input		wire			X00,
		input		wire			X01,
		input		wire			X10,
		input		wire			X11,
		output	wire			OUT
	);
	
	assign	OUT = (sel == 2'b01) ? X01 : ((sel == 2'b10) ? X10 : ((sel == 2'b11) ? X11 : X00)) ;
	
endmodule