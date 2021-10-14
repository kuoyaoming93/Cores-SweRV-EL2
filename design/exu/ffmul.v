module ffmul #(
    parameter DATA_WIDTH = 32
) (
    input [$clog2(DATA_WIDTH):0]    polyn_grade,        // Orden del polinomio a reducir
    input [DATA_WIDTH:0]            polyn_red_in,       // Polinomio primitivo
    input [DATA_WIDTH-1:0]          in_a,               // Entrada 1
    input [DATA_WIDTH-1:0]          in_b,               // Entrada 1
    output [DATA_WIDTH-1:0]         out                 // Salida normal
);


logic        [62:0]    clmul_raw_d;

assign clmul_raw_d[62:0]      = ( {63{in_a[00]}} & {31'b0,in_b[31:0]      } ) ^
                                ( {63{in_a[01]}} & {30'b0,in_b[31:0], 1'b0} ) ^
                                ( {63{in_a[02]}} & {29'b0,in_b[31:0], 2'b0} ) ^
                                ( {63{in_a[03]}} & {28'b0,in_b[31:0], 3'b0} ) ^
                                ( {63{in_a[04]}} & {27'b0,in_b[31:0], 4'b0} ) ^
                                ( {63{in_a[05]}} & {26'b0,in_b[31:0], 5'b0} ) ^
                                ( {63{in_a[06]}} & {25'b0,in_b[31:0], 6'b0} ) ^
                                ( {63{in_a[07]}} & {24'b0,in_b[31:0], 7'b0} ) ^
                                ( {63{in_a[08]}} & {23'b0,in_b[31:0], 8'b0} ) ^
                                ( {63{in_a[09]}} & {22'b0,in_b[31:0], 9'b0} ) ^
                                ( {63{in_a[10]}} & {21'b0,in_b[31:0],10'b0} ) ^
                                ( {63{in_a[11]}} & {20'b0,in_b[31:0],11'b0} ) ^
                                ( {63{in_a[12]}} & {19'b0,in_b[31:0],12'b0} ) ^
                                ( {63{in_a[13]}} & {18'b0,in_b[31:0],13'b0} ) ^
                                ( {63{in_a[14]}} & {17'b0,in_b[31:0],14'b0} ) ^
                                ( {63{in_a[15]}} & {16'b0,in_b[31:0],15'b0} ) ^
                                ( {63{in_a[16]}} & {15'b0,in_b[31:0],16'b0} ) ^
                                ( {63{in_a[17]}} & {14'b0,in_b[31:0],17'b0} ) ^
                                ( {63{in_a[18]}} & {13'b0,in_b[31:0],18'b0} ) ^
                                ( {63{in_a[19]}} & {12'b0,in_b[31:0],19'b0} ) ^
                                ( {63{in_a[20]}} & {11'b0,in_b[31:0],20'b0} ) ^
                                ( {63{in_a[21]}} & {10'b0,in_b[31:0],21'b0} ) ^
                                ( {63{in_a[22]}} & { 9'b0,in_b[31:0],22'b0} ) ^
                                ( {63{in_a[23]}} & { 8'b0,in_b[31:0],23'b0} ) ^
                                ( {63{in_a[24]}} & { 7'b0,in_b[31:0],24'b0} ) ^
                                ( {63{in_a[25]}} & { 6'b0,in_b[31:0],25'b0} ) ^
                                ( {63{in_a[26]}} & { 5'b0,in_b[31:0],26'b0} ) ^
                                ( {63{in_a[27]}} & { 4'b0,in_b[31:0],27'b0} ) ^
                                ( {63{in_a[28]}} & { 3'b0,in_b[31:0],28'b0} ) ^
                                ( {63{in_a[29]}} & { 2'b0,in_b[31:0],29'b0} ) ^
                                ( {63{in_a[30]}} & { 1'b0,in_b[31:0],30'b0} ) ^
                                ( {63{in_a[31]}} & {      in_b[31:0],31'b0} );

red_test #(32) red0(
            .polyn_grade(polyn_grade),
            .polyn_red_in(polyn_red_in),
            .reduc_in({1'b0,clmul_raw_d[62:0]}),
            .out(out)
);

endmodule