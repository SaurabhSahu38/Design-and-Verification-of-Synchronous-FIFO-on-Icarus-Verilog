// Verilog code for Synchronous FIFO
module synchronous_FIFO(
  input clk,
  input reset,
  input Write_En,
  input [7:0] datain,
  output full,
  
  input Read_En,
  output reg [7:0] dataout,
  output empty);
  
  parameter DEPTH = 8;
  
  reg [7:0] mem [0:DEPTH-1];
  reg [2:0] Write_ptr;
  reg [2:0] Read_ptr;
  reg [3:0] count;
  
  assign full = (count==DEPTH);
  assign empty = (count==0);
  
// Verilog code for Write Operations-------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      Write_ptr <=3'd0;
    else begin
      if(Write_En) begin
        mem[Write_ptr] <= datain;
        Write_ptr <= Write_ptr+1;
      end
    end
  end
  
// Verilog code for Read Operations-------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      Read_ptr <=3'd0;
    else begin
      if(Write_En) begin
        dataout <= mem[Read_ptr];
        Read_ptr <= Read_ptr+1;
      end
    end
  end
  
// Verilog code for Count handling----------------------------
  always@(posedge clk, negedge reset) begin
    if(!reset)
      count <=4'd0;
    else begin
      case({Write_En,Read_En})
        2'b10: count <= count+1;
        2'b01: count <= count-1;
        default: count <= count;
      endcase
    end
  end
  
endmodule