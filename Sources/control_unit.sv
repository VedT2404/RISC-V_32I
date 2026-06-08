`timescale 1ns/1ps

module control_unit (
    input  logic [6:0] opcode,
    input logic [2:0] funct3,
    input logic [6:0] funct7,
    output logic       reg_write,
    output logic [1:0] wb_sel,
    output logic       mem_read,
    output logic       mem_write,
    output logic       branch,
    output logic [3:0] alu_op,
    output logic       alu_src,
    output logic       jump
);

always_comb begin 
reg_write = 0;
wb_sel    = 0;
mem_read  = 0;
mem_write = 0;
branch    = 0;
alu_op    = 0;
alu_src   = 0;
jump      = 0;
    case (opcode)
        7'b0110011: begin // R-type
            reg_write = 1;
            alu_src   = 0;
            wb_sel    = 2'b00;
            alu_op    = 4'b0010; // ALU control will determine the exact operation
        end
        7'b0010011: begin // I-type
            reg_write = 1;
            alu_src   = 1;
            wb_sel    = 2'b00;
            alu_op    = 4'b0010; // ALU control will determine the exact operation
        end
        7'b0000011: begin // Load
            reg_write = 1;
            alu_src   = 1;
            wb_sel    = 2'b01; // Write back from memory
            mem_read  = 1;
            alu_op    = 4'b0000; // ALU will perform addition for address calculation
        end
        7'b0100011: begin // Store
            alu_src   = 1;
            mem_write = 1;
            alu_op    = 4'b0000; // ALU will perform addition for address calculation
        end
        7'b1100011: begin // Branch
            branch    = 1;
            alu_op    = 4'b0001; // ALU will perform subtraction for comparison
        end
      //  7'b1101111: begin // JAL
      //     reg_write = 1;
      //      jump      = 1;
      //      wb_sel    = 2'b00; // Write back from ALU (PC + 4)
      //  end
      //  7'b1100111: begin // JALR
      //      reg_write = 1;
      //      jump      = 1;
      //      alu_src   = 1; // ALU will calculate target address
      //      wb_sel    = 2'b00; // Write back from ALU (target address)
      //      alu_op    = 4'b0000; // ALU will perform addition for address calculation
      //  end
        endcase

end
endmodule