module register_bank
	#(	parameter	DATA_WIDTH = 4)
	(	input		wire	clk,
		input		wire	wr_en,
		input		wire	[2:0] w_addr, r_addr,
		input		wire	[DATA_WIDTH-1:0] w_data,
		output	wire	[DATA_WIDTH-1:0] busA, busB, PC, SP, DPTR, A, AVI, TEMP, CTE1
	);
	
	reg [DATA_WIDTH-1:0] array_reg [7:0];
	
	initial begin
		array_reg[0] = 8'b00000000;
		array_reg[1] = 8'b00000000;
		array_reg[2] = 8'b00000000;
		array_reg[3] = 8'b00000000;
		array_reg[4] = 8'b00000000;
		array_reg[5] = 8'b00000000;
		array_reg[6] = 8'b00000000;
		array_reg[7] = 8'b00000000;
	end
	
	always @(posedge clk) begin
		if (wr_en) begin 
			array_reg[w_addr] <= w_data;
		end
	end
	
	assign	busB	=	array_reg[r_addr];
	assign	busA	=	array_reg[3'b111];
	assign	PC		=	array_reg[3'b000];
	assign	SP		=	array_reg[3'b001];
	assign	DPTR	=	array_reg[3'b010];
	assign	A		=	array_reg[3'b011];
	assign	AVI	=	array_reg[3'b100];
	assign	TEMP	=	array_reg[3'b101];
	assign	CTE1	=	array_reg[3'b110];
	
endmodule