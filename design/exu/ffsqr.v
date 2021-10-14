module ffsqr #(
    parameter DATA_WIDTH = 32
) (
    input [$clog2(DATA_WIDTH):0]    polyn_grade,        // Orden del polinomio a reducir
    input [DATA_WIDTH:0]            polyn_red_in,       // Polinomio primitivo

    input [DATA_WIDTH-1:0]          in_a,               // Entrada 1
    output [DATA_WIDTH-1:0]         out                 // Salida normal
);


ffmul #(DATA_WIDTH) ffmul0 (
    .polyn_grade(polyn_grade),
    .polyn_red_in(polyn_red_in),

    .in_a(in_a[DATA_WIDTH-1:0]),
    .in_b(in_a[DATA_WIDTH-1:0]),
    .out(out[DATA_WIDTH-1:0])
);

endmodule