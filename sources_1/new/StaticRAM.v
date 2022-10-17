`timescale 1ns / 1ps

module staticRAM(
    input i_clk,
    input i_ce,
    input i_rw,
    input [5:0] i_addr,
    inout [7:0] io_data
    );

    reg [7:0] mem[0:63]; // 64Byte Memory
    reg [5:0] r_addr;

    /* 
        i_rw : 1 -> Read from RAM
        i_rw : 0 -> Write to RAM
    */

    // RAM 기준
    /* Hight Impedance Z : I'm going to write!! */
    assign io_data = (i_rw) ? mem[r_addr] : 8'bz;
    
    always @(posedge i_clk) begin
        if(i_ce) begin
            // Write to RAM
            if(!i_rw) begin
                mem[i_addr] <= io_data;
            end
            // Read from RAM
            else begin
                r_addr <= i_addr;
            end
        end
        else begin
        end
    end
endmodule
