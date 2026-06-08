`timescale 1ns / 1ps

module regfile_2rlw (
    input  logic        clk,
    input  logic        wen,
    input  logic [4:0]  waddr,
    input  logic [31:0] wdata,
    input  logic [4:0]  raddr1,
    input  logic [4:0]  raddr2,
    output logic [31:0] rdata1,
    output logic [31:0] rdata2
);

    logic [31:0] regfile [31:0];

integer i;
initial begin
    for(i=0;i<32;i=i+1)
        regfile[i] = 0;
end

    // synchronous write
    always_ff @(posedge clk) begin
        if (wen && (waddr != 5'd0)) begin
            regfile[waddr] <= wdata;
        end
    end

    // asynchronous read
    always_comb begin
        rdata1 = (raddr1 != 5'd0) ? regfile[raddr1] : 32'd0;
        rdata2 = (raddr2 != 5'd0) ? regfile[raddr2] : 32'd0;
    end

endmodule
