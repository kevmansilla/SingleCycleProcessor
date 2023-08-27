module maindec_tb();
	logic [10:0] Op;
	logic Reg2Loc, ALUSrc, MemtoReg, RegWhite, MemRead, MemWrite, Branch;
	logic [1:0] ALUOp;
	
	maindec dut(Op, Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
	
	function void check_result(string operation, bit[10:0] Op, bit[8:0] expected_result);
		if ({Reg2Loc, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[1:0]} === expected_result) begin 
			$display("%s --OK--", operation);
		end else begin 
			$display("Test %s failure", operation);
			$display("output: %b", {Reg2Loc, ALUSrc, MemtoReg, MemRead, RegWrite, MemWrite, Branch, ALUOp[1:0]});
			$display("expected: %b", 9'b000100010);
		end
	endfunction
	
	initial
		begin
			//LDUR
			Op = 11'b111_1100_0010; 
			#10;
			check_result("LDUR", Op, 9'b011110000);
			//STUR
			Op = 11'b111_1100_0000; 
			#10;
			check_result("STUR", Op, 9'b110001000);
			//CBZ
			Op = 11'b101_1010_0???;
			#10;
			check_result("CBZ", Op, 9'b100000101);
			//ADD
			Op = 11'b100_0101_1000;
			#10;
			check_result("ADD", Op, 9'b000100010);
			//SUB
			Op = 11'b110_0101_1000;
			#10;
			check_result("SUB", Op, 9'b000100010);
			// AND
			Op = 11'b100_0101_0000;
			#10;
			check_result("AND", Op, 9'b000100010);
			//ORR
			Op = 11'b101_0101_0000;
			#10;
			check_result("ORR", Op, 9'b000100010);
		end
endmodule