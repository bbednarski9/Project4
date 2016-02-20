/*
Bryan Bednarski
EE 371 Prof. Peckol Winter 2016
Project 3: Extending a Microprocessor

characterBitCount.v
This verilog module combines the functionality of the Bit Identification Count, 
Bit Sample Count and S/R Clock Control top-level modules
*/

module characterBitCount(charReceived, SRclk, BIC, BSC, clk, reset, bitStream, enable);
	
	input clk, reset, bitStream, enable;
	output reg charReceived, SRclk;
	output [3:0] BIC, BSC;

	reg [7:0] combinedCounter;
	
	assign BIC = combinedCounter[7:4];
	assign BSC = combinedCounter[3:0];
	
	always@(posedge clk)
		begin
			if (reset)
				begin
					charReceived = 1'b0;
					SRclk = 1'b0;
					combinedCounter = 8'b0;
				end
			else if (enable)
				begin
					charReceived = 1'b0;
					combinedCounter = combinedCounter + 8'b00000001;
					if (4'b0111 == BSC) // Middle of the bit
						SRclk = 1'b1;
					else // (4'b0111 != BSC)
						SRclk = 1'b0;
				end
			else // !enable
				begin
					SRclk = 1'b0;
					if (4'b1001 == BIC)
						begin
							combinedCounter = 8'b0;
							charReceived = 1'b1;
						end
					else // 4'b1001 != BIC
						begin
							charReceived = 1'b0;
							combinedCounter = combinedCounter;
						end			
				end
		end
endmodule