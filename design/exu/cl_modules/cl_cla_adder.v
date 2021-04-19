module cl_cla_adder #(
    parameter DATA_WIDTH = 32
  )(
   input    [DATA_WIDTH-1:0]    a,
   input    [DATA_WIDTH-1:0]    b,
   input                        carry_option,
   output   [DATA_WIDTH-1:0]    sum,
   output                       co
   );
     
  wire [DATA_WIDTH:0]     w_C;
  wire [DATA_WIDTH-1:0]   w_G, w_P, w_SUM;
 
  // Create the Full Adders
  genvar             ii;
  generate
    for (ii=0; ii<DATA_WIDTH; ii=ii+1) 
      begin
        full_adder full_adder_inst
            ( 
              .a(a[ii]),
              .b(b[ii]),
              .ci(w_C[ii]),
              .sum(w_SUM[ii]),
              .co()
              );
      end
  endgenerate
 
  // Create the Generate (G) Terms:  Gi=Ai*Bi
  // Create the Propagate Terms: Pi=Ai+Bi
  // Create the Carry Terms:
  genvar             jj;
  generate
    for (jj=0; jj<DATA_WIDTH; jj=jj+1) 
      begin
        assign w_G[jj]   = a[jj] & b[jj];
        assign w_P[jj]   = a[jj] | b[jj];
        assign w_C[jj+1] = (w_G[jj] | (w_P[jj] & w_C[jj])) & carry_option;
      end
  endgenerate
   
  assign w_C[0] = 1'b0; // no carry input on first adder
 
  assign sum = w_SUM;   
  assign co = w_C[DATA_WIDTH];
  
endmodule // carry_lookahead_adder