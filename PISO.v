/*	Joanna Mazer
	EE 371 Peckol Winter 2016
	Project 3: Extending a Microprocessor
	PISO.v
	
	This verilog module functions as a parallel in, serial out
	shift register. The 10 bit data will be loaded into the shift
	register, then when the load signal is not enabled, the data
	will be fed to the output one bit at a time on the posedge 
	of the clock signal.
*/

module PISO(clk, reset, data_in, load_n, data_out); // Parallel in -> Serial Out (10 bits)

	input 		clk, reset, load_n;
	input [9:0] data_in;
	output 		data_out;

	reg [9:0] 	Q_out;
	reg 		serial_out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			Q_out <= 10'b0000000000;
		end
		else if (load_n) begin   // shift
			serial_out <= Q_out[0];
			Q_out[0] <= Q_out[1];
			Q_out[1] <= Q_out[2];
			Q_out[2] <= Q_out[3];
			Q_out[3] <= Q_out[4];
			Q_out[4] <= Q_out[5];
			Q_out[5] <= Q_out[6];
			Q_out[6] <= Q_out[7];
			Q_out[7] <= Q_out[8];
			Q_out[8] <= Q_out[9];
			Q_out[9] <= 1'b1;
		end
		else begin				// load
			Q_out <= data_in;
		end
	end

	assign data_out = serial_out; 

endmodule