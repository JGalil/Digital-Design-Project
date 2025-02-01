module LUT #(parameter D=8)(
//inout is 3 bits wide, bottom 3 bits of lw, sw insn
//default: LUT 1
//if INA insn pass inc address -> toggle if INA is run
//if INA = 1, use LUT 2
//each LUT has 8 locations
//output is address
//send to data mem
  input       [2:0] LuTb,	   // target 4 values
  input logic [1:0] incAddr,
  output logic[D-1:0] memAddr);


  always_comb case(incAddr)
       0:
  	case(LuTb)
                0: memAddr = 0; 
	        1: memAddr = 1;   
		2: memAddr = 2;  
		3: memAddr = 3;
		4: memAddr = 4;
		5: memAddr = 5;
		6: memAddr = 6;
		7: memAddr = 7;
		default: memAddr = 0;
  	endcase
        1:
  	case(LuTb)
                0: memAddr = 8; 
	        1: memAddr = 9;   
		2: memAddr = 10;  
		3: memAddr = 11;
		4: memAddr = 12;
		5: memAddr = 13;
		6: memAddr = 14;
		7: memAddr = 15;
		default: memAddr = 0;
  	endcase  
        2:
  	case(LuTb)
                0: memAddr = 16; 
	        1: memAddr = 17;   
		2: memAddr = 18;  
		3: memAddr = 19;
		4: memAddr = 20;
		5: memAddr = 21;
		6: memAddr = 22;
		7: memAddr = 23;
		default: memAddr = 0;
  	endcase
        3:
  	case(LuTb)
                0: memAddr = 24; 
	        1: memAddr = 25;   
		2: memAddr = 25;  
		3: memAddr = 27;
		4: memAddr = 28;
		5: memAddr = 29;
		6: memAddr = 30;
		7: memAddr = 31;
		default: memAddr = 0;
  	endcase
	default: memAddr = 0;
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
always_comb case(addr)
    0: target = -5;   // go back 5 spaces
	1: target = 20;   // go ahead 20 spaces
	2: target = '1;   // go back 1 space   1111_1111_1111
	default: target = 'b0;  // hold PC  
  endcase

  */
