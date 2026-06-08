`timescale 1ns/1ps

module if_id_pipe (
    input logic clk,
    input logic [31:0] pc_i,
    input logic [31:0] instr_i,
    output logic [31:0] instr_o,
    output logic [31:0] pc_o
);

always_ff @(posedge clk) begin
    instr_o<=instr_i;
    pc_o<=pc_i;
end


endmodule