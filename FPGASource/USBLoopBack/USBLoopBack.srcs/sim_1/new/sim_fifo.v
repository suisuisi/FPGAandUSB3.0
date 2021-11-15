`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/02/08 09:33:26
// Design Name: 
// Module Name: sim_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module sim_fifo(

    );

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg[31:0] din;

wire full;
wire empty;
wire prog_full;
wire[31:0] dout;	
	
	
fifo_generator_0 	uut_fifo_generator_0 (
  .clk(clk),              // input wire clk
  .rst(rst),              // input wire rst
  .din(din),              // input wire [31 : 0] din
  .wr_en(wr_en),          // input wire wr_en
  .rd_en(rd_en),          // input wire rd_en
  .dout(dout),            // output wire [31 : 0] dout
  .full(full),            // output wire full
  .empty(empty),          // output wire empty
  .prog_full(prog_full)  // output wire prog_full
);	
	
reg[3:0] temp;
	
initial begin
	clk = 0;
	rst = 1;
	wr_en = 0;
	temp = 0;
	din = 32'hzzzzzzzz;
	repeat(1000) begin
		@(posedge clk);	#3;
	end
	rst = 0;
	repeat(1000) begin
		@(posedge clk);	#3;
	end
	
	
	for(temp=0; temp < 4'hf; temp = temp+1'b1) begin
		wr_en = 1;
		din <= {temp,temp,temp,8'hff};
		@(posedge clk);	#3;
	end

	wr_en = 0;
	din = 32'hzzzzzzzz;	
	
	#5_000;
	$stop;
end	
	
always #5 clk = ~clk;	
	
always @(posedge clk or negedge rst)
	if(rst) rd_en <= 1'b0;
	else if(prog_full) rd_en <= 1'b1;
	else rd_en <= 1'b0;

	
endmodule
