module receiving (clk, reset, data_in, data_out);

	input clk, reset, data_in;
	output [9:0] data_out;

	reg sRClk, buffer_out, enable;
	reg [9:0] SR_out;

	serial_buffer 	input_buffer 	(.clk, .reset, .data_in, .data_out(buffer_out));
	SIPO 			shift_register 	(.data_out(SR_out), .clk(sRClk), .reset, .data_in(buffer_out));
	startBit		start_bit		(.enable, .clk, .reset, .bitStream(buffer_out), BIC); // still working on this part

endmodule
