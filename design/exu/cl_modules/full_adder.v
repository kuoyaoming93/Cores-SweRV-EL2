module full_adder(
    input a,
    input b,
    input ci,
    output sum,
    output co
);

assign sum = a ^ b ^ ci;
assign co = (a & b) | (a & ci) | (b & ci);

endmodule

