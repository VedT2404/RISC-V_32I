`timescale 1ns/1ps

module alu_control (
    input logic [6:0] opcode,
    input  logic [3:0] alu_op,
    input  logic [2:0] funct3,
    input  logic [6:0] funct7,
    output logic [3:0] alu_ctrl
);

always_comb begin 
    case (opcode)
        7'b0110011: begin // R-type
            case (alu_op)
                4'b0010: begin // R-type operations
                    case ({funct7, funct3})
                        10'b0000000000: alu_ctrl = 4'b0000; // ADD
                        10'b0100000000: alu_ctrl = 4'b0001; // SUB
                        10'b0000000111: alu_ctrl = 4'b0010; // AND
                        10'b0000000110: alu_ctrl = 4'b0011; // OR
                        10'b0000000100: alu_ctrl = 4'b0100; // XOR
                        default: alu_ctrl = 4'b1111; // Invalid
                    endcase
                end
                default: alu_ctrl = 4'b1111; // Invalid ALU operation
            endcase
        end
        7'b0010011: begin // I-type
            case (alu_op)
                4'b0010: begin // I-type operations
                    case (funct3)
                        3'b000: alu_ctrl = 4'b0000; // ADDI
                        3'b111: alu_ctrl = 4'b0010; // ANDI
                        3'b110: alu_ctrl = 4'b0011; // ORI
                        3'b100: alu_ctrl = 4'b0100; // XORI
                        default: alu_ctrl = 4'b1111; // Invalid
                    endcase
                end
                default: alu_ctrl = 4'b1111; // Invalid ALU operation
            endcase
        end
        default: alu_ctrl = 4'b1111; // Invalid opcode for ALU control
        
end
endmodule