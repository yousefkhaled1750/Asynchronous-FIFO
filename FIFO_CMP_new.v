module FIFO_CMP_new  #(parameter ADDR_WIDTH = 4)(


    input   wire    [ADDR_WIDTH     : 0]        empty_loc,

    output  reg                                 FULL_flag,
    output  reg                                 EMPTY_flag        
);

    localparam SIZE = 2**ADDR_WIDTH ;

    // full logic
    always @(* ) begin
        if(empty_loc == 'd0)
            FULL_flag <= 1'b1;
        else
            FULL_flag <= 1'b0;
    end


    // empty logic
    always @(* ) begin
        if( empty_loc == SIZE)
            EMPTY_flag <= 1'b1;
        else
            EMPTY_flag <= 1'b0;
    end

    
endmodule