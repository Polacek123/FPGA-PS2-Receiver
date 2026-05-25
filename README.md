# PS/2 Keyboard Receiver (FPGA)

Custom VHDL implementation of a PS/2 keyboard receiver (PS2_Rx) designed for the Zynq UltraScale+ MPSoC architecture. 

This project is developed as part of the "Digital Circuits and Embedded Systems 2" (UCISW2) course at Wrocław University of Science and Technology.

## Hardware Platform
* **Board:** AUP-ZU3 (Zynq UltraScale+ MPSoC)
* **Expansion:** ZU3-Expansion Board
* **Input:** PS/2 Keyboard connected to port `PS2_A`
* **Output:** Status and received Scan Codes mapped to OLED display via reference IP cores.

## Project Structure
* `/src` - VHDL source files (FSM, Debouncer).
* `/constraints` - XDC physical pin mapping files for the AUP-ZU3 and Expansion board.
* `/sim` - Testbench files for Vivado Simulator.
* `/docs` - LaTeX documentation and timing diagrams.

## Authors
* Wojciech Staruch
* Łukasz Cyganiuk
