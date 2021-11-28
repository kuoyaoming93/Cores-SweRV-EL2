/****************************************************************************************************
 *                          ! THIS FILE WAS AUTO-GENERATED BY TMRG TOOL !                           *
 *                                   ! DO NOT EDIT IT MANUALLY !                                    *
 *                                                                                                  *
 * file    : ./clmulTMR.v                                                                           *
 *                                                                                                  *
 * user    : kuo                                                                                    *
 * host    : kuo-X550JX                                                                             *
 * date    : 23/11/2021 20:54:38                                                                    *
 *                                                                                                  *
 * workdir : /home/kuo/Escritorio/tmr                                                               *
 * cmd     : /home/kuo/gits/tmrg/bin/tmrg clmul.v                                                   *
 * tmrg rev: 234866a4eb38cb3bed97b52e303e47bf2d7c6537                                               *
 *                                                                                                  *
 * src file: clmul.v                                                                                *
 *           Git SHA           : File not in git repository!                                        *
 *           Modification time : 2021-11-23 20:54:36.410235                                         *
 *           File Size         : 2898                                                               *
 *           MD5 hash          : 990db48ce86c6426c70f1a246fedc7e1                                   *
 *                                                                                                  *
 ****************************************************************************************************/

module clmulTMR(
  input [31:0] rs1,
  input [31:0] rs2,
  output [63:0] result
);
wire [31:0] rs1C;
wire [31:0] rs1B;
wire [31:0] rs1A;
wire [31:0] rs2C;
wire [31:0] rs2B;
wire [31:0] rs2A;
//wor result_auxTmrError;
wire [63:0] result_aux;
wire [63:0] result_auxA;
wire [63:0] result_auxB;
wire [63:0] result_auxC;
assign result =  result_aux;
assign result_auxA[63:0]  =  ({63{rs2A[00] }}&{31'b0,rs1A[31:0] })^({63{rs2A[01] }}&{30'b0,rs1A[31:0] ,1'b0})^({63{rs2A[02] }}&{29'b0,rs1A[31:0] ,2'b0})^({63{rs2A[03] }}&{28'b0,rs1A[31:0] ,3'b0})^({63{rs2A[04] }}&{27'b0,rs1A[31:0] ,4'b0})^({63{rs2A[05] }}&{26'b0,rs1A[31:0] ,5'b0})^({63{rs2A[06] }}&{25'b0,rs1A[31:0] ,6'b0})^({63{rs2A[07] }}&{24'b0,rs1A[31:0] ,7'b0})^({63{rs2A[08] }}&{23'b0,rs1A[31:0] ,8'b0})^({63{rs2A[09] }}&{22'b0,rs1A[31:0] ,9'b0})^({63{rs2A[10] }}&{21'b0,rs1A[31:0] ,10'b0})^({63{rs2A[11] }}&{20'b0,rs1A[31:0] ,11'b0})^({63{rs2A[12] }}&{19'b0,rs1A[31:0] ,12'b0})^({63{rs2A[13] }}&{18'b0,rs1A[31:0] ,13'b0})^({63{rs2A[14] }}&{17'b0,rs1A[31:0] ,14'b0})^({63{rs2A[15] }}&{16'b0,rs1A[31:0] ,15'b0})^({63{rs2A[16] }}&{15'b0,rs1A[31:0] ,16'b0})^({63{rs2A[17] }}&{14'b0,rs1A[31:0] ,17'b0})^({63{rs2A[18] }}&{13'b0,rs1A[31:0] ,18'b0})^({63{rs2A[19] }}&{12'b0,rs1A[31:0] ,19'b0})^({63{rs2A[20] }}&{11'b0,rs1A[31:0] ,20'b0})^({63{rs2A[21] }}&{10'b0,rs1A[31:0] ,21'b0})^({63{rs2A[22] }}&{9'b0,rs1A[31:0] ,22'b0})^({63{rs2A[23] }}&{8'b0,rs1A[31:0] ,23'b0})^({63{rs2A[24] }}&{7'b0,rs1A[31:0] ,24'b0})^({63{rs2A[25] }}&{6'b0,rs1A[31:0] ,25'b0})^({63{rs2A[26] }}&{5'b0,rs1A[31:0] ,26'b0})^({63{rs2A[27] }}&{4'b0,rs1A[31:0] ,27'b0})^({63{rs2A[28] }}&{3'b0,rs1A[31:0] ,28'b0})^({63{rs2A[29] }}&{2'b0,rs1A[31:0] ,29'b0})^({63{rs2A[30] }}&{1'b0,rs1A[31:0] ,30'b0})^({63{rs2A[31] }}&{rs1A[31:0] ,31'b0});
assign result_auxB[63:0]  =  ({63{rs2B[00] }}&{31'b0,rs1B[31:0] })^({63{rs2B[01] }}&{30'b0,rs1B[31:0] ,1'b0})^({63{rs2B[02] }}&{29'b0,rs1B[31:0] ,2'b0})^({63{rs2B[03] }}&{28'b0,rs1B[31:0] ,3'b0})^({63{rs2B[04] }}&{27'b0,rs1B[31:0] ,4'b0})^({63{rs2B[05] }}&{26'b0,rs1B[31:0] ,5'b0})^({63{rs2B[06] }}&{25'b0,rs1B[31:0] ,6'b0})^({63{rs2B[07] }}&{24'b0,rs1B[31:0] ,7'b0})^({63{rs2B[08] }}&{23'b0,rs1B[31:0] ,8'b0})^({63{rs2B[09] }}&{22'b0,rs1B[31:0] ,9'b0})^({63{rs2B[10] }}&{21'b0,rs1B[31:0] ,10'b0})^({63{rs2B[11] }}&{20'b0,rs1B[31:0] ,11'b0})^({63{rs2B[12] }}&{19'b0,rs1B[31:0] ,12'b0})^({63{rs2B[13] }}&{18'b0,rs1B[31:0] ,13'b0})^({63{rs2B[14] }}&{17'b0,rs1B[31:0] ,14'b0})^({63{rs2B[15] }}&{16'b0,rs1B[31:0] ,15'b0})^({63{rs2B[16] }}&{15'b0,rs1B[31:0] ,16'b0})^({63{rs2B[17] }}&{14'b0,rs1B[31:0] ,17'b0})^({63{rs2B[18] }}&{13'b0,rs1B[31:0] ,18'b0})^({63{rs2B[19] }}&{12'b0,rs1B[31:0] ,19'b0})^({63{rs2B[20] }}&{11'b0,rs1B[31:0] ,20'b0})^({63{rs2B[21] }}&{10'b0,rs1B[31:0] ,21'b0})^({63{rs2B[22] }}&{9'b0,rs1B[31:0] ,22'b0})^({63{rs2B[23] }}&{8'b0,rs1B[31:0] ,23'b0})^({63{rs2B[24] }}&{7'b0,rs1B[31:0] ,24'b0})^({63{rs2B[25] }}&{6'b0,rs1B[31:0] ,25'b0})^({63{rs2B[26] }}&{5'b0,rs1B[31:0] ,26'b0})^({63{rs2B[27] }}&{4'b0,rs1B[31:0] ,27'b0})^({63{rs2B[28] }}&{3'b0,rs1B[31:0] ,28'b0})^({63{rs2B[29] }}&{2'b0,rs1B[31:0] ,29'b0})^({63{rs2B[30] }}&{1'b0,rs1B[31:0] ,30'b0})^({63{rs2B[31] }}&{rs1B[31:0] ,31'b0});
assign result_auxC[63:0]  =  ({63{rs2C[00] }}&{31'b0,rs1C[31:0] })^({63{rs2C[01] }}&{30'b0,rs1C[31:0] ,1'b0})^({63{rs2C[02] }}&{29'b0,rs1C[31:0] ,2'b0})^({63{rs2C[03] }}&{28'b0,rs1C[31:0] ,3'b0})^({63{rs2C[04] }}&{27'b0,rs1C[31:0] ,4'b0})^({63{rs2C[05] }}&{26'b0,rs1C[31:0] ,5'b0})^({63{rs2C[06] }}&{25'b0,rs1C[31:0] ,6'b0})^({63{rs2C[07] }}&{24'b0,rs1C[31:0] ,7'b0})^({63{rs2C[08] }}&{23'b0,rs1C[31:0] ,8'b0})^({63{rs2C[09] }}&{22'b0,rs1C[31:0] ,9'b0})^({63{rs2C[10] }}&{21'b0,rs1C[31:0] ,10'b0})^({63{rs2C[11] }}&{20'b0,rs1C[31:0] ,11'b0})^({63{rs2C[12] }}&{19'b0,rs1C[31:0] ,12'b0})^({63{rs2C[13] }}&{18'b0,rs1C[31:0] ,13'b0})^({63{rs2C[14] }}&{17'b0,rs1C[31:0] ,14'b0})^({63{rs2C[15] }}&{16'b0,rs1C[31:0] ,15'b0})^({63{rs2C[16] }}&{15'b0,rs1C[31:0] ,16'b0})^({63{rs2C[17] }}&{14'b0,rs1C[31:0] ,17'b0})^({63{rs2C[18] }}&{13'b0,rs1C[31:0] ,18'b0})^({63{rs2C[19] }}&{12'b0,rs1C[31:0] ,19'b0})^({63{rs2C[20] }}&{11'b0,rs1C[31:0] ,20'b0})^({63{rs2C[21] }}&{10'b0,rs1C[31:0] ,21'b0})^({63{rs2C[22] }}&{9'b0,rs1C[31:0] ,22'b0})^({63{rs2C[23] }}&{8'b0,rs1C[31:0] ,23'b0})^({63{rs2C[24] }}&{7'b0,rs1C[31:0] ,24'b0})^({63{rs2C[25] }}&{6'b0,rs1C[31:0] ,25'b0})^({63{rs2C[26] }}&{5'b0,rs1C[31:0] ,26'b0})^({63{rs2C[27] }}&{4'b0,rs1C[31:0] ,27'b0})^({63{rs2C[28] }}&{3'b0,rs1C[31:0] ,28'b0})^({63{rs2C[29] }}&{2'b0,rs1C[31:0] ,29'b0})^({63{rs2C[30] }}&{1'b0,rs1C[31:0] ,30'b0})^({63{rs2C[31] }}&{rs1C[31:0] ,31'b0});

majorityVoter #(.WIDTH(64)) result_auxVoter (
    .inA(result_auxA),
    .inB(result_auxB),
    .inC(result_auxC),
    .out(result_aux),
    //.tmrErr(result_auxTmrError)
    );

fanout #(.WIDTH(32)) rs2Fanout (
    .in(rs2),
    .outA(rs2A),
    .outB(rs2B),
    .outC(rs2C)
    );

fanout #(.WIDTH(32)) rs1Fanout (
    .in(rs1),
    .outA(rs1A),
    .outB(rs1B),
    .outC(rs1C)
    );
endmodule



// /home/kuo/gits/tmrg/tmrg/../common/voter.v
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


// /home/kuo/gits/tmrg/tmrg/../common/fanout.v
module fanout #(
  parameter WIDTH = 1
)(
  input wire  [WIDTH-1:0] in,
  output wire [WIDTH-1:0] outA,
  output wire [WIDTH-1:0] outB,
  output wire [WIDTH-1:0] outC
);
  assign outA = in;
  assign outB = in;
  assign outC = in;
endmodule
