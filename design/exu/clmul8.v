module clmul8(
    input       [7:0 ]  rs1,
    input       [7:0 ]  rs2,
    output      [15:0]  result            
);

    wire [63:0] result_aux;

    assign result = result_aux;

    assign result_aux[15:0]  =      ( {15{rs2[00]}} & {7'b0,rs1[7:0]      } ) ^
                                    ( {15{rs2[01]}} & {6'b0,rs1[7:0], 1'b0} ) ^
                                    ( {15{rs2[02]}} & {5'b0,rs1[7:0], 2'b0} ) ^
                                    ( {15{rs2[03]}} & {4'b0,rs1[7:0], 3'b0} ) ^
                                    ( {15{rs2[04]}} & {3'b0,rs1[7:0], 4'b0} ) ^
                                    ( {15{rs2[05]}} & {2'b0,rs1[7:0], 5'b0} ) ^
                                    ( {15{rs2[06]}} & {1'b0,rs1[7:0], 6'b0} ) ^
                                    ( {15{rs2[07]}} & {     rs1[7:0], 7'b0} );

endmodule

