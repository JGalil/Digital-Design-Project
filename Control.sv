// control decoder
//TRANSLATE INSN TO ALU OP
//MIGHT NEED ALU OP FOR BRANCH
//add IncAddr ->
module Control #(parameter opwidth = 3, mcodebits = 4)(
  input [mcodebits-1:0] instr,// subset of machine code (any width you need)
  input[1:0] incAddr_i,
  input[8:0] mach_code,
  output logic Mem2Reg, MemWrite, RegWrite, movR,
  output logic[opwidth-1:0] ALUOp,
  output logic[1:0] incAddr_o);	   // for up to 8 ALU operations

  logic[1:0] newInc;

  assign newInc = mach_code[4:3];
always_comb begin
// defaults
  MemWrite  =	'b0;   // 1: store to memory
  RegWrite  =	'b0;   // 0: for store or no op  1: most other operations 
  Mem2Reg  =	'b0;   // 1: load -- route memory instead of ALU to reg_file data in
  ALUOp	    =   'b111; // y = a+0;
  movR = 0;	       // 
  incAddr_o = incAddr_i;
// sample values only -- use what you need
case(instr)    // override defaults with exceptions
  4'b0000: begin         // add
      ALUOp    = 3'b000;   // ALU add operation
      RegWrite  =	'b1;
    end

    4'b0001: begin         // lsl (logical shift left)
      ALUOp    = 3'b001;   // ALU left shift operation
      RegWrite  =	'b1;
    end

    4'b0010: begin         // lsr (logical shift right)
      ALUOp    = 3'b010;   // ALU right shift operation
      RegWrite  =	'b1;
    end

    4'b0011: begin         // and (bitwise and)
      ALUOp    = 3'b011;   // ALU AND operation
      RegWrite  =	'b1;
    end

    4'b0100: begin         // orr (boolean or)
      ALUOp    = 3'b100;   // ALU OR operation
      RegWrite  =	'b1;
    end
    
    4'b0101: begin 	   //sub -> cmp
      ALUOp = 3'b101;
      RegWrite = 1'b0;
    end

    4'b0110: begin	  //not (bitwise NOT)
      ALUOp    = 3'b110;   // ALU NOT operation
      RegWrite  =	'b1;
    end

    4'b1001: begin	  //move
      RegWrite = 1'b1;
      movR = 1'b1;
    end
      

    4'b1101: begin         // ldr (load from memory)
      RegWrite = 1'b1;
      MemWrite = 1'b0;
      Mem2Reg = 1'b1;     // Data from memory goes to reg file
    end

    4'b1110: begin         // str (store to memory)
      MemWrite = 1'b1;     // Enable memory write
      RegWrite = 1'b0;     // Disable register write
    end

    4'b0111: begin         // incAddr (switch LUT for load/store)
      // No ALU operation; control flags are not affected
      incAddr_o = newInc;
      RegWrite = 1'b0;
    end

    4'b1111: begin         // bne (branch if not equal)
      RegWrite = 1'b0;     // Disable register write
    end
    4'b1010: begin 	   // bge
      RegWrite = 1'b0;
    end
// ...
endcase
    
end
	
endmodule