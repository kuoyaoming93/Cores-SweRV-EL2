module ffinv8 #(
    parameter DATA_WIDTH = 32,
    parameter POLY_GRADE = 8
) (
    input [DATA_WIDTH-1:0]          inv_in,               // Entrada 1
    output [DATA_WIDTH-1:0]         out                 // Salida normal
);

logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] aux   [0:POLY_GRADE-1];
logic [DATA_WIDTH-1:0] aux2  [0:POLY_GRADE-1];
logic [DATA_WIDTH-1:0] a_mul [0:POLY_GRADE-1];

assign data_in = inv_in;
assign aux2[0] = aux[0];

genvar i,j;
generate
    for (i = 0; i < POLY_GRADE-1; i = i + 1) begin
        ffmul #(DATA_WIDTH) mul1 (
            .polyn_grade(POLY_GRADE),
            .polyn_red_in('h11d),

            .in_a(a_mul[i]),
            .in_b(a_mul[i]),
            .out(aux[i])
        );

        assign a_mul[i] = (i==0) ? data_in : aux[i-1];
    end
endgenerate

generate
    for (j = 0; j < POLY_GRADE-2; j = j + 1) begin
        ffmul #(32) mul0 (
            .polyn_grade(POLY_GRADE),
            .polyn_red_in('h11d),

            .in_a(aux2[j]),
            .in_b(aux[j+1]),
            .out(aux2[j+1])
        );
    end
endgenerate

assign out = aux2[POLY_GRADE-2];
//assign out = inv_in;

endmodule