module Binary_coding #(
    parameter ADDR_WIDTH = 4
) (
    input wire      [ADDR_WIDTH - 1 : 0]   Grey,

    output wire     [ADDR_WIDTH - 1 : 0]   Binary
);
    
    genvar i;

    assign Binary[ADDR_WIDTH - 1]    = Grey[ADDR_WIDTH - 1];


    generate
        for (i = 0; i < ADDR_WIDTH - 1; i = i + 1)
            begin
                assign Binary[i] = Grey[i] ^ Binary[i+1];
            end
    endgenerate

endmodule