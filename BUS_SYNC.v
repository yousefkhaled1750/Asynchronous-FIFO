module BUS_SYNC #(parameter NUM_STAGES = 2, parameter BUS_WIDTH = 4)
(
    input   wire    [BUS_WIDTH - 1 : 0]     ASYNC   ,
    input   wire                            CLK     ,
    input   wire                            RST     ,
    output  wire    [BUS_WIDTH - 1 : 0]     SYNC    
);

    genvar  i;

    for (i = 0 ; i < BUS_WIDTH ; i = i + 1 ) begin
        BIT_SYNC    #(.NUM_STAGES(NUM_STAGES))  U0  (.ASYNC(ASYNC[i]), .CLK(CLK), .RST(RST), .SYNC(SYNC[i]));
    end


endmodule