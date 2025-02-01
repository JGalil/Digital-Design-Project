// 8-bit wide, 256-word (byte) deep memory array
module dat_mem (
  input[7:0] dat_in,
  input      clk,
  input      wr_en,	          // write enable
  input[7:0] addr,		      // address pointer
  input		reset, start,
  output logic[7:0] dat_out);

  logic[7:0] core[256];       // 2-dim array  8 wide  256 deep

// reads are combinational; no enable or clock required
  assign dat_out = core[addr];

// writes are sequential (clocked) -- occur on stores or pushes 
 always_ff @(posedge clk) begin
    if(reset) begin
	integer i;
    	for (i = 0; i < 256; i = i + 1) begin
     		core[i] = 8'b0; // Set each 8-bit element in the array to zero
    	end
    end
/*
    else if(start) begin
	core[4] <= 8'b0000_0000;
        core[5] <= 8'b0000_0001;
        core[6] <= 8'b1111_1111;
        core[7] <= 8'b0000_1000;
        core[11] <= 8'b1111_1000;
        core[12] <= 8'b1000_0000;
	core[13] <= 8'b0001_1111;
    end
*/
    else begin
   	 if (wr_en) begin            // When write enable is high
     	 core[addr] <= dat_in; 
   	 end
    end
  end

  // Reset initialization block, setting specific values on reset
  always_ff @(posedge clk) begin
    
  end
endmodule