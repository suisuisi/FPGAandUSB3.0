/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
/*
例化模板：
pulse_detection		uut_pulse_detection(
						.clk(),       	
						.in_sig(),	//输入信号
						.out_sig(),	//将输入信号同步到本地时钟域后的输出
						.pos_sig(),	//输入信号的上升沿检测，高脉冲保持一个时钟周期
						.neg_sig()	//输入信号的下降沿检测，高脉冲保持一个时钟周期
					);
*/

//对输入信号打2拍，做边沿检测
module pulse_detection(
		input clk,       	
		input in_sig,	//输入信号
		output out_sig,	//将输入信号同步到本地时钟域后的输出
		output pos_sig,	//输入信号的上升沿检测，高脉冲保持一个时钟周期
		output neg_sig	//输入信号的下降沿检测，高脉冲保持一个时钟周期
	);
		
reg[1:0] in_sig_r;

always @(posedge clk)
	in_sig_r <= {in_sig_r[0],in_sig};

assign pos_sig = ~in_sig_r[1] & in_sig_r[0];
assign neg_sig = in_sig_r[1] & ~in_sig_r[0];
assign out_sig = in_sig_r[1];
	
	
endmodule

