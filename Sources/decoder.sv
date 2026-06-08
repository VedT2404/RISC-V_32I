`timescale 1ns/1ps

module decoder (
    input  logic [31:0] instr,
    output logic  [6:0]  opcode,
    output logic  [4:0]  rd,
    output logic  [2:0]  funct3,
    output logic  [4:0]  rs1,
    output logic  [4:0]  rs2,
    output logic  [6:0]  funct7,
    output logic [31:0]  imm
);

    always_comb begin
        opcode = instr[6:0];
        rd     = instr[11:7];
        funct3 = instr[14:12];
        rs1    = instr[19:15];
        rs2    = instr[24:20];
        funct7 = instr[31:25];
        imm = 32'b0; // Default immediate value    

    case (instr[6:0]) // Instruction type decoding
        7'b0110011: begin // R-type
            imm = 32'b0; // R-type instructions do not have an immediate value
        end
        7'b0010011: begin // I-type
            imm = {{20{instr[31]}},instr[31:20]};
        end
        7'b0000011: begin // Load
            imm = {{20{instr[31]}},instr[31:20]};
        end
        7'b0100011: begin // Store
            imm = {{20{instr[31]}},instr[31:25],instr[11:7]};
        end
        7'b1100011: begin // Branch
            imm = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0};
        end
        7'b0110111: begin // LUI
            imm = {instr[31:12], 12'b0};
        end
        7'b0010111: begin // AUIPC
            imm = {instr[31:12], 12'b0};
        end
        7'b1101111: begin // JAL
            imm = {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0};
        end
        7'b1100111: begin // JALR
            imm = {{20{instr[31]}},instr[31:20]};
        end
        
    endcase
    end
endmodule

        