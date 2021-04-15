module bit_order_inversion #(
    parameter DATA_WIDTH = 32
)(
    input [DATA_WIDTH-1:0] a,
    output [DATA_WIDTH-1:0] a_n
);

    genvar i;
    generate
		for (i = 0; i < DATA_WIDTH; i = i + 1) begin
            assign a_n[i] = a[DATA_WIDTH-1-i];
        end
	endgenerate

endmodule