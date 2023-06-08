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
   input logic  [31:0]   rs2_in                     // RS2
  );

  logic [447:0] opa_r, opb_r;

  logic load_a_start, load_b_start;
  logic load_a_inc  , load_b_inc;
  logic load_a_end  , load_b_end;
  logic opa_load    , opb_load;

  logic [3:0] idxa, idxb;

  logic mula_en, mulb_en, mul_en;

  assign load_a_start = cp.ffloadas;
  assign load_a_inc   = cp.ffloada;
  assign load_a_end   = cp.ffloadae;
  assign load_b_start = cp.ffloadbs;
  assign load_b_inc   = cp.ffloadb;
  assign load_b_end   = cp.ffloadbe;

  assign opa_load     = load_a_start | load_a_inc | load_a_end;
  assign opb_load     = load_b_start | load_b_inc | load_b_end;

  assign mul_en       = mula_en & mulb_en;

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
  // ========  Start conversion flop =================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      mula_en <= 1'b0;
    end else begin
      if (load_a_end) begin
        mula_en <= 1'b1;
      end 
      
      if (load_a_start) begin
        mula_en <= 1'b0;
      end 
    end
  end

  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      mulb_en <= 1'b0;
    end else begin
      if (load_b_end) begin
        mulb_en <= 1'b1;
      end 
      
      if (load_b_start) begin
        mulb_en <= 1'b0;
      end 
    end
  end

  ffmul #(409
  ) u_ffmul (
    .clk(clk),
    .rst_n(rst_l),
    .a_i (opa_r[408:0]),         
    .b_i (opb_r[408:0]),   
    .poly_i ({323'b0,1'b1,86'b0}),
    .enable_i (mul_en),

    .result_o (), 
    .finish_o (),     
    .finish_p_o ()    
  );

endmodule