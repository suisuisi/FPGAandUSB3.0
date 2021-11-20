/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/*
����ģ�壺
pulse_detection		uut_pulse_detection(
						.clk(),       	
						.in_sig(),	//�����ź�
						.out_sig(),	//�������ź�ͬ��������ʱ���������
						.pos_sig(),	//�����źŵ������ؼ�⣬�����屣��һ��ʱ������
						.neg_sig()	//�����źŵ��½��ؼ�⣬�����屣��һ��ʱ������
					);
*/

//�������źŴ�2�ģ������ؼ��
module pulse_detection(
		input clk,       	
		input in_sig,	//�����ź�
		output out_sig,	//�������ź�ͬ��������ʱ���������
		output pos_sig,	//�����źŵ������ؼ�⣬�����屣��һ��ʱ������
		output neg_sig	//�����źŵ��½��ؼ�⣬�����屣��һ��ʱ������
	);
		
reg[1:0] in_sig_r;

always @(posedge clk)
	in_sig_r <= {in_sig_r[0],in_sig};

assign pos_sig = ~in_sig_r[1] & in_sig_r[0];
assign neg_sig = in_sig_r[1] & ~in_sig_r[0];
assign out_sig = in_sig_r[1];
	
	
endmodule

