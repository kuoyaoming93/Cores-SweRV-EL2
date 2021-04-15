module cl_half_adder(
    input carry_option,
    input a,
    input b,
    output sum,
    output co
);

assign sum = a ^ b;
assign co = carry_option ? a & b : 1'b0;

endmodule