/////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//ϵͳ�ڲ�ʱ�Ӻ͸�λ����ģ��
module sys_ctrl(
				//FPGA�ⲿ����ʱ�Ӻ͸�λ	
			input ext_clk,		//�ⲿ25MHz����ʱ��	
			input ext_rst_n,	//�ⲿ�͵�ƽ��λ�ź�����
				//PLL�����λ��ʱ�ӣ�����FPGA�ڲ�ϵͳ
			output reg sys_rst_n,	//ϵͳ��λ�źţ��͵�ƽ��Ч
			output clk_25m,		//PLL���25MHz	
			output fx3_pclk,	//PLL���100MHz����clk_100m����λ��
			output clk_50m,		//PLL���50MHz
			output clk_100m		//PLL���100MHz
		);

////////////////////////////////////////////////////
//PLL��λ�źŲ���������Ч
//�첽��λ��ͬ���ͷ�

reg rst_r1,rst_r2;

always @(posedge ext_clk or negedge ext_rst_n)
	if(!ext_rst_n) rst_r1 <= 1'b0;
	else rst_r1 <= 1'b1;

always @(posedge ext_clk or negedge ext_rst_n)
	if(!ext_rst_n) rst_r2 <= 1'b0;
	else rst_r2 <= rst_r1;

////////////////////////////////////////////////////
//PLLģ������
wire locked;	//PLL�������״̬���ߵ�ƽ��Ч
		
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
//ϵͳ��λ�����߼�
reg sys_rst_nr;

always @(posedge clk_100m)
	if(!locked) sys_rst_nr <= 1'b0;
	else sys_rst_nr <= 1'b1;

always @(posedge clk_100m or negedge sys_rst_nr)
	if(!sys_rst_nr) sys_rst_n <= 1'b0;
	else sys_rst_n <= sys_rst_nr;


endmodule

