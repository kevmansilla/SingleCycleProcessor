module alu(input logic [63:0] a,
	input logic [63:0] b,
	input logic [3:0] ALUControl,
	output logic [63:0] result,
	output logic zero);

  always_comb
		begin
			case (ALUControl)
				4'b0000: result = a & b;
            4'b0001: result = a | b;
            4'b0010: result = a + b;
            4'b0110: result = a - b;
            4'b0111: result = b;
            default: result = 64'h0000; // Valor por defecto si ALUControl no coincide con ninguna operación.
			endcase
			if (result == 64'h0000) begin
				zero = 1'b1;
			end else begin
            zero = 1'b0;
			end
		end
endmodule