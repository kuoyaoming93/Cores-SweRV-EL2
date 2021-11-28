module clmul32(
    input       [31:0 ]     rs1,
    input       [31:0 ]     rs2,
    input                   tmr,
    output      [63:0]      result            
);
    // tmrg default do_not_triplicate
    // tmrg triplicate result_aux

    wire [31:0] rs1_in, rs2_in;
    assign rs1_in = rs1;
    assign rs2_in = tmr ? {rs2[7:0],rs2[7:0],rs2[7:0],rs2[7:0]} : rs2[31:0];
    
    wire [63:0] result_aux, result_aux1, result_aux2, result_aux3, result_aux4;
    wire [15:0]  result_tmr;
    wire result_auxTmrError;

    assign result = tmr ? {16'b0,result_tmr[15:0]} : result_aux;

    assign result_aux = result_aux1 ^ result_aux2 ^ result_aux3 ^ result_aux4;

    assign result_aux1[63:0]  =     ( {63{rs2_in[00]}} & {31'b0,rs1_in[31:0]      } ) ^
                                    ( {63{rs2_in[01]}} & {30'b0,rs1_in[31:0], 1'b0} ) ^
                                    ( {63{rs2_in[02]}} & {29'b0,rs1_in[31:0], 2'b0} ) ^
                                    ( {63{rs2_in[03]}} & {28'b0,rs1_in[31:0], 3'b0} ) ^
                                    ( {63{rs2_in[04]}} & {27'b0,rs1_in[31:0], 4'b0} ) ^
                                    ( {63{rs2_in[05]}} & {26'b0,rs1_in[31:0], 5'b0} ) ^
                                    ( {63{rs2_in[06]}} & {25'b0,rs1_in[31:0], 6'b0} ) ^
                                    ( {63{rs2_in[07]}} & {24'b0,rs1_in[31:0], 7'b0} );

    assign result_aux2[63:0]  =     ( {63{rs2_in[08]}} & {23'b0,rs1_in[31:0], 8'b0} ) ^
                                    ( {63{rs2_in[09]}} & {22'b0,rs1_in[31:0], 9'b0} ) ^
                                    ( {63{rs2_in[10]}} & {21'b0,rs1_in[31:0],10'b0} ) ^
                                    ( {63{rs2_in[11]}} & {20'b0,rs1_in[31:0],11'b0} ) ^
                                    ( {63{rs2_in[12]}} & {19'b0,rs1_in[31:0],12'b0} ) ^
                                    ( {63{rs2_in[13]}} & {18'b0,rs1_in[31:0],13'b0} ) ^
                                    ( {63{rs2_in[14]}} & {17'b0,rs1_in[31:0],14'b0} ) ^
                                    ( {63{rs2_in[15]}} & {16'b0,rs1_in[31:0],15'b0} ); 

    assign result_aux3[63:0]  =     ( {63{rs2_in[16]}} & {15'b0,rs1_in[31:0],16'b0} ) ^
                                    ( {63{rs2_in[17]}} & {14'b0,rs1_in[31:0],17'b0} ) ^
                                    ( {63{rs2_in[18]}} & {13'b0,rs1_in[31:0],18'b0} ) ^
                                    ( {63{rs2_in[19]}} & {12'b0,rs1_in[31:0],19'b0} ) ^
                                    ( {63{rs2_in[20]}} & {11'b0,rs1_in[31:0],20'b0} ) ^
                                    ( {63{rs2_in[21]}} & {10'b0,rs1_in[31:0],21'b0} ) ^
                                    ( {63{rs2_in[22]}} & { 9'b0,rs1_in[31:0],22'b0} ) ^
                                    ( {63{rs2_in[23]}} & { 8'b0,rs1_in[31:0],23'b0} );

    assign result_aux4[63:0]  =     ( {63{rs2_in[24]}} & { 7'b0,rs1_in[31:0],24'b0} ) ^
                                    ( {63{rs2_in[25]}} & { 6'b0,rs1_in[31:0],25'b0} ) ^
                                    ( {63{rs2_in[26]}} & { 5'b0,rs1_in[31:0],26'b0} ) ^
                                    ( {63{rs2_in[27]}} & { 4'b0,rs1_in[31:0],27'b0} ) ^
                                    ( {63{rs2_in[28]}} & { 3'b0,rs1_in[31:0],28'b0} ) ^
                                    ( {63{rs2_in[29]}} & { 2'b0,rs1_in[31:0],29'b0} ) ^
                                    ( {63{rs2_in[30]}} & { 1'b0,rs1_in[31:0],30'b0} ) ^
                                    ( {63{rs2_in[31]}} & {      rs1_in[31:0],31'b0} );

    majorityVoter #(.WIDTH(16)) result_auxVoter (
        .inA(result_aux1[15:0]),
        .inB(result_aux2[23:8]),
        .inC(result_aux3[31:16]),
        .out(result_tmr),
        .tmrErr(result_auxTmrError)
    );

endmodule


module majorityVoter #(
  parameter WIDTH = 1
)( 
  input wire  [WIDTH-1:0] inA,
  input wire  [WIDTH-1:0] inB,
  input wire  [WIDTH-1:0] inC,
  output wire [WIDTH-1:0] out,
  output reg              tmrErr
);
  assign out = (inA&inB) | (inA&inC) | (inB&inC);
  always @(inA or inB or inC) begin
    if (inA!=inB || inA!=inC || inB!=inC)
      tmrErr = 1;
    else
      tmrErr = 0;
  end
endmodule


