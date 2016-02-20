/*
Bryan Bednarski
EE 371 Prof. Peckel Winter 2016
Project 3: Extending a Mircoprocessor

characterBitCountTop.v
This verilog module serves as a top-level module and testbench for the characterBitCount.v modules
which regulates the SR Clock Control and Character recieved signals.
*/

`include "characterBitCount.v"

module characterBitCountTop;
	// connect the two modules
	wire clk, reset, bitStream, enable;
	wire charRecieved, SRclk;
	
	// declare an instance of the module
	characterBitCount cbc(charReceived, SRclk, BIC, BSC, clk, reset, bitStream, enable);

	// declare an instance of the Tester module
	Tester myTester(charReceived, SRclk, BIC, BSC, clk, reset, bitStream, enable);
	
	// file specifications for gtkwave
	initial
		begin
		// dump file is for dumping all the variables in a simulation
		$dumpfile("characterBitCountFile.vcd");
		
		// dumps all the variables in module myDesign and below
		// but not modules instantiated in myDesign into the dump file.
		$dumpvars(1, characterBitCountTop);
		end

endmodule

module Tester (charReceived, SRclk, BIC, BSC, clk, reset, bitStream, enable);
	input charReceived, SRclk;
	output [3:0] BIC, BSC;
	output clk, reset, bitStream, enable;
	reg	[3:0] BIC, BSC;
	reg clk, reset, bitStream, enable;
	
	parameter delay = 20;
	
	initial begin 
		$display("\t\t charReceived SRclk \t clk reset bitStream, enable \t Q \t Time");
		$monitor("\t\t %b \t %b \t %b", charReceived, SRclk, clk, reset, bitStream, enable, $time);
	end
	
	always #delay clk = ~clk;
	
	initial begin

	
		$finish;
	end

endmodule