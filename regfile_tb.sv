module regfile_tb();
	logic clk, we3;
	logic [4:0] ra1, ra2, wa3;
	logic [4:0] rd1_expected, rd2_expected;
	logic [63:0] rd1, rd2, wd3, errors, test;
	
//	logic [207:0] results [0:15] = '{
		// ra1 	ra2 	wa3 	wd3 		we3	rd1 	rd2 
		// ra1 = x0, ra2 = x1, wa3 = x0, wd3 = 35, we3 = 0
		// ra1 = x2, ra2 = x3, wa3 = x2, wd3 = 27, we3 = 1
		// ra1 = x4, ra2 = x5, wa3 = x4, wd3 = 28, we3 = 0
		// ra1 = x6, ra2 = x7, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x8, ra2 = x9, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x10, ra2 = x11, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x12, ra2 = x13, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x14, ra2 = x15, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x16, ra2 = x17, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x18, ra2 = x19, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x20, ra2 = x21, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x22, ra2 = x23, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x24, ra2 = x25, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x26, ra2 = x27, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x28, ra2 = x29, wa3 = 0, wd3 = 0, we3 = 0
		// ra1 = x30, ra2 = x31, wa3 = x31, wd3 = 52, we3 = 1	
//	}
	
	regfile dut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);
	
	always begin
		clk = 0; #5; clk = 1; #5;
	end

endmodule