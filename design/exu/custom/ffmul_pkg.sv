package ffmul_pkg;

typedef enum logic [1:0] {
                          FF409     = 2'b00,
                          FF233     = 2'b01,
                          FF193     = 2'b10,
                          FF113     = 2'b11
                        } ffmul_op_t;

localparam WIDTH    = 409;

localparam T_CYCLES_409 = 86;
localparam T_CYCLES_233 = 73;                        
localparam T_CYCLES_193 = 14;
localparam T_CYCLES_113 = 8;

  
endpackage