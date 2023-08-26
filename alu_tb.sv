module alu_tb();
	logic [63:0] a, b, result, res;
	logic [3:0] ALUControl;
	logic zero;
	
	alu dut(a, b, ALUControl, result, zero);
	
   // Función para verificar el resultado y la bandera zero
   function void check_result(string operation, bit expected_zero, bit[63:0] expected_result);
      if (zero == expected_zero && result == expected_result) begin
         $display("%s Test PASSED", operation);
			$display("result %h", result);
			$display("expected %h", expected_result);
      end else begin
         $display("%s Test FAILED", operation);
         $display("Expected zero = %b, Expected result = %b", expected_zero, expected_result);
         $display("Actual zero = %b, Actual result = %b", zero, result);
      end
   endfunction
	
	initial
		begin 
			// Test: a AND b
			$display("\nTest a AND b");
			a = 64'b1010101010101010101010101010101010101010101010101010101010101;
			b = 64'b1100110011001100110011001100110011001100110011001100110011001;
			res = a&b;
			ALUControl = 4'b0000;
			#10;
			check_result("AND", 1'b0, res);
			
			// Test: a AND b, con dos negativos
			$display("\nTest a AND b, con ambos negativos");
			// Calcula los complementos a dos de -a y -b
			a = ~(64'b1010101010101010101010101010101010101010101010101010101010101) + 64'b1;
			b = ~(64'b1100110011001100110011001100110011001100110011001100110011001) + 64'b1;
			res = a & b;
			#10;
			check_result("AND con ambos negativos", 1'b0, res);
			
			// Test: a AND b, con a>0 y  b<0
			$display("\nTest a AND b, con con a>0 y  b<0");
			// Calcula los complementos a dos de -a y -b
			a = 64'b1010101010101010101010101010101010101010101010101010101010101;
			b = ~(64'b1100110011001100110011001100110011001100110011001100110011001) + 64'b1;
			res = a & b;
			#10;
			check_result("AND con ambos negativos", 1'b0, res);
			
			// Test: a OR b
			$display("\nTest a OR b");
			a = 64'b1010101010101010101010101010101010101010101010101010101010101;
			b = 64'b1100110011001100110011001100110011001100110011001100110011001;
			res = a | b;
			ALUControl = 4'b0001;
			#10;
			check_result("OR", 1'b0, res);
			
			// Test: a OR b, con dos negativos
			$display("\nTest a OR b, con ambos negativos");
			// Calcula los complementos a dos de -a y -b
			a = ~(64'b1010101010101010101010101010101010101010101010101010101010101) + 64'b1;
			b = ~(64'b1100110011001100110011001100110011001100110011001100110011001) + 64'b1;
			res = a | b;
			#10;
			check_result("OR con ambos negativos", 1'b0, res);
			
			// Test: a OR b, con a>0 y  b<0
			$display("\nTest a OR b, con con a>0 y  b<0");
			// Calcula los complementos a dos de -a y -b
			a = 64'b1010101010101010101010101010101010101010101010101010101010101;
			b = ~(64'b1100110011001100110011001100110011001100110011001100110011001) + 64'b1;
			res = a | b;
			#10;
			check_result("OR con ambos negativos", 1'b0, res);
			
			// Test: a + b (suma positiva)
			$display("\nTest a + b (suma positiva)");
			a = 64'd10;
			b = 64'd11;
			res = a + b;
			ALUControl = 4'b0010;
			#10;
			check_result("ADD (Positive)", 1'b0, res);
			
			// Test: a + b (a<0 y b<0)
			$display("\nTest a + b (a<0 y b<0)");
			a = 64'hFFFFFFFFFFFFFFF6;
			b = 64'hFFFFFFFFFFFFFFFB;
			res = a + b;
			ALUControl = 4'b0010;
			#10;
			check_result("ADD (a<0 y b<0)", 1'b0, res);
			
			// Test: a + b (a<0 y b>0)
			$display("\nTest a + b (a<0 y b>0)");
			a = 64'hFFFFFFFFFFFFFFF6;
			b = 64'd11;
			res = a + b;
			ALUControl = 4'b0010;
			#10;
			check_result("ADD a<0 y b>0)", 1'b0, res);
			
			// Test: a - b (resta positiva)
			$display("\nTest a - b (resta positiva)");
			a = 64'd12;
			b = 64'd10;
			res = a - b;
			ALUControl = 4'b0110;
			#10;
			check_result("SUB (Positive)", 1'b0, res);
			
			// Test: a - b (resta dos valores negativos)
			$display("\nTest a - b (resta dos valores negativos)");
			a = ~(64'd12) + 64'd1;
			b = ~(64'd10) + 64'd1;
			res = a - b;
			ALUControl = 4'b0110;
			#10;
			check_result("SUB (resta dos valores negativos)", 1'b0, res);
			
			// Test: a - b (a<0, b>0)
			$display("\nTest a - b (a<0, b>0)");
			a = ~(64'd12) + 64'd1;
			b = 64'd10;
			res = a - b;
			ALUControl = 4'b0110;
			#10;
			check_result("SUB (a<0, b>0)", 1'b0, res);
			
			// Test: PASS B
			$display("\nTest pass b");
			ALUControl = 4'b0111;
			#10;
			check_result("Pass b", 1'b0, 64'd10);
			
			// Test: Overflow en suma
			$display("\nOverFlow suma");
			a = 64'hFFFFFFFFFFFFFFFF;
			b = 64'h0000000000000001;
			ALUControl = 4'b0010;
			#10;
			check_result("ADD (Overflow)", 1'b1, 64'h0000000000000000);
			
			// Test: Resultado igual a cero
			a = 64'h0000000000000000;
			b = 64'h0000000000000000;
			$display("\nAND con entradas ceros");
			ALUControl = 4'b0000;
			#10;
			check_result("Zero Result", 1'b1, 64'h0000000000000000);
			
			$stop;
		end
endmodule