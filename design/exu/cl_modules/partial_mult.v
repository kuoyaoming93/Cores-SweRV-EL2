module partial_mult #(
    parameter DATA_WIDTH = 32
) (
    input [DATA_WIDTH-1:0] a,
    input b,
    output [DATA_WIDTH-1:0] out
    );

    /* Multiplicaciones parciales */
    assign out = a & {DATA_WIDTH{b}};

endmodule