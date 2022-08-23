//Verilog code for Testbench of FIFO
`timescale 1ns/1ps

`define clk_period 10

module synchronous_FIFO_tb();
  
  reg clk,reset;
  reg Write_En,Read_En;
  reg [7:0] datain;
  
  wire [7:0] dataout;
  wire full,empty;
  
  synchronous_FIFO SYNFIF(
    .clk(clk),
    .reset(reset),
    .Write_En(Write_En),
    .datain(datain),
    .full(full),
    .Read_En(Read_En),
    .dataout(dataout),
    .empty(empty));
  
  initial clk = 1'b1;
  always #(`clk_period/2) clk = ~clk;
  
  integer i;
  
  initial begin
    reset = 1'b0;
    Write_En = 1'b0;
    Read_En = 1'b0;
    datain = 8'b0;
    
    #(`clk_period);
    reset = 1'b0;
    #(`clk_period);
    reset = 1'b1;
    
    Write_En = 1'b1;
    Read_En = 1'b0;
    
    for(i=0;i<8;i=i+1) begin
      datain = i;
      #(`clk_period);
    end
    
    Write_En = 1'b0;
    Read_En = 1'b1;
    
    for(i=0;i<8;i=i+1) begin
      #(`clk_period);
    end
    
    Write_En = 1'b1;
    Read_En = 1'b0;
    
    for(i=0;i<8;i=i+1) begin
      datain = i;
      #(`clk_period);
    end
    
    #(`clk_period);
    #(`clk_period);
    #(`clk_period);
    
    $finish;
  end
endmodule