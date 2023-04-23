module write_ptr #(parameter ADDR_WIDTH = 4)(

    input   wire                                RST         ,
    input   wire                                W_CLK       ,
    input   wire                                Winc        ,

    output  reg    [ADDR_WIDTH : 0]         write_ptr_grey,
    output  reg    [ADDR_WIDTH : 0]         write_ptr_reg  
      

);

    wire    [ADDR_WIDTH : 0]    write_ptr_grey_updated;
    wire    [ADDR_WIDTH : 0]    write_ptr_updated;
    wire    [ADDR_WIDTH : 0]    write_ptr_binary;
    
    always @(posedge W_CLK, negedge RST) begin
        if (!RST) begin
            write_ptr_reg <= 'b0;
        end else begin
            if (Winc) begin
                write_ptr_reg <= write_ptr_reg + 'b1;
            end
        end
    end
    
    
    
    always @(posedge W_CLK, negedge RST) begin
        if (!RST) begin
            write_ptr_grey <= 'b0;
        end else begin
            if (Winc) begin
                write_ptr_grey <= write_ptr_grey_updated;
            end
        end
    end


    
    Binary_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) binary_coding_write(
                                .Grey(write_ptr_grey),
                                .Binary(write_ptr_binary)
    );

    assign write_ptr_updated = write_ptr_binary + 'b1;

    Grey_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) grey_coding_write(
                                .Binary(write_ptr_updated),
                                .Grey(write_ptr_grey_updated)
    );


endmodule