module fetch #(parameter N = 64)
			(input logic PCSrc_F, clk, reset,
				input logic [N-1:0] PCBranch_F,
				output logic [N-1:0] imem_addr_F);
	logic [N-1:0] adder_result, mux_result;
	mux2 mux(adder_result, PCBranch_F, PCSrc_F, mux_result);
	flopr PC(clk, reset, mux_result, imem_addr_F);
	adder add(N'('b0100), imem_addr_F, adder_result);
endmodule