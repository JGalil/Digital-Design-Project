// combinational -- no clock
// sample -- change as desired
module alu(
  input[2:0] alu_cmd,    // ALU instructions
  input[7:0] inA, inB,	 // 8-bit wide data path
  input      sc_i,       // shift_carry in
  output logic[7:0] rslt,
  output logic sc_o,     // shift_carry out
               N,        // Negative flag
	       zero,     // NOR (output)
	       V,	 //Overflow
               E,	 //Not Equal
	       G	 //Greater Than
);

always_comb begin 
  rslt = 'b0;            
  sc_o = 'b0;    
  //zero = !rslt;  WHY IS THIS HERE BRUH
  N = 'b0;
  E = 'b0;
  V = 'b0;
  G = 'b0;
  case(alu_cmd)
    3'b000: begin// add 2 8-bit unsigned; automatically makes carry-out
      {sc_o,rslt} = inA + inB + sc_i;
      V = ((inA[7] ^ rslt[7]) && (inB[7] ^ rslt[7]));
    end
    3'b001: begin// left_shift
      {sc_o,rslt} = {inA, sc_i};
      /*begin
		rslt[7:1] = ina[6:0];
		rslt[0]   = sc_i;
		sc_o      = ina[7];
      ed*/
    end
    3'b010: begin// right shift (alternative syntax -- works like left shift
	  {rslt,sc_o} = {sc_i,inA};
    end
    3'b011: begin// bitwise AND (mask)
	  rslt = inA & inB;
    end
    3'b100: begin// boolean or
	  rslt = inA || inB;
    end
    3'b101: begin// subtract -> cmp
	  {sc_o,rslt} = inA - inB;
	  if(rslt != 8'b0000_0000) begin
		E = 'b1;
	  end
          V = (inA[7] ^ inB[7]) && (inA[7] ^ rslt[7]);
	  G = inA > inB;
    end
    3'b110: begin// Not
	  rslt = ~inA;
    end
  endcase
  zero = !rslt;
  N = rslt[7]; 
  
end
   
endmodule