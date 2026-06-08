`timescale 1ns / 1ps

module instruction_memory (
    input  logic [31:0] pc,
    output logic [31:0] instr
);

    logic [7:0] mem [0:127];

    initial begin
        integer i;

        // Initialize all bytes to 0
        for (i = 0; i < 128; i = i + 1)
            mem[i] = 8'h00; 

        // Instruction 0: 0x00500093
        mem[0]  = 8'h93;
        mem[1]  = 8'h00;
        mem[2]  = 8'h50;
        mem[3]  = 8'h00;

        // Instruction 1: 0x00500113
        mem[4]  = 8'h13;
        mem[5]  = 8'h01;
        mem[6]  = 8'h50;
        mem[7]  = 8'h00;

        // Instruction 2: 0x00208463
        mem[8]  = 8'h63;
        mem[9]  = 8'h84;
        mem[10] = 8'h20;
        mem[11] = 8'h00;

        // Instruction 3: 0x00100193
        mem[12] = 8'h93;
        mem[13] = 8'h01;
        mem[14] = 8'h10;
        mem[15] = 8'h00;

        // Instruction 4: 0x00900193
        mem[16] = 8'h93;
        mem[17] = 8'h01;
        mem[18] = 8'h90;
        mem[19] = 8'h00;
    end

    assign instr = (pc <= 124) ? {
        mem[pc + 3],
        mem[pc + 2],
        mem[pc + 1],
        mem[pc]
    } : 32'h00000013;

endmodule