module FIFO (
    input   wire    [7:0]   Data_in,
    input   wire            W_EN,
    input   wire            W_CLK,
    
    input   wire            R_EN,
    input   wire            R_CLK,

    input   wire            RST,

    output  wire    [7:0]   Data_out,
    output  wire            FULL_flag,
    output  wire            EMPTY_flag
);
    
    wire    [3:0]   write_ptr, read_ptr;
    wire    [3:0]   write_ptr_grey, read_ptr_grey;
    wire    [3:0]   write_ptr_sync, read_ptr_sync;
    //module write_ptr(
//
    //input   wire                RST         ,
    //input   wire                W_CLK         ,
    //input   wire                Winc        ,
    //
    //output  reg     [3:0]       write_addr  ,
//
    //);

write_ptr write_ptr_module (
                            .RST(RST),       
                            .W_CLK(W_CLK),     
                            .Winc(W_EN),
                            .FULL_flag(FULL_flag),   
                            .write_addr(write_ptr) 
);


//module read_ptr(
//
//    input   wire                RST         ,
//    input   wire                R_CLK       ,
//    input   wire                Rinc        ,
//    
//    output  reg     [3:0]       read_addr   ,
//
//);


read_ptr read_ptr_module (
                            .RST(RST),       
                            .R_CLK(R_CLK),     
                            .Rinc(R_EN),  
                            .EMPTY_flag(EMPTY_flag), 
                            .read_addr(read_ptr) 
);


//module Grey_coding(
//    input wire      [3:0]   Binary,
//
//    output wire     [3:0]   Grey
//);

Grey_coding Grey_coding_write(
                                .Binary(write_ptr),
                                .Grey(write_ptr_grey)
);

Grey_coding Grey_coding_read(
                                .Binary(read_ptr),
                                .Grey(read_ptr_grey)
);


//module FIFO_CMP  (
//    input   wire    [3:0]       write_addr,
//    input   wire    [3:0]       write_addr_sync,
//    input   wire    [3:0]       read_addr,
//    input   wire    [3:0]       read_addr_sync,
//    input   wire                RST,
//
//    output  reg                 FULL_flag,
//    output  reg                 EMPTY_flag        
//);

FIFO_CMP FIFO_CMP_module(
                            .write_addr(write_ptr_grey),
                            .write_addr_sync(write_ptr_sync),
                            .read_addr(read_ptr_grey),
                            .read_addr_sync(read_ptr_sync),
                            .RST(RST),
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

BUS_SYNC    BUS_SYNC_write(
                            .ASYNC(write_ptr_grey)   ,
                            .CLK(R_CLK)     ,
                            .RST(RST)     ,
                            .SYNC(write_ptr_sync)    
);


BUS_SYNC    BUS_SYNC_read(
                            .ASYNC(read_ptr_grey)   ,
                            .CLK(W_CLK)     ,
                            .RST(RST)     ,
                            .SYNC(read_ptr_sync)    
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

RAM_module  U0 (
                .Data_in(Data_in),
                .write_addr(write_ptr),
                .raed_addr(read_ptr),
                .WEN(W_EN),
                .CLK(W_CLK),
                .RST(RST),
                .Data_out(Data_out)
);




endmodule