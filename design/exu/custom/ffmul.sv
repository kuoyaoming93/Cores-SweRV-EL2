module ffmul #(
  parameter WIDTH     = 409
) (
  input  logic                clk,
  input  logic                rst_n,
  input  logic [WIDTH-1:0]    a_i,          // I P Operand A
  input  logic [WIDTH-1:0]    b_i,          // I P Operand B
  input  logic [WIDTH-2:0]    poly_i,
  input  logic                enable_i,     // I 1 Enable

  output logic [WIDTH-1:0]    result_o,     // O P Result
  output logic                finish_o,     // O 1 Finish
  output logic                finish_p_o    // O 1 Finish
);
  localparam T_CYCLES = 86;

  logic [2*WIDTH-1:0]   clmul_res;
  logic [WIDTH-1:0]     xor_stage_1;
  logic [2*WIDTH-1:0]   pm;
  logic                 clmul_finish, clmul_finish_p;
  logic [WIDTH-1:0]     result;
  logic                 finish, finish_d;
  logic [7:0]           counter, counter_value;


  // =======================================================
  // ===================     CLMUL      ====================
  // =======================================================
  clmul #(WIDTH, 32) u_clmul (
    .clk        (clk            ),
    .rst_n      (rst_n          ),
    .op_a_i     (a_i            ),       
    .op_b_i     (b_i            ),       
    .enable_i   (enable_i       ),
    .result_o   (clmul_res      ),
    .finish_o   (clmul_finish   ),
    .finish_p_o (clmul_finish_p )
  );

  // =======================================================
  // ================     Shift regs      ==================
  // =======================================================
  logic [WIDTH-2:0] d_ff, q_ff;

  genvar i;
  generate 
    for (i=0; i<WIDTH-1; i++) begin
      always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          q_ff[i] <= 1'b0;
        end else begin
          if (clmul_finish_p) begin
            q_ff[i] <= clmul_res[WIDTH+i];
          end else begin
            q_ff[i] <= d_ff[i];
          end
        end
      end

      if (i==0) begin
        assign d_ff[i] = q_ff[WIDTH-2];
      end else begin
        assign d_ff[i] = (poly_i[i] & q_ff[WIDTH-2]) ^ q_ff[i-1];
      end
    end
  endgenerate

  // =======================================================
  // ============     First stage XORs     =================
  // =======================================================
  
  generate 
    for (i=0; i<WIDTH-1; i++) begin
      assign xor_stage_1[i] = clmul_res[i] ^ clmul_res[WIDTH+i];
    end
  endgenerate

  assign xor_stage_1[WIDTH-1] = clmul_res[WIDTH-1];

  assign pm[2*WIDTH-1:0] = {1'b0, q_ff[WIDTH-2:0], xor_stage_1[WIDTH-1:0]};

  // =======================================================
  // ============     Second stage XORs     ================
  // =======================================================
  generate 
    for (i=0; i<WIDTH; i++) begin
      if (i < T_CYCLES) begin
        assign result[i] = pm[i] ^ pm[WIDTH+i];
      end else if (i == T_CYCLES) begin
        assign result[i] = clmul_res[i];
      end else begin
        assign result[i] = pm[i] ^ pm[WIDTH+i-1];
      end
    end
  endgenerate

  always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
        result_o  <= 0;
      end else begin 
        if (!finish) begin
          result_o  <= result;
        end
      end
  end 

  // =======================================================
  // ====================   Counter  =======================
  // =======================================================

  assign counter_value = T_CYCLES;
  always_ff @(posedge clk or negedge rst_n ) begin : COUNTER
    if(!rst_n) begin
      counter   <= '0;
    end else if (!clmul_finish) begin 
      counter   <= '0;
    end else begin
      if (!enable_i) begin
        counter   <= '0;
      end else begin
        if (counter < counter_value) begin
          counter <= counter + 'b1;
        end 
      end
    end
  end

  // =======================================================
  // ===========   Finish pulse generation  ================
  // =======================================================
  
  always_ff @(posedge clk or negedge rst_n ) begin : FINISH
    if (!rst_n) begin
      finish    <= 1'b0;
      finish_d  <= 1'b0;
    end else begin
      if (counter == counter_value) begin
        finish <= 1'b1;
      end
      finish_d <= finish;
    end
  end

  assign finish_o   = finish;
  assign finish_p_o = finish & ~finish_d;
  
endmodule