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
   input logic  [31:0]   rs1_in,                       // RS1
   input logic  [31:0]   rs2_in
  );

  logic [447:0] op_r;

  logic load_start;
  logic load_inc;
  logic load_end;
  logic op_load;

  logic [3:0] idx;

  logic mul_en;

  assign load_start = cp.ffloads;
  assign load_inc   = cp.ffload;
  assign load_end   = cp.ffloade;

  assign op_load    = load_start | load_inc | load_end;

  // =================================================
  // ============= Register load =====================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      op_r <= '0;
    end else begin
      if (load_start) begin
        op_r[63:0]        <= {rs2_in[31:0],rs1_in[31:0]};
      end else if (op_load) begin
        op_r[idx*64 +:64] <= {rs2_in[31:0],rs1_in[31:0]};
      end else begin
        op_r[447:0]       <= op_r[447:0];
      end
    end
  end

  // =================================================
  // =================== Counter =====================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      idx <= '0;
    end else begin
      if (load_end) begin
        idx <= '0;
      end else if (load_start) begin
        idx <= 'b1;
      end else if (load_inc  ) begin
        idx <= idx + 'b1;
      end else begin
        idx <= idx;
      end
    end
  end

  // =================================================
  // ========  Start conversion flop =================
  // =================================================
  always_ff @(posedge clk or negedge rst_l) begin
    if (!rst_l) begin
      mul_en <= 1'b0;
    end else begin
      if (load_end) begin
        mul_en <= 1'b1;
      end 
      
      if (load_start) begin
        mul_en <= 1'b0;
      end 
    end
  end

endmodule