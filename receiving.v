/*	Joanna Mazer
	EE 371 Peckol Winter 2016
	Project 3: Extending a Microprocessor
	receiving.v
	
	This module combines the sub-modules SIPO.v, startBit.v, 
	characterBitCount.v and serial_buffer.v to simplify the
	inputs and outputs of the system.
*/

module receiving (clk, reset, data_in, data_out);

	input clk, reset, data_in;
	output [9:0] data_out;
	output reg charReceived;

	reg buffer_out, enable;
	reg [9:0] SR_out;
	reg [3:0] bitID, bitSample;

	serial_buffer 	input_buffer 	(.clk, .reset, .data_in, .data_out(buffer_out));
	SIPO 			shift_register 	(.data_out(SR_out), .clk(SRclk), .reset, .data_in(buffer_out));
	startBit		start_bit		(.enable, .clk, .reset, .bitStream(buffer_out), .BIC(bitID), .BSC(bitSample); 
	characterBitCount	cBitCount 	(.charReceived, .SRclk, .BIC(bitID), .BSC(bitSample), .clk, .reset, .bitStream(buffer_out), .enable);

	assign data_out = SR_out;

endmodule
