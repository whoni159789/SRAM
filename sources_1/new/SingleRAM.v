`timescale 1ns / 1ps

module SingleRAM(
    input i_clk,
    input i_ce,
    input i_rw,
    input [5:0] i_addr,
    input [7:0] i_data,
    output [7:0] o_data
    );

    reg [7:0] mem[0:63];
    reg [5:0] r_addr;
    assign o_data = mem[r_addr];
    
    always @(posedge i_clk) begin
        if(i_ce) begin
            if(!i_rw) begin
                mem[i_addr] <= i_data;
            end
            r_addr <= i_addr;
        end
        else begin
        end
    end
endmodule
