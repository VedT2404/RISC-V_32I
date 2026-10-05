`timescale 1ns/1ps

module tb_core_top;

    logic clk;
    logic rst;

    // DUT
    core_top dut (
        .clk(clk),
        .rst(rst)
    );

    // =====================================================
    // CLOCK
    // =====================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;      // 100 MHz
    end

    // =====================================================
    // RESET
    // =====================================================

    initial begin
        rst = 1;
        #20;
        rst = 0;
    end

    // =====================================================
    // SIMULATION
    // =====================================================

    initial begin

        $display("========================================");
        $display("Starting CPU Simulation");
        $display("========================================");

        #500;

        $display("========================================");
        $display("Simulation Finished");
        $display("========================================");

        $finish;
    end

    // =====================================================
    // MONITOR
    // =====================================================

    initial begin

        $monitor(
            "T=%0t | PC=%h | INSTR=%h | ALU=%h | WB=%h | RD=%0d | REGWRITE=%b",
            $time,
            dut.pc,
            dut.if_id_instr,
            dut.alu_result,
            dut.wb_data,
            dut.wb_rd,
            dut.wb_reg_write
        );

    end

    // =====================================================
    // WAVES
    // =====================================================

    initial begin

        $dumpfile("core_top.vcd");
        $dumpvars(0, tb_core_top);

    end

endmodule