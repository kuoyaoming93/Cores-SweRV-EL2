module clmul #(
  parameter WIDTH     = 409,
  parameter PARTITION = 32
) (
  input  logic                clk,
  input  logic                rst_n,
  input  logic [WIDTH-1:0]    op_a_i,       // I P Operand A
  input  logic [WIDTH-1:0]    op_b_i,       // I P Operand B
  input  logic                enable_i,     // I 1 Enable

  output logic [2*WIDTH-1:0]  result_o,     // O P Result
  output logic                finish_o,     // O 1 Finish
  output logic                finish_p_o    // O 1 Finish pulse

);

  localparam [4:0] counter_value = (WIDTH + PARTITION - 1) / PARTITION - 1;
  
  logic [PARTITION-1:0] op_a; 
  logic [WIDTH-1:0]     op_b;
  logic [2*WIDTH-1:0]   result, result_ff;

  logic [2*WIDTH-1:0]   partial_result    [PARTITION-1:0];

  logic [4:0]           counter, counter_d;
  logic                 finish,  finish_d;

  // =======================================================
  // ====================   Counter  =======================
  // =======================================================
  always_ff @(posedge clk or negedge rst_n ) begin : COUNTER
    if(!rst_n) begin
      counter   <= '0;
      counter_d <= '0;
    end else begin
      if (!enable_i) begin
        counter   <= '0;
        counter_d <= '0;
      end else begin
        if(counter < counter_value) begin
          counter <= counter + 'b1;
        end 
        counter_d <= counter;
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
      if (counter_d == counter_value) begin
        finish <= 1'b1;
      end
      finish_d <= finish;
    end
  end

  assign finish_o   = finish;
  assign finish_p_o = finish & ~finish_d;

  // =======================================================
  // ===================     Inputs     ====================
  // =======================================================
  always_ff @(posedge clk or negedge rst_n) begin : REG_IN
      if (!rst_n) begin
          op_a  <= 0;
      end else begin 
          op_a  <= op_a_i >> (counter * PARTITION);
      end
  end 

  assign op_b = op_b_i;

  // =======================================================
  // ===================     CLMUL      ====================
  // =======================================================

  genvar i;
  generate 
    for (i=0; i<PARTITION; i++) begin
      assign partial_result[i] = ( {(2*WIDTH-1){op_a[i]}} & {{(WIDTH-1-i){1'b0}},op_b[WIDTH-1:0], {i{1'b0}}} );
    end
  endgenerate

  always_comb begin
    result = '0;
    for (int i = 0; i < PARTITION; i++) begin
      result ^= partial_result[i];
    end
  end

  always_ff @(posedge clk or negedge rst_n) begin
      if (!rst_n) begin
          result_ff  <= 0;
      end else begin 
          if (!finish) begin
            result_ff  <= result_ff ^ (result << ((counter_d) * PARTITION));
          end
      end
  end 

  // =======================================================
  // ===================     Output     ====================
  // =======================================================

  assign result_o = result_ff;
  
endmodule