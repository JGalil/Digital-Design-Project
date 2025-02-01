module top_level(
  input        clk, reset, start,
  output logic done
);
  parameter D = 8;             // program counter width
  parameter A = 3;             // ALU command bit width

  wire [D-1:0] target, prog_ctr;       // jump and program counter
  wire         RegWrite, MemWrite, LUT, movR, Mem2Reg;
  wire [7:0]   memAddr;
  logic [7:0]  memData, memData_next;
  logic [4:0]  how_high;

  logic [1:0]  incAddr_i;
  logic [1:0]  incAddr;

  wire [7:0]   datA, datB, muxB, rslt, immed;
  logic [2:0]  LuTb;
  logic        sc_i, zeroQ;
  wire         relj;                     // relative jump enable
  logic        zero, sc_clr, sc_en;
  logic        N, V, E, G, NQ, VQ, EQ, CQ, SQ, GQ;

  wire [A-1:0] alu_cmd;
  wire [8:0]   mach_code;                // machine code
  wire [3:0]   op_code;
  logic [2:0]  rd_addrA, rd_addrB, mv_addr;       // address pointers for reg_file





/*





THE FILE PATH FROM INSTR_ROM HAS BEEN REMOVED: PLEASE REPLACE WITH YOUR FILE PATH






*/








  PC #(.D(D))  // D sets program counter width
     pc1 (
       .reset(reset),
       .start(start),
       .clk(clk),
       .reljump_en(relj),
       .E(EQ && (op_code == 4'b1111)),
       .G(GQ && (op_code == 4'b1010)),
       .target(target),
       .prog_ctr(prog_ctr)
     );

  // lookup table to facilitate jumps/branches
  PC_LUT #(.D(D))
    pl1 (
      .addr(how_high),
      .target
    );

  // contains machine code
  instr_ROM ir1(
    .prog_ctr,
    .mach_code
  );

  // Fetch subassembly
  assign LuTb = mach_code[2:0];
  assign rd_addrB = 0;
  assign op_code = mach_code[8:5];
  assign how_high = mach_code[4:0];

 // decode how_high if branch
  	//alucmd requires switch case for above
  //NEED TO DETERMINE IF WE BRANCH ASAP
  assign relj = {op_code == 'b1111 || op_code == 'b1010}? 'b1 : 'b0;


  assign rd_addrA = (op_code == 'b1101 || op_code == 'b1110 || op_code == 'b0111)? {1'b0,mach_code[4:3]} : mach_code[4:2];

  assign mv_addr = {1'b0, mach_code[1:0]};
 


// control decoder

//need to supply destination register

  Control ctl(.instr(op_code),
  .mach_code(mach_code), 
  .incAddr_i(incAddr_i),
  .MemWrite(MemWrite),
  .RegWrite(RegWrite),    
  .Mem2Reg(Mem2Reg),
  .ALUOp(alu_cmd),
  .movR(movR),
  .incAddr_o(incAddr));

  // ALU
  alu alu1(
    .alu_cmd(alu_cmd),
    .inA(datA),
    .inB(datB),
    .sc_i(sc_i),         // sc in
    .rslt(rslt),
    .sc_o(sc_o),         // sc out
    .zero(zero),
    .N(N),   
    .V(V),
    .E(E),
    .G(G)    
  );

  // dat_mem instance
  dat_mem dm1(
    .dat_in(datA),       // from reg_file
    .clk(clk),
    .wr_en(MemWrite),    // stores
    .addr(memAddr),
    .reset(reset),
    .start(start),
    .dat_out(memData)    // direct output
  );

  // Combinational assignment to select data for memData_next
  always_comb begin
    if (Mem2Reg != 1) 
      memData_next = rslt;
    else
      memData_next = memData;  // Retain memData when Mem2Reg is 1
  end

  // reg_file instance, replacing memData with memData_next
  reg_file #(.pw(3)) rf1(
    .dat_in(memData_next),  // loads data into reg_file
    .clk(clk),
    .wr_en(RegWrite),
    .rd_addrA(rd_addrA),
    .rd_addrB(rd_addrB),
    .mv_addr(mv_addr),
    .movR(movR),
    .reset(reset),
    .start(start),
    .wr_addr(rd_addrA),
    .datA_out(datA),
    .datB_out(datB)
  );

  // LUT instance
  LUT LUT1(
    .incAddr(incAddr),
    .LuTb(LuTb),
    .memAddr(memAddr)
  );

  // Flag register block
  always_ff @(posedge clk) begin
    //incAddr_i <= incAddr;
    if (reset|start) begin
      NQ <= 0; zeroQ <= 0; VQ <= 0; SQ <= 0; CQ <= 0; EQ <= 0;
      incAddr_i <= 0; /*incAddr <= 0;*/ sc_i <= 0; GQ <= 0;
    end else begin
      NQ <= N; zeroQ <= zero; VQ <= V; SQ <= sc_i; CQ <= sc_o; EQ <= E; sc_i <= sc_o; GQ <= G; incAddr_i <= incAddr;
    end
  end

  // Done flag (example condition)
  assign done = (prog_ctr >= 250);

endmodule
