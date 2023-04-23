module Grey_coding #(parameter ADDR_WIDTH = 4)(
    input wire      [ADDR_WIDTH - 1 : 0]   Binary,

    output wire     [ADDR_WIDTH - 1 : 0]   Grey
);

    genvar i;
    

    assign Grey[ADDR_WIDTH - 1]    = Binary[ADDR_WIDTH - 1];


    generate 
        for (i = 0; i < ADDR_WIDTH - 1; i = i + 1)
            begin
                assign Grey[i] = Binary[i] ^ Binary[i+1];
            end
    endgenerate


endmodule