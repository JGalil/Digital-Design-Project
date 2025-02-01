module PC_LUT #(parameter D=8)(
  input       [4:0] addr,	   // target 4 values
  output logic[D-1:0] target);
//PROGRAM 1 OFFSETS
  always_comb case(addr)
        0: target = 134;   // go ahead 129
	1: target = 6;   // go ahead 6 spaces
	2: target = 15;   // go ahead 15
	3: target = 8;
	4: target = 16;
	5: target = -7;
	6: target = 15;
	7: target = -9;
	8: target = -8;
	9: target = 9;
	10: target = 9;
	11: target = 15;
	12: target = 22;
	13: target = 23;
	14: target = 46;  //actually 44 -> 40 to 84 branch to A>B
	15: target = 95;  //branch to swap 42 to 137
	16: target = 75;  //83-158
	17: target = -10; //shift loop
	18: target = -69; //branch up to = case
	19: target = -73; //branch up to A>B
	20: target = 8;   //branch around inc exp
	default: target = 'b0;  // hold PC  
  endcase

endmodule

/*

	   pc = 4    0000_0000_0100	  4
	             1111_1111_1111	 -1

                 0000_0000_0011   3

				 (a+b)%(2**12)


   	  1111_1111_1011      -5
      0000_0001_0100     +20
	  1111_1111_1111      -1
	  0000_0000_0000     + 0


  */
