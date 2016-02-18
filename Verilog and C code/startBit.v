/*
Bryan Bednarski
EE 371 Prof. Peckel Winter 2016
Project 3: Extending a Mircoprocessor

startBit.v
This verilog module determines when to enable the Bit Sample Counter and 
Bit Indentification Counters for the Serial In Parallel Out Modules
*/

module startBit(enable, clk, reset, bitStream, BIC);
	output	reg	enable;
	input  		clk, reset, bitStream;
	input [3:0]	BIC;
	reg 		ns;
	
	// State encoding
	parameter DISABLE = 1'b0, ENABLE = 1'b1;
	
	always@(*) begin
		case (enable)
			DISABLE: if ((BIC == 4'b0000) && bitStream == 0) // Start bit of character (start bit)
						ns = ENABLE;
					else
						ns = DISABLE;
			ENABLE: if ((BIC == 4'b1001) && bitStream == 1) // Need to be halfway through 9th bit (stop bit)
						ns = DISABLE;
					else
						ns = ENABLE;
		endcase
	end
	
	always@(posedge clk) begin
		if (reset)
			enable <= DISABLE;
		else
			enable <= ns;
	end
endmodule
