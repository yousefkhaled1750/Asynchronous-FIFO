module FIFO_CMP  #(parameter ADDR_WIDTH = 4)(
    input   wire    [ADDR_WIDTH : 0]            write_addr,
    input   wire    [ADDR_WIDTH : 0]            write_addr_sync,
    input   wire    [ADDR_WIDTH : 0]            read_addr,
    input   wire    [ADDR_WIDTH : 0]            read_addr_sync,

    output  reg                                 FULL_flag,
    output  reg                                 EMPTY_flag        
);


    //FULL block
    always @(*) begin
        if(write_addr[ADDR_WIDTH - 1 : 0] == read_addr_sync[ADDR_WIDTH - 1 : 0] &&write_addr[ADDR_WIDTH] != read_addr_sync[ADDR_WIDTH] )
            FULL_flag = 1;
        else
            FULL_flag = 0;
    end
    

    //EMPTY block
    always @(*) begin
        if(read_addr == write_addr_sync)
            EMPTY_flag = 1;
        else
            EMPTY_flag = 0;
    end


endmodule