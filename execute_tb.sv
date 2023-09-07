module execute_tb();
	parameter N=64;
	logic AluSrc;
   logic [3:0] AluControl;
	logic [N-1:0] PC_E,signImm_E, readData1_E, readData2_E, PCBranch_E, aluResult_E, writeData_E;
	logic zero_E;
	
	execute #(N) dut(AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E, zero_E, PCBranch_E, aluResult_E, writeData_E);
	
	initial begin
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b1,64'b1,64'b1,64'b1, 64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd5,64'b1,64'b1}) $display("error 1");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b0,64'b1,64'b1,64'b0, 64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b1,64'd5,64'b0,64'b1}) $display("error 2");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b0,4'b1,64'b1,64'b1,64'b1, 64'b10};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd5,64'b11,64'b10}) $display("error 3");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b1,64'b1,64'b10,64'b1, 64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd9,64'b11,64'b1}) $display("error 4");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b0,4'b111,64'b1,64'b1,64'b1, 64'b10};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd5,64'b10,64'b10}) $display("error 5");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b10,64'b1,64'b1,64'b1, 64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd5,64'b10,64'b1}) $display("error 6");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b110,64'b1,64'b1,64'b1,64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b1,64'd5,64'd0,64'b1}) $display("error 7");
		{AluSrc, AluControl, PC_E, signImm_E, readData1_E, readData2_E} = {1'b1,4'b10,64'b1,64'b1,64'hFFFFFFFFFFFFFFFE,64'b1};#10ns;
		if({zero_E, PCBranch_E, aluResult_E, writeData_E}!=={1'b0,64'd5,64'hFFFFFFFFFFFFFFFF,64'b1}) $display("error 8");
	end

endmodule