// lookup table
// deep 
// 9 bits wide; as deep as you wish

// README: REPLACE PATH WITH YOUR OWN PATH
module instr_ROM #(parameter D=8)(
  input       [D-1:0] prog_ctr,    // prog_ctr	  address pointer
  output logic[ 8:0] mach_code);

  logic[8:0] core[2**D];
  initial							    // load the program
//program 1
//  $readmemb("C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm1_FINAL.txt",core);
//program 2
//  $readmemb("C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm2_v4.txt",core);
//program 3
  $readmemb("C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm3_v9.txt",core);

//README: FOR GRADERS

//"/YOUR_PATH_HERE/assembled_ms3_pgm1_FINAL.txt"
//program 1
//"YOUR_PATH_HERE/assembled_ms3_pgm2_v4.txt"
//program 2 ^
//"YOUR_PATH_HERE/assembled_ms3_pgm3_v9.txt"
//program 3^

//FOR US

//"C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm1_FINAL.txt"
//program 1
//"C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm2_v4.txt"
//program 2 ^
//"C:/Users/porkc/OneDrive/Documents/UCSD/Year 3/CSE 141L/Demo/sample_RISC_design_starter/assembled_ms3_pgm3_v9.txt"
//program 3^
  always_comb  mach_code = core[prog_ctr];

endmodule


/*
sample mach_code.txt:

001111110		 // ADD r0 r1 r0
001100110
001111010
111011110
101111110
001101110
001000010
111011110
*/