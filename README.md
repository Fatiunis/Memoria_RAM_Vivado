\# Memoria Parametrizada en SystemVerilog



Implementación de una estructura de Memoria de Acceso Aleatorio (RAM) síncrona y parametrizada descrita en SystemVerilog, desarrollada como entregable de Arquitectura de Computadoras.



\## Características

\- Bus de datos y bus de direcciones parametrizables.

\- Señales de control `write\_enable` y `read\_enable` independientes.



\## Simulación

Para compilar y simular utilizando Synopsys VCS y generar los archivos `.fsdb` para visualización en Verdi, ejecuta:



```bash

vcs -sverilog -debug\_access+all memory\_top.sv tb\_memory\_top.sv -o simv

./simv

