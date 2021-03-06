//////////////////////////////////////////
// Craig Day
// ECE 552, Spring 2014
// Inclass Exercise 2
//////////////////////////////////////////

module fa_ic2(a, b, cin, s, cout);
	input a, b, cin;
	output s, cout;
	wire n1, n2, n3;

	xor(n1, a, b);
	xor(s, n1, cin);
	and(n2, n1, cin);
	and(n3, a, b);
	or(cout, n2, n3);

endmodule

module t_fa_ic2();
	wire a, b, cin;
	wire sum, cout;
	integer i, j, k;

	fa DUT(a, b, cin, sum, cout);

	assign a = i;
	assign b = j;
	assign cin = k;

	initial begin
		for(i = 0; i < 2; i = i + 1) begin
			for(j = 0; j < 2; j = j + 1) begin
				for(k = 0; k < 2; k = k + 1) begin
					if({cout, sum} != (a+b+cin)) $display("INVALID SUM");
					#5; //this is here so we can see the waveform if we wish
				end
			end
		end
		$stop;
	end
endmodule