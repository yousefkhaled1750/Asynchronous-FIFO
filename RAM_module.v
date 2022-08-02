module RAM_module  #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 4)
(
    input   wire    [DATA_WIDTH - 1:0]      Data_in,
    input   wire    [ADDR_WIDTH - 1:0]      write_addr,
    input   wire    [ADDR_WIDTH - 1:0]      raed_addr,
    input   wire                            WEN,
    input   wire                            CLK,
    input   wire                            RST,

    output  wire    [DATA_WIDTH - 1:0]      Data_out
);

reg [DATA_WIDTH - 1 : 0] RAM [2**ADDR_WIDTH - 1 : 0];
integer k;


assign  Data_out = RAM[raed_addr];


always @(posedge CLK , negedge RST) begin
    if (!RST) begin
        for(k = 0; k < 2**ADDR_WIDTH; k = k + 1) 
            begin
                RAM[k] <= 'b0;
            end
    end else begin
        if(WEN)     RAM[write_addr] <= Data_in;
    end
end






endmodule 