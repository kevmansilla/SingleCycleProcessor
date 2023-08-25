module flopr_tb();
	parameter N = 64;
	logic clk, reset;
	logic [N-1:0] d,q,qexpected;
	logic [3:0] vectornum, errors;
	logic [N-1:0] testvectors [0:9] = '{
		64'd1,
		64'd2,
		64'd3,
		64'd4,
		64'd5,
		64'd6,
		64'd7,
		64'd8,
		64'd9,
		64'd10};
	logic [N-1:0] testvectorsout [0:9] = '{
		64'b0,
		64'b0,
		64'b0,
		64'b0,
		64'b0,
		64'd6,
		64'd7,
		64'd8,
		64'd9,
		64'd10};
		
	// instanciar el modulo
	flopr #(N) flop(clk, reset, d, q);
	
	// generar la señal de clock
	always
		begin
			clk = 1; #5ns; clk = 0; #5ns;
		end
		
	initial
		begin 
			vectornum = 0;
			errors = 0;
			reset = 1;
			#50ns
			reset = 0;
		end
		
	always @(negedge clk)
		begin
			#1; 
			d = testvectors[vectornum];
			qexpected = testvectorsout[vectornum];
		end
		
	always @(posedge clk)
		begin
			if (~reset) begin
				#1;if(q!==qexpected) begin
					$display("\n===Error===");
					$display("input: %d", d);
					$display("reset: %d", reset);
					$display("clock: %d", clk);
					$display("outputs: %d", q);
					$display("expected: %d\n", qexpected);
					errors++;
				end else begin
					$display("\n===OK===");
					$display("clock: %d", clk); 
					$display("reset: %d", reset); 
					$display("input: %d", d);  
					$display("output: %d", q);  
					$display("expected: %d\n", qexpected);
				end
			end
			vectornum++;
			if (vectornum === $size(testvectors)) begin 
				$display("%d tests completed with %d errors", 
                vectornum, errors);
				$stop;
			end
		end
endmodule
