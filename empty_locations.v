module empty_locations #(
    parameter ADDR_WIDTH = 4
) (

    input   wire    [ADDR_WIDTH     : 0]    write_addr,
    input   wire    [ADDR_WIDTH     : 0]    read_addr,
    
    output  reg     [ADDR_WIDTH     : 0]    empty_loc
);

    localparam SIZE = 2**ADDR_WIDTH ;

    
    always @(*) begin
        if (write_addr >= read_addr) begin
            empty_loc = SIZE - (write_addr - read_addr);
        end
        else if (write_addr < read_addr) begin
            empty_loc = read_addr - write_addr;
        end
        else
            empty_loc = SIZE - (write_addr - read_addr);
    end

    
endmodule