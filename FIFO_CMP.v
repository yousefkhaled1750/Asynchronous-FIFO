module FIFO_CMP  (
    input   wire    [3:0]       write_addr,
    input   wire    [3:0]       write_addr_sync,
    input   wire    [3:0]       read_addr,
    input   wire    [3:0]       read_addr_sync,
    input   wire                RST,

    output  reg                 FULL_flag,
    output  reg                 EMPTY_flag        
);


    //FULL block
    always @(negedge RST, write_addr, read_addr_sync) begin
        if (!RST) begin
            FULL_flag  <= 0;
        end else begin
            if(write_addr == read_addr_sync)
                FULL_flag <= 1;
            else
                FULL_flag <= 0;
        end
    end
    

    //EMPTY block
    always @( RST, read_addr, write_addr_sync) begin
        if (!RST) begin
            EMPTY_flag  <= 1;
        end else begin
            if(read_addr == write_addr_sync)
                EMPTY_flag <= 1;
            else
                EMPTY_flag <= 0;
        end
    end


endmodule