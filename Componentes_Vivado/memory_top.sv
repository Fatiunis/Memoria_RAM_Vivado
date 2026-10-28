`timescale 1ns / 1ps

module memory_top #(
    // Parametrización solicitada
    parameter DATA_WIDTH = 8,  // Ancho del bus de datos (ej. 8 bits para un byte)
    parameter ADDR_WIDTH = 8   // Ancho del bus de direcciones (n entradas manejan 2^n posiciones)
)(
    input  logic                    clk,          // Reloj del sistema
    input  logic                    write_enable, // Señal Write Enable del video
    input  logic                    read_enable,  // Señal Read Enable del video
    input  logic [ADDR_WIDTH-1:0]   address,      // Bus de direcciones
    input  logic [DATA_WIDTH-1:0]   data_in,      // Datos de entrada a escribir
    output logic [DATA_WIDTH-1:0]   data_out      // Datos de salida leídos
);

    // Abstracción de la matriz de memoria descrita en el video
    // Se crea un arreglo de registros de tamaño 2^ADDR_WIDTH
    logic [DATA_WIDTH-1:0] ram_matrix [0:(1<<ADDR_WIDTH)-1];    

    // Proceso de escritura (Write)
    always_ff @(posedge clk) begin
        // Si write_enable está activo, el valor se guarda en la matriz en la dirección indicada
        if (write_enable) begin
            ram_matrix[address] <= data_in;
        end
    end

    // Proceso de lectura (Read)
    always_ff @(posedge clk) begin
        // Si read_enable está activo, la línea de datos funciona como salida
        if (read_enable) begin
            data_out <= ram_matrix[address];
        end else begin
            // Si no se lee, se mantiene en alta impedancia (desconectado)
            data_out <= 'z; 
        end
    end

endmodule