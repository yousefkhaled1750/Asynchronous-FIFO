module read_ptr(

    input   wire                RST         ,
    input   wire                R_CLK       ,
    input   wire                Rinc        ,
    input   wire                EMPTY_flag  ,
    output  reg     [3:0]       read_addr   

);

    always @(posedge R_CLK, negedge RST) begin
        if (!RST) begin
            read_addr <= 4'b0;
        end else begin
            if (Rinc & ~EMPTY_flag) begin
                read_addr <= read_addr + 4'b1;
            end else begin
                read_addr <= read_addr;
            end
        end
    end




endmodule