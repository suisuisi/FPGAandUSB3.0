/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//系统内部时钟和复位产生模块
module sys_ctrl(
				//FPGA外部输入时钟和复位	
			input ext_clk,		//外部25MHz输入时钟	
			input ext_rst_n,	//外部低电平复位信号输入
				//PLL输出复位和时钟，用于FPGA内部系统
			output reg sys_rst_n,	//系统复位信号，低电平有效
			output clk_25m,		//PLL输出25MHz	
			output fx3_pclk,	//PLL输出100MHz，与clk_100m有相位差
			output clk_50m,		//PLL输出50MHz
			output clk_100m		//PLL输出100MHz
		);

////////////////////////////////////////////////////
//PLL复位信号产生，高有效
//异步复位，同步释放

reg rst_r1,rst_r2;

always @(posedge ext_clk or negedge ext_rst_n)
	if(!ext_rst_n) rst_r1 <= 1'b0;
	else rst_r1 <= 1'b1;

always @(posedge ext_clk or negedge ext_rst_n)
	if(!ext_rst_n) rst_r2 <= 1'b0;
	else rst_r2 <= rst_r1;

////////////////////////////////////////////////////
//PLL模块例化
wire locked;	//PLL输出锁定状态，高电平有效
		
  clk_wiz_0 	uut_clk_wiz_0
   (
   // Clock in ports
    .clk_in1(ext_clk),      // input clk_in1
    // Clock out ports
    .clk_out1(clk_25m),     // output clk_out1
    .clk_out2(fx3_pclk),     // output clk_out2
    .clk_out3(clk_50m),     // output clk_out3
    .clk_out4(clk_100m),     // output clk_out4
    // Status and control signals
    .reset(!rst_r2), // input reset
    .locked(locked));      // output locked
//----------------------------------------------
//系统复位处理逻辑
reg sys_rst_nr;

always @(posedge clk_100m)
	if(!locked) sys_rst_nr <= 1'b0;
	else sys_rst_nr <= 1'b1;

always @(posedge clk_100m or negedge sys_rst_nr)
	if(!sys_rst_nr) sys_rst_n <= 1'b0;
	else sys_rst_n <= sys_rst_nr;


endmodule

