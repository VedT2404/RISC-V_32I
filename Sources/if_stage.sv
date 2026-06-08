`timescale 1ns/1ps

module if_stage (
    input logic [31:0] pc,
    output logic [31:0] next_pc
);

assign next_pc=pc+32'd4; // for now later add ternary operator for branch jump etc

endmodule