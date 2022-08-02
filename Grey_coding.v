module Grey_coding(
    input wire      [3:0]   Binary,

    output wire     [3:0]   Grey
);


    assign Grey[0] = Binary[0] ^ Binary[1];
    assign Grey[1] = Binary[1] ^ Binary[2];
    assign Grey[2] = Binary[2] ^ Binary[3];
    assign Grey[3] = Binary[3];


endmodule