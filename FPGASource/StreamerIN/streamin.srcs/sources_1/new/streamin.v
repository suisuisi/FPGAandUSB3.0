/////////////////////////////////////////////////////////////////////////////
//��Ȩͬѧ ���Ĵ��� Xilinx FPGA������ϵ��
//����Ӳ��ƽ̨�� Xilinx Artex7 FPGA 
//�����׼��ͺţ� SF-AT7 ��Ȩ����
//��   Ȩ  ��   ���� �������ɡ�����ǳ����תFPGA�����ߡ���Ȩͬѧ��ԭ����
//				����SF-AT7�����׼�ѧϰʹ�ã�лл֧��
//�ٷ��Ա����̣� http://myfpga.taobao.com/
//�����������أ� http://pan.baidu.com/s/1c2iTPra
//��                ˾�� �Ϻ�������ӿƼ����޹�˾
/////////////////////////////////////////////////////////////////////////////
module streamin(
				//�ⲿ����ʱ�Ӻ͸�λ�ӿ�
			input sys_clk_i,	//�ⲿ����50MHzʱ���ź�
			input ext_rst_n,	//�ⲿ���븴λ�źţ��͵�ƽ��Ч	
				//FX3 Slave FIFO�ӿ�
			input fx3_flaga,	//��ַ00ʱ��slave fifoд������־λ
			input fx3_flagb,	//��ַ00ʱ��slave fifoд�������־λ����λ���ͺ󻹿���д��6��Byte����
			input fx3_flagc,	//ctl[8]����ַ11ʱ��slave fifo���ձ�־λ
			input fx3_flagd,	//ctl[9]����ַ11ʱ��slave fifo����ձ�־λ����λ���ͺ󻹿���д��6��Byte���ݣ����źŴ��ϵ�Ϊ�ߵ�ƽ��
			output fx3_pclk,		//Slave FIFOͬ��ʱ���ź�
			output fx3_slcs_n,		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			output fx3_slwr_n,		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			output fx3_slrd_n,		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			output fx3_sloe_n,		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			output fx3_pktend_n,
			output[1:0] fx3_a,
			inout[31:0] fx3_db,			
				//LEDָʾ�ƽӿ�
			output[0:0] led	//���ڲ��Ե�LEDָʾ��			
		);	

////////////////////////////////////////////////////		
//ϵͳ�ڲ�ʱ�Ӻ͸�λ����ģ������
	//PLL�����λ��ʱ�ӣ�����FPGA�ڲ�ϵͳ
wire sys_rst_n;	//ϵͳ��λ�źţ��͵�ƽ��Ч
wire clk_25m;		//PLL���25MHz	
wire clk_50m;		//PLL���50MHz
wire clk_100m;	//PLL���100MHz		

sys_ctrl	u1_sys_ctrl(
				.ext_clk(sys_clk_i),
				.ext_rst_n(ext_rst_n),
				.sys_rst_n(sys_rst_n),
				.clk_25m(clk_25m),
				.fx3_pclk(fx3_pclk),
				.clk_50m(clk_50m),
				.clk_100m(clk_100m)
			);
		
////////////////////////////////////////////////////
//LED��˸�߼�����ģ������

led_controller		u2_led_controller(
						.clk(clk_25m),
						.rst_n(sys_rst_n),
						.led(led[0])
					);
					
////////////////////////////////////////////////////	
//FX3 Slave FIFO��д��������ģ��

usb_controller		u3_usb_controller(
						.clk(clk_100m),
						.rst_n(sys_rst_n),
						.fx3_flaga(fx3_flaga),
						.fx3_flagb(fx3_flagb),
						.fx3_flagc(fx3_flagc),
						.fx3_flagd(fx3_flagd),
						//.fx3_pclk(fx3_pclk),
						.fx3_slcs_n(fx3_slcs_n),
						.fx3_slwr_n(fx3_slwr_n),
						.fx3_slrd_n(fx3_slrd_n),
						.fx3_sloe_n(fx3_sloe_n),
						.fx3_pktend_n(fx3_pktend_n),
						.fx3_a(fx3_a),
						.fx3_db(fx3_db)
					);

					
endmodule

