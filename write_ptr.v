module write_ptr(

    input   wire                RST         ,
    input   wire                W_CLK         ,
    input   wire                Winc        ,
    input   wire                FULL_flag,

    output  reg     [3:0]       write_addr  

);

    always @(posedge W_CLK, negedge RST) begin
        if (!RST) begin
            write_addr <= 4'b0;
        end else begin
            if (Winc & ~FULL_flag) begin
                write_addr <= write_addr + 4'b1;
            end else begin
                write_addr <= write_addr;
            end
        end
    end




endmodule