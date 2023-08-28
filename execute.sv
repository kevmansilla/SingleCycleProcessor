module execute #(parameter N = 64)
					(input logic AluSrc,
                input logic [3:0] AluControl,
					 input logic [N-1:0] PC_E,signImm_E, readData1_E, readData2_E,
					 output logic zero_E,
					 output logic [N-1:0] PCBranch_E, aluResult_E, writeData_E);
	logic [N-1:0] shift_result, mux_result;
	sl2 shift(signImm_E, shift_result);
	mux2 mux(readData2_E, signImm_E, AluSrc, mux_result);
	adder add(PC_E, shift_result, PCBranch_E);
	alu ALU(readData1_E, mux_result, AluControl, aluResult_E, zero_E);
	assign writeData_E = readData2_E;
endmodule