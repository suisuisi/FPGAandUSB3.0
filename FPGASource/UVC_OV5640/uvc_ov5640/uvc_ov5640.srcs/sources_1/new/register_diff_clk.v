/////////////////////////////////////////////////////////////////////////////
//��Ȩͬѧ Я�� ������V3ѧԺ ���Ĵ��� Xilinx FPGA������ϵ��
//����Ӳ��ƽ̨�� Xilinx Artix7 FPGA 
//�����׼��ͺţ� STAR/SF-AT7 ����FPGA�����׼�
//��   Ȩ  ��   ���� �������ɡ�����ǳ����תFPGA�����ߡ���Ȩͬѧ��ԭ����
//				����STAR/SF-AT7 �����׼�ѧϰʹ�ã�лл֧��
//�ٷ��Ա����̣� http://myfpga.taobao.com/
/////////////////////////////////////////////////////////////////////////////
module register_diff_clk(
			input clk,		
			input rst_n,	
			input in_a,
			output out_b	
		);
	
reg[1:0] temp;

always @(posedge clk or negedge rst_n)	
	if(!rst_n) temp <= 2'b00;
	else temp <= {temp[0],in_a};

assign out_b = temp[1];	

endmodule

