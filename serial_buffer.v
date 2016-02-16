module serial_buffer (clk, reset, data_in, data_out);
	input 	clk, reset, data_in;
	output 	data_out; 

	reg Q;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			Q <= 1'b0;			
		end
		else begin
			Q <= data_in;
		end
	end

	assign data_out = Q; 

endmodule 