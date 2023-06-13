import ffmul_pkg::*;

module ffmul (
  input  logic                clk,
  input  logic                rst_n,
  input  logic [408:0]        a_i,          // I P Operand A
  input  logic [408:0]        b_i,          // I P Operand B
  input  logic                enable_i,     // I 1 Enable
  input  logic [1:0]          op_i,         // I 1 Opcode

  output logic [408:0]        result_o,     // O P Result
  output logic                finish_o,     // O 1 Finish
  output logic                finish_p_o    // O 1 Finish
);
  

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
  logic             q_aux;
  logic [407:0]     poly_aux;

  always_comb begin
    case (op_i)
      FF409:  begin
                q_aux     = q_ff[407];
                poly_aux  = {321'b0,1'b1,86'b0};
              end
      FF233:  begin 
                q_aux     = q_ff[231];
                poly_aux  = {334'b0,1'b1,73'b0};
              end
      FF193:  begin 
                q_aux     = q_ff[191];
                poly_aux  = {393'b0,1'b1,14'b0};
              end
      FF113:  begin 
                q_aux     = q_ff[111];
                poly_aux  = {399'b0,1'b1,8'b0};
              end
    endcase
  end

  genvar i;
  generate 
    for (i=0; i<WIDTH-1; i++) begin
      always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
          q_ff[i] <= 1'b0;
        end else begin
          if (clmul_finish_p) begin
            if          (op_i == FF409) begin
              q_ff[i] <= clmul_res[409+i];
            end else if (op_i == FF233) begin
              q_ff[i] <= clmul_res[233+i];
            end else if (op_i == FF193) begin
              q_ff[i] <= clmul_res[193+i];
            end else if (op_i == FF113) begin
              q_ff[i] <= clmul_res[113+i];
            end else begin
              q_ff[i] <= 1'b0;
            end
            
          end else begin
            q_ff[i] <= d_ff[i];
          end
        end
      end

      if (i==0) begin
        assign d_ff[i] = q_aux;
      end else begin
        assign d_ff[i] = (poly_aux[i] & q_aux) ^ q_ff[i-1];
      end
    end
  endgenerate

  // =======================================================
  // ============     First stage XORs     =================
  // =======================================================

  logic [WIDTH-1:0]     xor_stage_1_temp;

  always_comb begin
    for (int i=0; i<WIDTH; i++) begin
      if          (op_i == FF409) begin
        if      (i <  408)   xor_stage_1_temp[i] = clmul_res[i] ^ clmul_res[409+i];
        else                 xor_stage_1_temp[i] = clmul_res[i];
      end else if (op_i == FF233) begin
        if      (i  < 232)   xor_stage_1_temp[i] = clmul_res[i] ^ clmul_res[233+i];
        else if (i == 232)   xor_stage_1_temp[i] = clmul_res[i];
        else                 xor_stage_1_temp[i] = 1'b0;
      end else if (op_i == FF193) begin
        if      (i  < 192)   xor_stage_1_temp[i] = clmul_res[i] ^ clmul_res[193+i];
        else if (i == 192)   xor_stage_1_temp[i] = clmul_res[i];
        else                 xor_stage_1_temp[i] = 1'b0;
      end else if (op_i == FF113) begin
        if      (i  < 112)   xor_stage_1_temp[i] = clmul_res[i] ^ clmul_res[113+i];
        else if (i == 112)   xor_stage_1_temp[i] = clmul_res[i];
        else                 xor_stage_1_temp[i] = 1'b0;
      end else begin
                             xor_stage_1_temp[i] = 1'b0;
      end
    end
  end
  
  generate 
    for (i=0; i<WIDTH; i++) begin
      assign xor_stage_1[i] = xor_stage_1_temp[i];
    end
  endgenerate


  always_comb begin
    case (op_i)
      FF409:  pm[2*WIDTH-1:0] = {  1'b0, q_ff[407:0], xor_stage_1[408:0]};
      FF233:  pm[2*WIDTH-1:0] = {353'b0, q_ff[231:0], xor_stage_1[232:0]};
      FF193:  pm[2*WIDTH-1:0] = {433'b0, q_ff[191:0], xor_stage_1[192:0]};
      FF113:  pm[2*WIDTH-1:0] = {593'b0, q_ff[111:0], xor_stage_1[112:0]};
    endcase
  end

  // =======================================================
  // ============     Second stage XORs     ================
  // =======================================================
  logic [WIDTH-1:0]     result_temp;

  always_comb begin
    for (int i=0; i<WIDTH; i++) begin
      if            (op_i == FF409) begin
        if      (i  < T_CYCLES_409    )         result_temp[i] = pm[i] ^ pm[409+i];
        else if (i == T_CYCLES_409    )         result_temp[i] = clmul_res[i];
        else                                    result_temp[i] = pm[i] ^ pm[409+i-1];
      end else if   (op_i == FF233) begin
        if      (i  < T_CYCLES_233    )         result_temp[i] = pm[i] ^ pm[233+i];
        else if (i == T_CYCLES_233    )         result_temp[i] = clmul_res[i];
        else if (i  > T_CYCLES_233 && i  < 233) result_temp[i] = pm[i] ^ pm[233+i-1];
        else                                    result_temp[i] = 1'b0;
      end else if   (op_i == FF193) begin
        if      (i  < T_CYCLES_193    )         result_temp[i] = pm[i] ^ pm[193+i];
        else if (i == T_CYCLES_193    )         result_temp[i] = clmul_res[i];
        else if (i  > T_CYCLES_193 && i  < 193) result_temp[i] = pm[i] ^ pm[193+i-1];
        else                                    result_temp[i] = 1'b0;
      end else if   (op_i == FF113) begin
        if      (i  < T_CYCLES_113    )         result_temp[i] = pm[i] ^ pm[113+i];
        else if (i == T_CYCLES_113    )         result_temp[i] = clmul_res[i];
        else if (i  > T_CYCLES_113 && i  < 113) result_temp[i] = pm[i] ^ pm[113+i-1];
        else                                    result_temp[i] = 1'b0;
      end else begin  
                                                result_temp[i] = '0;
      end
    end
  end

  generate 
    for (i=0; i<WIDTH; i++) begin
      assign result[i] = result_temp[i];
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

  always_comb begin
    case (op_i)
      FF409:  counter_value = T_CYCLES_409;
      FF233:  counter_value = T_CYCLES_233+1;
      FF193:  counter_value = T_CYCLES_193+1;
      FF113:  counter_value = T_CYCLES_113+1;
    endcase
  end
 
  always_ff @(posedge clk or negedge rst_n ) begin : COUNTER
    if(!rst_n) begin
      counter   <= '0;
    end else if (!clmul_finish) begin 
      counter   <= '0;
    end else begin
      if (enable_i) begin
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