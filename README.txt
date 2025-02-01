README:

Recording Link:

https://ucsd.zoom.us/rec/share/iGX4vAOairw7x1OXglnI4Rdan4d5X1AeqcQm5UsYd-Bz-GkDvPkTOuKdR4uEEFlp.dt6VtpQRUX05AAJe?startTime=1733784113000
Passcode: B6N5?+VX

Sorry it is so long, it took longer than expected to go through each testbench, especially the third.

Here is an additional video covering the part of the submission about convincing a computer architect of your design:

https://drive.google.com/file/d/1iFulHEtrcmIgf-R7rUJ4jBI6fw5SvLZn/view?usp=sharing


All required values are initialized in the respective testbenches. 

main files are in main folder, Program 1 folder has the machine code and then the TBs sub folder has the testbench and necessary files for program 1
similar for programs 2 and 3

the CodeAndAssembler folder includes the assembler, the assembly code for each program, and the machine code for each program.

The PDF is a screenshot of our RTL and all the results from our testbench outputs, including comparisons between each case using the test done flag and our done flag for program 3. 


PROGRAM 1:
This program works.
CORRECT MACHINE CODE: assembled_ms3_pgm1_FINAL.txt

Your own path will be required, you can add it in in the instr_ROM.sv file

Program 2:
This program works.
CORRECT MACHINE CODE: assembled_ms3_pgm2_v4.txt

Your own path will be required, you can add it in in the instr_ROM.sv file

The first 'correct' number is if the testbench binary, matches our binary output. 
The second 'correct' number is if our output matches the decimal output of the testbench, however the testbench does not convert our binary into 2s complement for negative numbers, so the last 12 tests are incorrect, as they all use negative inputs.

Program 3:
This program works but the testbench is odd, which I discuss in the additional notes.
CORRECT MACHINE CODE: assembled_ms3_pgm3_v9.txt

Your own path will be required, you can add it in in the instr_ROM.sv file

ADDITIONAL NOTES FOR PROGRAM 3:
Program 3 testbench has very odd behavior that we could not fix. The issue lies in that some of the testbench results are overwritten when our code is completed. If the testbench is run with the test done flag, the testbench will get correct results for every test case, however when our done flag is used, some of the testbench results are overwritten from correct to incorrect. You can find the correct values (which match the values when the test done flag is used) by opening the waveform viewer and creating a wave for the testbench. At 55ns, it is seen that the memory location for the testbench results are overwritten(this is the same for both flags). Despite both flags being thrown long after the overwrite occurs, the correct result will only be displayed when the test flag is thrown.


Evaluation of Performance:

Our processor works very well for these programs, the instructions are very simple and lightweight, meaning they run quite fast. Additionally, it completed all programs with no issues.