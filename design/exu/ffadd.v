module ffadd #(
    parameter DATA_WIDTH = 10
) (
    input [DATA_WIDTH-1:0]          in_a,               // Entrada 1
    input [DATA_WIDTH-1:0]          in_b,               // Entrada 1
    output [DATA_WIDTH-1:0]         out                 // Salida normal
);

assign out = in_a ^ in_b;


endmodule