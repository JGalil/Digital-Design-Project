# **CSE 141L Processor Design Project**

## **Overview**
This repository contains the design and implementation of a custom processor for **CSE 141L**, including Verilog modules, an assembler, and testbenches for three floating-point operations. The project evaluates performance and correctness through RTL simulations and testbench outputs.

## **Project Structure**

main/ # Main Verilog files

│── top_level.sv # Top-level module of the processor

│── alu.sv # Arithmetic Logic Unit

│── PC_LUT.sv # Program Counter with Lookup Table

│── Control.sv # Control unit for the processor

│── dat_mem.sv # Data memory module

│── instr_ROM.sv # Instruction memory (ROM)

│── LUT.sv # Lookup Table module

│── PC.sv # Program Counter module

│── reg_file.sv # Register file implementation

│programs/ # Program folders with machine code and testbenches

│── Program1/ (Int to Float Conversion)

│ │── assembled_ms3_pgm1_FINAL.txt # Correct machine code for Program 1

│ │── TBs/ # Testbench files

│ │── assembly_code.s # Assembly source code

│ │── Program2/ (Float to Int Conversion)

│ │── assembled_ms3_pgm2_v4.txt # Correct machine code for Program 2

│ │── TBs/ # Testbench files

│ │── assembly_code.s # Assembly source code

│ │── Program3/ (Float Addition)

│ │── assembled_ms3_pgm3_v9.txt # Correct machine code for Program 3

│ │── TBs/ # Testbench files

│ │── assembly_code.s # Assembly source code

│assembler/ # Assembler implementation

│── assembler.ipynb # Jupyter Notebook implementing assembler

│
docs/ # Documentation

│── CSE 141L Final Submission Outputs and RTL.pdf # Testbench results and RTL verification

│
README.md # This file
## **Processor Design**
This project implements a **lightweight floating-point processor** designed to execute simple operations efficiently. The processor supports:
1. **Integer to Floating-Point Conversion**
2. **Floating-Point to Integer Conversion**
3. **Floating-Point Addition**

The **Control Unit**, **ALU**, **Register File**, and **Memory Modules** are written in Verilog. The **top-level module (`top_level.sv`)** integrates all components.

## **Programs and Machine Code**
- **Program 1 (Int to Float Conversion)**: Works correctly. The correct machine code is `assembled_ms3_pgm1_FINAL.txt`.
- **Program 2 (Float to Int Conversion)**: Works correctly but requires handling of two’s complement for negative numbers. The correct machine code is `assembled_ms3_pgm2_v4.txt`.
- **Program 3 (Float Addition)**: Works correctly but has testbench overwriting issues. The correct machine code is `assembled_ms3_pgm3_v9.txt`.

### **Testbench Results**
The results from RTL simulations are stored in `CSE 141L Final Submission Outputs and RTL.pdf`. The key points include:
- Programs 1 and 2 pass all test cases.
- Program 3 experiences testbench overwriting, affecting certain results but when correct test case outcomes are compared with the output, the program does pass the test cases.
- The processor performs efficiently with simple and lightweight instructions.

## **Assembler**
The assembler is implemented in Python using Jupyter Notebook (`assembler.ipynb`). It translates assembly code into machine code for execution on the processor.

## **How to Use**
1. **Set the Correct Paths**  
   - Update `instr_ROM.sv` with the appropriate paths for each program’s machine code.

2. **Run the Simulation**  
   - Use **ModelSim/QuestaSim/VCS** or another Verilog simulator to compile and run testbenches.

3. **View Results**  
   - Compare output values with testbench expectations.
   - Use a waveform viewer to inspect memory locations if discrepancies occur.

## **Evaluation of Performance**
- The processor is **efficient** in executing floating-point operations.
- It completes all computations **without errors**, except for minor testbench behavior in **Program 3**.
- The lightweight instruction set ensures **fast execution**.

## **Additional Resources**
- **Recording of Testbenches & Architect Review**  
  --Provided upon request

## **Acknowledgments**
This project was developed as part of **CSE 141L** and follows coursework requirements for designing and verifying a custom floating-point processor.
