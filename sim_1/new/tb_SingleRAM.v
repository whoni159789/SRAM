`timescale 1ns / 1ps

module tb_SingleRAM();

    reg i_clk =  1'b0;
    reg i_ce;
    // reg i_wr;
    reg i_rw;
    reg [5:0] i_addr;
    wire [7:0] io_data;

    reg [7:0] i_data;
    // wire [7:0] o_data;

    // SingleRAM DUT(
    //     .i_clk(i_clk),
    //     .i_ce(i_ce),
    //     .i_wr(i_wr),
    //     .i_addr(i_addr),
    //     .i_data(i_data),
    //     .o_data(o_data)
    // );
    staticRAM DUT(
        .i_clk(i_clk),
        .i_ce(i_ce),
        .i_rw(i_rw),
        .i_addr(i_addr),
        .io_data(io_data)
    );
    
    // MCU 기준
    assign io_data = (!i_rw) ? i_data : 8'bz;

    always #5 i_clk = ~i_clk;

    initial begin
        // Initialization of Inputs
        i_clk  = 0;
        i_ce   = 0;
        i_rw   = 0;
        i_addr = 0;
        i_data = 0;
        
        /*
            i_rw = 1 -> Read from RAM = Write to MCU
            i_rw = 0 -> Write to RAM = Read from MCU
        */

        // Write to RAM = Read from MCU
        #20 i_ce = 1; i_rw = 0;

        for (integer  i=0; i <64; i = i+1) begin
            #20 i_addr = i; i_data = i + 1;
        end

        // Read from RAM = Write to MCU
        #20 i_rw = 1;

        for (integer  i=0; i <64; i = i+1) begin
            #20 i_addr = i;
        end
        #20 $finish;
    end
endmodule  
