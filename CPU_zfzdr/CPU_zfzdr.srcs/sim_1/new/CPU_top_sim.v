/********************CommmonMacro***************************/       
`define bit2 [1:0]                                                  
`define bit3 [2:0]                                                  
`define bit4 [3:0]                                                  
`define bit5 [4:0]                                                  
`define bit6 [5:0]                                                  
`define bit7 [6:0]                                                  
`define bit8 [7:0]                                                  
`define bit9 [8:0]                                                  
`define bit10 [9:0]                                                 
`define bit11 [10:0]                                                
`define bit12 [11:0]                                                
`define bit13 [12:0]                                                
`define bit14 [13:0]                                                
`define bit15 [14:0]                                                
`define bit16 [15:0]                                                
`define bit17 [16:0]                                                
`define bit18 [17:0]                                                
`define bit19 [18:0]                                                
`define bit20 [19:0]                                                
`define bit30 [29:0]                                                
`define bit32 [31:0]                                                
`define bit256 [255:0]                                              
                                                                    
                                                                    
/********************End of CommmonMacro***************************/
module CPU_top_sim(
	);
	reg  clk;
	reg  rst;	
	wire `bit16 MEMdata;
	wire `bit8  MARdata;
	wire `bit16 MBRdata;
	wire `bit16 ACCdata;
	wire `bit16 ALUdata;
	wire `bit8  PCdata;
	wire `bit16 IRdata;
	wire `bit8  OpCode;
	wire `bit16 BRdata;
	wire `bit16 CSdata;
	wire `bit8  CARdata;
	wire CS0;
	wire CS1;
	wire CS2;
	wire CS3;
	wire CS4;
	wire CS5;
	wire CS6;
	wire CS7;
	wire CS8;
	wire CS9;
	wire CS10;
	wire CS11;
	wire CS12;
	wire CS13;
	wire CS14;
	wire CS15;
	wire sign;
    wire `bit4 Wans;
    wire `bit4 Thousands;
    wire `bit4 Hundreds;
    wire `bit4 Tens;
    wire `bit4 Ones;   
    wire clk_N1;
    wire clk_N2;
    wire `bit8  choose;
    wire `bit8  data;
    wire flag_ACC;


initial begin
	clk = 0;
	rst = 1;
end
always #5 clk = ~clk;
always #100 rst = 0;



clock_all u_clock_all(
    .clk(clk),
    .clk_N1(clk_N1),
    .clk_N2(clk_N2)
    );
    
    
ControlUnit u_ControlUnit(
	.clk(clk),
	.rst(rst),
	.flag_ACC(flag_ACC),
	.OpCode(OpCode),
	.CSdata(CSdata),
	.CARdata(CARdata)
	);

CS u_CS(
	.CSdata(CSdata),
	.CS0(CS0),
	.CS1(CS1),
	.CS2(CS2),
	.CS3(CS3),
	.CS4(CS4),
	.CS5(CS5),
	.CS6(CS6),
	.CS7(CS7),
	.CS8(CS8),
	.CS9(CS9),
	.CS10(CS10),
	.CS11(CS11),
	.CS12(CS12),
	.CS13(CS13),
	.CS14(CS14),
	.CS15(CS15)
	);


ALU u_ALU(
	.clk(clk),
	.CS10(CS10),
	.OpCode(OpCode),
	.BRdata(BRdata),
	.ACCdata(ACCdata),
	.ALUdata(ALUdata)
	);

MAR u_MAR(
	.clk(clk),
	.CS6(CS6),
	.CS7(CS7),
	.PCdata(PCdata),
	.IRdata_l(IRdata[7:0]),
	.MARdata(MARdata)
	);

MBR u_MBR(
	.clk(clk),
	.CS1(CS1),
	.CS5(CS5),
	.MEMdata(MEMdata),
	.ACCdata(ACCdata),
	.MBRdata(MBRdata)
	);

PC u_PC(
	.clk(clk),
	.rst(rst),
	.CS0(CS0),
	.CS9(CS9),
	.IRdata_l(IRdata[7:0]),
	.PCdata(PCdata)
	);

IR u_IR(
	.clk(clk),
	.CS3(CS3),
	.MBRdata(MBRdata),
	.IRdata(IRdata),
	.OpCode(OpCode)
	);

BR u_BR(
	.clk(clk),
	.CS4(CS4),
	.MBRdata(MBRdata),
	.BRdata(BRdata)
	);

ACC u_ACC(
	.clk(clk),
	.CS8(CS8),
	.ALUdata(ALUdata),
	.flag_ACC(flag_ACC),
	.ACCdata(ACCdata)
	);

Memory u_Memory(
	.clk(clk),
	.rst(rst),
	.CS14(CS14),
	.CS2(CS2),
	.addr(MARdata),
	.data_in(MBRdata),
	.data_out(MEMdata)
	);
	
binary_to_BCD u_binary_to_BCD(
    .ACCdata(ACCdata),
    .sign(sign),
    .Wans(Wans),
    .Thousands(Thousands),
    .Hundreds(Hundreds),
    .Tens(Tens),
    .Ones(Ones)
    );
        
scan_seg u_scan_seg(
    .clk(clk_N2),
    .sign(sign),
    .Wans(Wans),
    .Thousands(Thousands),
    .Hundreds(Hundreds),
    .Tens(Tens),
    .Ones(Ones),
    .choose(choose),
    .data(data)
     );    

endmodule





