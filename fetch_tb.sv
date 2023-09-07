module fetch_tb();
	logic PCSrc_F, clk, reset;
   logic [63:0] PCBranch_F, imem_addr_F;
	logic [4:0] error, vectornum;
	integer test=0;
	
	fetch dut(PCSrc_F, clk, reset, PCBranch_F, imem_addr_F);
	
	always
		begin
			clk=0;#5ns;clk=1;#5ns;
		end
	
	initial begin
		error = 0; vectornum = 0;
		reset=1;#50ns;reset=0;
		PCSrc_F = 'b0;#40ns;PCSrc_F = 'b1;
	end
	
	always @(negedge clk)
		begin
			#1;
			PCBranch_F = 64'b101010101010;
		end

	always @(posedge clk)
		begin
			if (PCSrc_F) begin
				#1;
				if (imem_addr_F !== PCBranch_F) begin
					error += 1;
					$display("immem: %d", imem_addr_F);
					$display("pc: %d", PCBranch_F);
				end
			end
			else if (~PCSrc_F) begin
				#1;if (imem_addr_F !== test+4) begin
					error += 1;
					$display("immem: %d", imem_addr_F);
					$display("test: %d", test);
				end
				test += 4;
			end
			vectornum = vectornum +1;
			if (vectornum === 15) begin 
				$display("%d tests completed with %d errors", 
                vectornum, error);
				$stop;
			end
		end
	
endmodule