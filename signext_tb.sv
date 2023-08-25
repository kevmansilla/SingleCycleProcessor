module signext_tb();
	logic [31:0] a;
	logic [63:0] y;
	integer error_count;

	signext dup(a, y);
	initial
		begin
			error_count = 0;
			a = '{{11'b11111000010, 9'd16, 2'b00, 5'd5, 5'd6}};#10ns;
			if (y !== 64'd16) error_count += 1;
			a = '{{11'b11111000000, 9'd124, 2'b00, 5'd5, 5'd6}};#10ns;
			if (y !== 64'd124) error_count += 1;
			a = '{{11'b11111000000, 9'd192, 2'b00, 5'd5, 5'd6}};#10ns;
			if (y !== 64'd192) error_count += 1;
			a = 32'd0;#10ns; //default
			if (y !== 64'd0) error_count += 1;
			a = 32'b1; #10;
			if (y !== 64'b0) error_count += 1; 
			$display("Simulation finished, %d errors", error_count);
		end
endmodule
