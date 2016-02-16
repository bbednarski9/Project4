module PISO(clk, reset, data_in, load_n, data_out); // Parallel in -> Serial Out

	input 		clk, reset, load_n;
	input [7:0] data_in;
	output 		data_out;

	reg [7:0] 	Q_out;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			Q_out <= 8'b00000000;
		end
		else if (load_n) begin   // shift
			Q_out[0] <= Q_out[1];
			Q_out[1] <= Q_out[2];
			Q_out[2] <= Q_out[3];
			Q_out[3] <= Q_out[4];
			Q_out[4] <= Q_out[5];
			Q_out[5] <= Q_out[6];
			Q_out[6] <= Q_out[7];
			Q_out[7] <= 1'b1;
		end
		else begin				// load
			Q_out <= data_in;
		end
	end

	assign data_out = Q_out[0]; 

endmodule