`timescale 1ns / 1ps

module tb_memory_top;

    // Parámetros
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    // Señales
    logic clk;
    logic write_enable;
    logic read_enable;
    logic [ADDR_WIDTH-1:0] address;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;

    // Instancia del módulo top
    memory_top #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .clk(clk),
        .write_enable(write_enable),
        .read_enable(read_enable),
        .address(address),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Periodo de 10ns
    end

    // Secuencia de estímulos
    initial begin

        // Inicialización
        write_enable = 0;
        read_enable = 0;
        address = 0;
        data_in = 0;

        #15;

        // 1. Escribir datos en la memoria
        // Escribir 8'hAB en la dirección 8'h05
        @(posedge clk);
        write_enable = 1;
        address = 8'h05;
        data_in = 8'hAB;

        @(posedge clk);
        // Escribir 8'hBB en la dirección 8'h0A
        address = 8'h0A;
        data_in = 8'hBB;

        @(posedge clk);
        write_enable = 0; // Desactivar escritura

        #20;

        // 2. Leer datos de la memoria
        // Leer de la dirección 8'h05
        @(posedge clk);
        read_enable = 1;
        address = 8'h05;

        @(posedge clk);
        // Leer de la dirección 8'h0A
        address = 8'h0A;

        @(posedge clk);
        read_enable = 0; // Desactivar lectura

        #30;
        $finish;
    end

endmodule