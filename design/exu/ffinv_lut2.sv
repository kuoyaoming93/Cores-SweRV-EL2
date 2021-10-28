module ffinv_lut2 #(
) (
    input [31:0]          inv_in,             // Entrada 1
    output [31:0]         out                 // Salida normal
);

    reg [7:0] mem [0:255];

    assign mem[0] = 8'd255;
    assign mem[1] = 8'd254;
    assign mem[2] = 8'd253;
    assign mem[3] = 8'd252;
    assign mem[4] = 8'd251;
    assign mem[5] = 8'd250;
    assign mem[6] = 8'd249;
    assign mem[7] = 8'd248;
    assign mem[8] = 8'd247;
    assign mem[9] = 8'd246;
    assign mem[10] = 8'd245;
    assign mem[11] = 8'd244;
    assign mem[12] = 8'd243;
    assign mem[13] = 8'd242;
    assign mem[14] = 8'd241;
    assign mem[15] = 8'd240;
    assign mem[16] = 8'd239;
    assign mem[17] = 8'd238;
    assign mem[18] = 8'd237;
    assign mem[19] = 8'd236;
    assign mem[20] = 8'd235;
    assign mem[21] = 8'd234;
    assign mem[22] = 8'd233;
    assign mem[23] = 8'd232;
    assign mem[24] = 8'd231;
    assign mem[25] = 8'd230;
    assign mem[26] = 8'd229;
    assign mem[27] = 8'd228;
    assign mem[28] = 8'd227;
    assign mem[29] = 8'd226;
    assign mem[30] = 8'd225;
    assign mem[31] = 8'd224;
    assign mem[32] = 8'd223;
    assign mem[33] = 8'd222;
    assign mem[34] = 8'd221;
    assign mem[35] = 8'd220;
    assign mem[36] = 8'd219;
    assign mem[37] = 8'd218;
    assign mem[38] = 8'd217;
    assign mem[39] = 8'd216;
    assign mem[40] = 8'd215;
    assign mem[41] = 8'd214;
    assign mem[42] = 8'd213;
    assign mem[43] = 8'd212;
    assign mem[44] = 8'd211;
    assign mem[45] = 8'd210;
    assign mem[46] = 8'd209;
    assign mem[47] = 8'd208;
    assign mem[48] = 8'd207;
    assign mem[49] = 8'd206;
    assign mem[50] = 8'd205;
    assign mem[51] = 8'd204;
    assign mem[52] = 8'd203;
    assign mem[53] = 8'd202;
    assign mem[54] = 8'd201;
    assign mem[55] = 8'd200;
    assign mem[56] = 8'd199;
    assign mem[57] = 8'd198;
    assign mem[58] = 8'd197;
    assign mem[59] = 8'd196;
    assign mem[60] = 8'd195;
    assign mem[61] = 8'd194;
    assign mem[62] = 8'd193;
    assign mem[63] = 8'd192;
    assign mem[64] = 8'd191;
    assign mem[65] = 8'd190;
    assign mem[66] = 8'd189;
    assign mem[67] = 8'd188;
    assign mem[68] = 8'd187;
    assign mem[69] = 8'd186;
    assign mem[70] = 8'd185;
    assign mem[71] = 8'd184;
    assign mem[72] = 8'd183;
    assign mem[73] = 8'd182;
    assign mem[74] = 8'd181;
    assign mem[75] = 8'd180;
    assign mem[76] = 8'd179;
    assign mem[77] = 8'd178;
    assign mem[78] = 8'd177;
    assign mem[79] = 8'd176;
    assign mem[80] = 8'd175;
    assign mem[81] = 8'd174;
    assign mem[82] = 8'd173;
    assign mem[83] = 8'd172;
    assign mem[84] = 8'd171;
    assign mem[85] = 8'd170;
    assign mem[86] = 8'd169;
    assign mem[87] = 8'd168;
    assign mem[88] = 8'd167;
    assign mem[89] = 8'd166;
    assign mem[90] = 8'd165;
    assign mem[91] = 8'd164;
    assign mem[92] = 8'd163;
    assign mem[93] = 8'd162;
    assign mem[94] = 8'd161;
    assign mem[95] = 8'd160;
    assign mem[96] = 8'd159;
    assign mem[97] = 8'd158;
    assign mem[98] = 8'd157;
    assign mem[99] = 8'd156;
    assign mem[100] = 8'd155;
    assign mem[101] = 8'd154;
    assign mem[102] = 8'd153;
    assign mem[103] = 8'd152;
    assign mem[104] = 8'd151;
    assign mem[105] = 8'd150;
    assign mem[106] = 8'd149;
    assign mem[107] = 8'd148;
    assign mem[108] = 8'd147;
    assign mem[109] = 8'd146;
    assign mem[110] = 8'd145;
    assign mem[111] = 8'd144;
    assign mem[112] = 8'd143;
    assign mem[113] = 8'd142;
    assign mem[114] = 8'd141;
    assign mem[115] = 8'd140;
    assign mem[116] = 8'd139;
    assign mem[117] = 8'd138;
    assign mem[118] = 8'd137;
    assign mem[119] = 8'd136;
    assign mem[120] = 8'd135;
    assign mem[121] = 8'd134;
    assign mem[122] = 8'd133;
    assign mem[123] = 8'd132;
    assign mem[124] = 8'd131;
    assign mem[125] = 8'd130;
    assign mem[126] = 8'd129;
    assign mem[127] = 8'd128;
    assign mem[128] = 8'd127;
    assign mem[129] = 8'd126;
    assign mem[130] = 8'd125;
    assign mem[131] = 8'd124;
    assign mem[132] = 8'd123;
    assign mem[133] = 8'd122;
    assign mem[134] = 8'd121;
    assign mem[135] = 8'd120;
    assign mem[136] = 8'd119;
    assign mem[137] = 8'd118;
    assign mem[138] = 8'd117;
    assign mem[139] = 8'd116;
    assign mem[140] = 8'd115;
    assign mem[141] = 8'd114;
    assign mem[142] = 8'd113;
    assign mem[143] = 8'd112;
    assign mem[144] = 8'd111;
    assign mem[145] = 8'd110;
    assign mem[146] = 8'd109;
    assign mem[147] = 8'd108;
    assign mem[148] = 8'd107;
    assign mem[149] = 8'd106;
    assign mem[150] = 8'd105;
    assign mem[151] = 8'd104;
    assign mem[152] = 8'd103;
    assign mem[153] = 8'd102;
    assign mem[154] = 8'd101;
    assign mem[155] = 8'd100;
    assign mem[156] = 8'd99;
    assign mem[157] = 8'd98;
    assign mem[158] = 8'd97;
    assign mem[159] = 8'd96;
    assign mem[160] = 8'd95;
    assign mem[161] = 8'd94;
    assign mem[162] = 8'd93;
    assign mem[163] = 8'd92;
    assign mem[164] = 8'd91;
    assign mem[165] = 8'd90;
    assign mem[166] = 8'd89;
    assign mem[167] = 8'd88;
    assign mem[168] = 8'd87;
    assign mem[169] = 8'd86;
    assign mem[170] = 8'd85;
    assign mem[171] = 8'd84;
    assign mem[172] = 8'd83;
    assign mem[173] = 8'd82;
    assign mem[174] = 8'd81;
    assign mem[175] = 8'd80;
    assign mem[176] = 8'd79;
    assign mem[177] = 8'd78;
    assign mem[178] = 8'd77;
    assign mem[179] = 8'd76;
    assign mem[180] = 8'd75;
    assign mem[181] = 8'd74;
    assign mem[182] = 8'd73;
    assign mem[183] = 8'd72;
    assign mem[184] = 8'd71;
    assign mem[185] = 8'd70;
    assign mem[186] = 8'd69;
    assign mem[187] = 8'd68;
    assign mem[188] = 8'd67;
    assign mem[189] = 8'd66;
    assign mem[190] = 8'd65;
    assign mem[191] = 8'd64;
    assign mem[192] = 8'd63;
    assign mem[193] = 8'd62;
    assign mem[194] = 8'd61;
    assign mem[195] = 8'd60;
    assign mem[196] = 8'd59;
    assign mem[197] = 8'd58;
    assign mem[198] = 8'd57;
    assign mem[199] = 8'd56;
    assign mem[200] = 8'd55;
    assign mem[201] = 8'd54;
    assign mem[202] = 8'd53;
    assign mem[203] = 8'd52;
    assign mem[204] = 8'd51;
    assign mem[205] = 8'd50;
    assign mem[206] = 8'd49;
    assign mem[207] = 8'd48;
    assign mem[208] = 8'd47;
    assign mem[209] = 8'd46;
    assign mem[210] = 8'd45;
    assign mem[211] = 8'd44;
    assign mem[212] = 8'd43;
    assign mem[213] = 8'd42;
    assign mem[214] = 8'd41;
    assign mem[215] = 8'd40;
    assign mem[216] = 8'd39;
    assign mem[217] = 8'd38;
    assign mem[218] = 8'd37;
    assign mem[219] = 8'd36;
    assign mem[220] = 8'd35;
    assign mem[221] = 8'd34;
    assign mem[222] = 8'd33;
    assign mem[223] = 8'd32;
    assign mem[224] = 8'd31;
    assign mem[225] = 8'd30;
    assign mem[226] = 8'd29;
    assign mem[227] = 8'd28;
    assign mem[228] = 8'd27;
    assign mem[229] = 8'd26;
    assign mem[230] = 8'd25;
    assign mem[231] = 8'd24;
    assign mem[232] = 8'd23;
    assign mem[233] = 8'd22;
    assign mem[234] = 8'd21;
    assign mem[235] = 8'd20;
    assign mem[236] = 8'd19;
    assign mem[237] = 8'd18;
    assign mem[238] = 8'd17;
    assign mem[239] = 8'd16;
    assign mem[240] = 8'd15;
    assign mem[241] = 8'd14;
    assign mem[242] = 8'd13;
    assign mem[243] = 8'd12;
    assign mem[244] = 8'd11;
    assign mem[245] = 8'd10;
    assign mem[246] = 8'd9;
    assign mem[247] = 8'd8;
    assign mem[248] = 8'd7;
    assign mem[249] = 8'd6;
    assign mem[250] = 8'd5;
    assign mem[251] = 8'd4;
    assign mem[252] = 8'd3;
    assign mem[253] = 8'd2;
    assign mem[254] = 8'd1;
    assign mem[255] = 8'd0;

    assign out = {24'b0,mem[inv_in[7:0]]};

endmodule