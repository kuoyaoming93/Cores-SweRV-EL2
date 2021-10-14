module red12 (
    input   [23:0]          s,               // Polinomio a reducir
    output  [11:0]          c               // Salida
);
    //logic [23:0] s;
    //logic [11:0] c;

    //assign s[23:0] = reduc_in[23:0];
    //assign c[11:0] = reduc_out[11:0];

    assign c[0]    = s[0]  ^ s[12] ^ s[21];
    assign c[1]    = s[1]  ^ s[13] ^ s[22];
    assign c[2]    = s[2]  ^ s[14] ^ s[23];
    assign c[3]    = s[3]  ^ s[15] ^ s[12] ^ s[21];
    assign c[4]    = s[4]  ^ s[16] ^ s[13] ^ s[22];
    assign c[5]    = s[5]  ^ s[17] ^ s[14];
    assign c[6]    = s[6]  ^ s[18] ^ s[15];
    assign c[7]    = s[7]  ^ s[19] ^ s[16];
    assign c[8]    = s[8]  ^ s[20] ^ s[17];
    assign c[9]    = s[9]  ^ s[21] ^ s[18];
    assign c[10]   = s[10] ^ s[22] ^ s[19];
    assign c[11]   = s[11] ^ s[20];

endmodule