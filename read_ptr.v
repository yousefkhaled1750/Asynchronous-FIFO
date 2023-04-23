module read_ptr#(parameter ADDR_WIDTH = 4)(

    input   wire                                RST         ,
    input   wire                                R_CLK       ,
    input   wire                                Rinc        ,
    
    output  reg     [ADDR_WIDTH : 0]       read_ptr_grey,    
    output  reg     [ADDR_WIDTH : 0]       read_ptr_reg    

);

    wire    [ADDR_WIDTH : 0]    read_ptr_grey_updated;
    wire    [ADDR_WIDTH : 0]    read_ptr_updated;
    wire    [ADDR_WIDTH : 0]    read_ptr_binary;
    
    always @(posedge R_CLK, negedge RST) begin
        if (!RST) begin
            read_ptr_reg <= 'b0;
        end else begin
            if (Rinc) begin
                read_ptr_reg <= read_ptr_reg + 'b1;
            end 
        end
    end
    



    always @(posedge R_CLK, negedge RST) begin
        if (!RST) begin
            read_ptr_grey <= 'b0;
        end else begin
            if (Rinc) begin
                read_ptr_grey <= read_ptr_grey_updated;
            end 
        end
    end



    
    Binary_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) binary_coding_read(
                                .Grey(read_ptr_grey),
                                .Binary(read_ptr_binary)
    );

    assign read_ptr_updated = read_ptr_binary + 'b1;

    Grey_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) grey_coding_read(
                                .Binary(read_ptr_updated),
                                .Grey(read_ptr_grey_updated)
    );


endmodule