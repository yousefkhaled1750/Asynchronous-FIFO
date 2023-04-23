module Tx_FIFO #(parameter DATA_WIDTH = 49, ADDR_WIDTH = 4) (
    input   wire    [DATA_WIDTH - 1 : 0]        Data_in,
    input   wire                                W_EN,
    input   wire                                W_CLK,

    input   wire                                R_EN,
    input   wire                                R_CLK,

    input   wire                                W_RST,
    input   wire                                R_RST,

    output  wire    [DATA_WIDTH - 1 : 0]        Data_out,
    output  wire                                FULL_flag,
    output  wire                                EMPTY_flag,
    output  wire    [ADDR_WIDTH     : 0]        empty_loc
);
    
    wire    [ADDR_WIDTH : 0]   write_ptr_reg, read_ptr_reg;
    wire    [ADDR_WIDTH : 0]   write_ptr_grey, read_ptr_grey;
    wire    [ADDR_WIDTH : 0]   write_ptr_sync, read_ptr_sync;
    wire    [ADDR_WIDTH : 0]   write_ptr_grey_sync, read_ptr_grey_sync;


    wire    [DATA_WIDTH - 1 : 0]        s_Data_out;
    assign  Data_out = EMPTY_flag? 'b0: s_Data_out;

//module write_ptr #(parameter ADDR_WIDTH = 4)(
//
//    input   wire                                RST         ,
//    input   wire                                W_CLK       ,
//    input   wire                                Winc        ,
//    output  reg    [ADDR_WIDTH - 1 : 0]         write_ptr_reg,    
//    output  reg    [ADDR_WIDTH - 1 : 0]         write_ptr_grey 
//
//);


write_ptr #(.ADDR_WIDTH (ADDR_WIDTH)) write_ptr_module (
                            .RST(W_RST),       
                            .W_CLK(W_CLK),     
                            .Winc(W_EN),
                            .write_ptr_reg(write_ptr_reg),
                            .write_ptr_grey(write_ptr_grey)
);


//module read_ptr#(parameter ADDR_WIDTH = 4)(
//
//    input   wire                                RST         ,
//    input   wire                                R_CLK       ,
//    input   wire                                Rinc        ,
//    output  reg     [ADDR_WIDTH - 1 : 0]       read_ptr_reg , 
//    output  reg     [ADDR_WIDTH - 1 : 0]       read_ptr_grey    
//
//);


read_ptr #(.ADDR_WIDTH (ADDR_WIDTH)) read_ptr_module (
                            .RST(R_RST),       
                            .R_CLK(R_CLK),     
                            .Rinc(R_EN),  
                            .read_ptr_reg(read_ptr_reg),
                            .read_ptr_grey(read_ptr_grey)
);




//module FIFO_CMP  #(parameter ADDR_WIDTH = 4)(
//    input   wire    [ADDR_WIDTH : 0]            write_addr,
//    input   wire    [ADDR_WIDTH : 0]            write_addr_sync,
//    input   wire    [ADDR_WIDTH : 0]            read_addr,
//    input   wire    [ADDR_WIDTH : 0]            read_addr_sync,
//
//    output  reg                                 FULL_flag,
//    output  reg                                 EMPTY_flag        
//);

FIFO_CMP #(.ADDR_WIDTH(ADDR_WIDTH)) FIFO_CMP_module (
.write_addr(write_ptr_reg),
.write_addr_sync(write_ptr_sync),
.read_addr(read_ptr_reg),
.read_addr_sync(read_ptr_sync),
.FULL_flag(FULL_flag),
.EMPTY_flag(EMPTY_flag)           
);


//module BUS_SYNC #(parameter NUM_STAGES = 2, parameter BUS_WIDTH = 4)
//(
//    input   wire    [BUS_WIDTH - 1 : 0]     ASYNC   ,
//    input   wire                            CLK     ,
//    input   wire                            RST     ,
//    output  wire    [BUS_WIDTH - 1 : 0]     SYNC    
//);

BUS_SYNC #(.NUM_STAGES(2), .BUS_WIDTH(ADDR_WIDTH + 1))    BUS_SYNC_write(    //Bus width is the address width
                            .ASYNC(write_ptr_grey)   ,
                            .CLK(R_CLK)     ,
                            .RST(R_RST)     ,
                            .SYNC(write_ptr_grey_sync)    
);


BUS_SYNC  #(.NUM_STAGES(2), .BUS_WIDTH(ADDR_WIDTH + 1))  BUS_SYNC_read(
                            .ASYNC(read_ptr_grey)   ,
                            .CLK(W_CLK)     ,
                            .RST(W_RST)     ,
                            .SYNC(read_ptr_grey_sync)    
);


Binary_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) G_B_write (
                .Grey(write_ptr_grey_sync),
                .Binary(write_ptr_sync)
);

Binary_coding #(.ADDR_WIDTH(ADDR_WIDTH + 1)) G_B_read (
                .Grey(read_ptr_grey_sync),
                .Binary(read_ptr_sync)
);





//module empty_locations #(
//    parameter ADDR_WIDTH = 4
//) (
//    input   wire    [ADDR_WIDTH     : 0]    write_addr,
//    input   wire    [ADDR_WIDTH     : 0]    read_addr,
//    
//    output  reg     [ADDR_WIDTH     : 0]    empty_loc
//);

empty_locations #(.ADDR_WIDTH(ADDR_WIDTH)) emp_loc_cal (
                .write_addr(write_ptr_reg),
                .read_addr(read_ptr_sync),
                .empty_loc(empty_loc)    
);



//module RAM_module  #(parameter DATA_WIDTH = 8, ADDR_WIDTH = 4)
//(
//    input   wire    [DATA_WIDTH - 1:0]      Data_in,
//    input   wire    [ADDR_WIDTH - 1:0]      write_addr,
//    input   wire    [ADDR_WIDTH - 1:0]      raed_addr,
//    input   wire                            WEN,
//    input   wire                            CLK,
//    input   wire                            RST,
//
//    output  wire    [DATA_WIDTH - 1:0]      Data_out
//);

RAM_module #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))  U0 (
                .Data_in(Data_in),
                .write_addr(write_ptr_reg[ADDR_WIDTH - 1 : 0]),
                .raed_addr(read_ptr_reg[ADDR_WIDTH - 1 : 0]),
                .WEN(W_EN),
                .CLK(W_CLK),
                .RST(W_RST),
                .Data_out(s_Data_out)
);




endmodule