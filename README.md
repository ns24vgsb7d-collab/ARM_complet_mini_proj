# ARM Datapath Mini Project

> 🇫🇷 [Version française du README](README_FR.md)

## 1. Overview
This repository contains the design and simulation of a simplified ARM datapath implemented in VHDL with Xilinx Vivado.  
The project was developed as part of the Computer Architecture mini-project at UQTR (Fall 2025).
>>>>>>> fa6184c (Final adjustments to README)

## 2. Objectives
The goal of this project is to build a simple ARM datapath that includes:
- an ALU (arithmetic and logic unit)
- a register file
- a decoder
- a conditional logic block
- a program counter
- an instruction memory
- flag registers
- Shifter
All components were tested with VHDL testbenches and validated through waveform simulation.

## 3. Repository Structure
- `src/` : VHDL source files  
- `tb/` : testbenches  
- `doc/` : diagrams, notes, and related documents  
- `.gitignore` : ignored Vivado/Vitis files  
- `LICENSE` : Apache 2.0 license  
- `README.md` : project documentation  

## 4. Build and Simulation
1. Open the project in Vivado or use a TCL build script.  
2. Simulate each testbench (`tb_*`) to verify functionality.  
3. Synthesize the design (bitstreams are not included in the repo).

## 5. License and Responsibility
This project is under the **Apache License 2.0**.  
It allows anyone to use, modify, or share the code freely with proper credit to the author.  
Apache was chosen because it is open, simple to reuse, and includes a patent clause not present in MIT.  
The GPL license was avoided to prevent mandatory redistribution under open-source terms.

### Disclaimer
This project is shared for academic purposes.  
I am **not responsible** for any problem, malfunction, or data loss that may result from using or modifying this code.  
Use it at your own risk.

## 6. Code Release and Maintenance
- Source code is shared for academic transparency and reproducibility.  
- There is no guarantee for industrial or commercial use.  
- Use versioning (`main`, `feat/*`, `fix/*`) and tag releases when relevant.  
- Bug fixes should be tested and documented.  
- No passwords, private keys, or confidential data should ever be published.

## 7. Security Aspects (FPGA)
If this ARM design is implemented on an FPGA:
- use **secure boot** and verify firmware signatures,  
- enable **bitstream encryption (AES)** and authentication,  
- disable or protect the JTAG port,  
- store keys safely (eFUSE or BBRAM).  

These measures help prevent unauthorized access or code modification.

## 8. Author
**Daniel Kabeya**  
Université du Québec à Trois-Rivières (UQTR)  
Department of Electrical and Computer Engineering – Fall 2025

