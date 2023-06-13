import ffmul_pkg::*;

module el2_exu_custom_ctl
import el2_pkg::*;
#(
`include "el2_param.vh"
)
  (
   input logic           clk,                       // Top level clock
   input logic           rst_l,                     // Reset
   input logic           scan_mode,                 // Scan mode

   input el2_custom_pkt_t  cp,                      // Custom packet
   input logic  [31:0]   rs1_in,                    // RS1
   input logic  [31:0]   rs2_in,                    // RS2
   output logic  [31:0]   result_o,                 // Result
   output logic           finish_o
  );

  logic [447:0] opa_r, opb_r;

  logic load_a_start, load_b_start;
  logic load_a_inc  , load_b_inc;
  logic load_a_end  , load_b_end;
  logic opa_load    , opb_load;
  logic op_load;
  logic op_mul;

  logic ffmul_finish, finish, finish_d, finish_dd;
  logic [31:0] result_ff;

  logic [4:0] idxa, idxb, idxmul;

  logic mul_en;

  assign load_a_start = cp.ffloadas;
  assign load_a_inc   = cp.ffloada;
  assign load_a_end   = cp.ffloadae;
  assign load_b_start = cp.ffloadbs;
  assign load_b_inc   = cp.ffloadb;
  assign load_b_end   = cp.ffloadbe;

  assign opa_load     = load_a_start | load_a_inc | load_a_end;
  assign opb_load     = load_b_start | load_b_inc | load_b_end;
  assign op_load      = opa_load     | opb_load;

  assign op_mul       = cp.ffmul1    | cp.ffmul2  | cp.ffmul3 | cp.ffmul4;

  // =================================================
  // ============= Register load =====================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      opa_r <= '0;
    end else begin
      if (load_a_start) begin
        opa_r[63:0]        <= {rs2_in[31:0],rs1_in[31:0]};
      end else if (opa_load) begin
        opa_r[idxa*64 +:64] <= {rs2_in[31:0],rs1_in[31:0]};
      end else begin
        opa_r[447:0]       <= opa_r[447:0];
      end
    end
  end

  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      opb_r <= '0;
    end else begin
      if (load_b_start) begin
        opb_r[63:0]        <= {rs2_in[31:0],rs1_in[31:0]};
      end else if (opb_load) begin
        opb_r[idxb*64 +:64] <= {rs2_in[31:0],rs1_in[31:0]};
      end else begin
        opb_r[447:0]       <= opb_r[447:0];
      end
    end
  end

  // =================================================
  // =================== Counter =====================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      idxa <= '0;
    end else begin
      if (load_a_end) begin
        idxa <= '0;
      end else if (load_a_start) begin
        idxa <= 'b1;
      end else if (load_a_inc  ) begin
        idxa <= idxa + 'b1;
      end else begin
        idxa <= idxa;
      end
    end
  end

  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      idxb <= '0;
    end else begin
      if (load_b_end) begin
        idxb <= '0;
      end else if (load_b_start) begin
        idxb <= 'b1;
      end else if (load_b_inc  ) begin
        idxb <= idxb + 'b1;
      end else begin
        idxb <= idxb;
      end
    end
  end

  // =================================================
  // ==================== Opcode =====================
  // =================================================
  logic [1:0] opcode;

  always_comb begin
    if      (cp.ffmul1)    opcode = FF409;
    else if (cp.ffmul2)    opcode = FF233;
    else if (cp.ffmul3)    opcode = FF193;
    else if (cp.ffmul4)    opcode = FF113;
    else                   opcode = FF409;
  end

  // =================================================
  // ========  Start conversion flop =================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      mul_en <= 1'b0;
    end else begin
      if (op_mul) begin
        mul_en <= 1'b1;
      end 
      
      if (op_load) begin
        mul_en <= 1'b0;
      end 
    end
  end

  logic [408:0] result;
  ffmul u_ffmul (
    .clk(clk),
    .rst_n(rst_l),
    .a_i (opa_r[408:0]),         
    .b_i (opb_r[408:0]),   
    .op_i (opcode),
    .enable_i (mul_en),

    .result_o (result), 
    .finish_o (),     
    .finish_p_o (ffmul_finish)    
  );

  // =================================================
  // =================== Result ======================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      idxmul <= '0;
    end else begin
      if (op_load) begin
        idxmul <= '0;
      end else if (op_mul) begin
        idxmul <= idxmul + 'b1;
      end else begin
        idxmul <= idxmul;
      end
    end
  end

  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      finish    <= 1'b0;
      finish_d  <= 1'b0;
      finish_dd <= 1'b0;
    end else begin
      if ((idxmul != 0) && op_mul) begin
        finish <= 1'b1;
      end else begin
        finish <= 1'b0;
      end
      finish_d  <= finish;
      finish_dd <= finish_d;
    end
  end

  assign finish_o = finish_dd | ffmul_finish;
  assign result_o[31:0] = (idxmul<'d2) ? result[31:0] : result_ff[31:0];

  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      result_ff <= '0;
    end else begin
      if (op_mul) begin
        result_ff[31:0] <= result[idxmul*32 +:32];
      end 
    end
  end

endmodule