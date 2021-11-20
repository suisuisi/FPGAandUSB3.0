`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
//��Ȩͬѧ Я�� ������V3ѧԺ ���Ĵ��� Xilinx FPGA������ϵ��
//����Ӳ��ƽ̨�� Xilinx Artix7 FPGA 
//�����׼��ͺţ� STAR/SF-AT7 ����FPGA�����׼�
//��   Ȩ  ��   ���� �������ɡ�����ǳ����תFPGA�����ߡ���Ȩͬѧ��ԭ����
//				����STAR/SF-AT7 �����׼�ѧϰʹ�ã�лл֧��
//�ٷ��Ա����̣� http://myfpga.taobao.com/
/////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ps
module rgb2yuv(
		input clk,
		input rst_n,
		//input Image Data Flow
		input i_rgb_image_rst,
		input i_rgb_image_vld,
		input[23:0] i_rgb_image_data,
		//output Image Data Flow
		output o_yuv_image_rst,
		output o_yuv_image_vld,
		output reg[15:0] o_yuv_image_data
    );
	
////////////////////////////////////////////////////////////////////////////////////////////////////////
//�����źŴ���ģ����������λ��������Ч�ź�
reg[7:0] r_rgb_image_rst;
reg[7:0] r_rgb_image_vld;

always @(posedge clk)
	if(!rst_n) r_rgb_image_rst <= 8'd0;
	else r_rgb_image_rst <= {r_rgb_image_rst[6:0],i_rgb_image_rst};

always @(posedge clk)
	if(!rst_n) r_rgb_image_vld <= 8'd0;
	else r_rgb_image_vld <= {r_rgb_image_vld[6:0],i_rgb_image_vld};
	
assign o_yuv_image_rst = r_rgb_image_rst[5];
assign o_yuv_image_vld = r_rgb_image_vld[5];
	
/*
RGBתYUV�Ļ�����ʽ���£�
��ʵ�ʹ���ʵ���У�������һЩ���ɣ����ٳ˷�����ʹ�ã�����ʵ���߼�Ҫ����һЩ��������ģ��ֻ����ֱ�Ӽ򵥵ķ�ʽʵ�����¹�ʽ��

Y 		= 0.299 * R + 0.587 * G + 0.114 * B
Y*1024	= (0.299 R + 0.587 G + 0.114 B)*1024 = 306 * R + 601 * G + 117 * B
Y		= (306 * R + 601 * G + 117 * B) / 1024 = (306 * R + 601 * G + 117 * B) >> 10

U 		= - 0.1687 * R - 0.3313 * G + 0.5 * B + 128
U * 1024	= (- 0.1687 * R - 0.3313 * G + 0.5 * B + 128) * 1024 = -173 * R - 339 * G + 512 * B + 131072 = (512 * B + 131072) - (173 * R + 339 * G)
U		= [(512 * B + 131072) - (173 * R + 339 * G)] / 1024 =  [(512 * B + 131072) - (173 * R + 339 * G)] >> 10

V 		= 0.5 * R - 0.4187 * G - 0.0813 * B + 128 
V * 1024	= (0.5 * R - 0.4187 * G - 0.0813 * B + 128) * 1024 = 512 * R - 429 * G - 83 * B + 131072 = (512 * R + 131072) - (429 * G + 83 * B) 
V		= [(512 * R + 131072) - (429 * G + 83 * B) ] / 1024 = [(512 * R + 131072) - (429 * G + 83 * B) ] >> 10
*/	
	
////////////////////////////////////////////////////////////////////////////////////////////////////////
//step1 �˷�����

////////////////////////////////////////////////////
//unsigned(0.10) * unsigned(8.0) for Y

wire[17:0] p_r306,p_g601,p_b117;

	//306 * R
mult_gen_0 mult_gen_0 (
  .CLK(clk),  // input wire CLK
  .A(10'd306),      // input wire [9 : 0] A
  .B(i_rgb_image_data[23:16]),      // input wire [7 : 0] B
  .P(p_r306)      // output wire [17 : 0] P
);

	//601 * G
mult_gen_0 mult_gen_1 (
  .CLK(clk),  // input wire CLK
  .A(10'd601),      // input wire [9 : 0] A
  .B(i_rgb_image_data[15:8]),      // input wire [7 : 0] B
  .P(p_g601)      // output wire [17 : 0] P
);

	//117 * B
mult_gen_0 mult_gen_2 (
  .CLK(clk),  // input wire CLK
  .A(10'd117),      // input wire [9 : 0] A
  .B(i_rgb_image_data[7:0]),      // input wire [7 : 0] B
  .P(p_b117)      // output wire [17 : 0] P
);

////////////////////////////////////////////////////
//unsigned(0.10) * unsigned(8.0) for U

wire[17:0] p_r173,p_g339,p_b512;

	//512 * B�����Կ�������λ�ķ�ʽʵ�֣���ʡһ���˷���
mult_gen_0 mult_gen_3 (
  .CLK(clk),  // input wire CLK
  .A(10'd512),      // input wire [9 : 0] A
  .B(i_rgb_image_data[7:0]),      // input wire [7 : 0] B
  .P(p_b512)      // output wire [17 : 0] P
);

	//173 * R
mult_gen_0 mult_gen_4 (
  .CLK(clk),  // input wire CLK
  .A(10'd173),      // input wire [9 : 0] A
  .B(i_rgb_image_data[23:16]),      // input wire [7 : 0] B
  .P(p_r173)      // output wire [17 : 0] P
);

	//339 * G
mult_gen_0 mult_gen_5 (
  .CLK(clk),  // input wire CLK
  .A(10'd339),      // input wire [9 : 0] A
  .B(i_rgb_image_data[15:8]),      // input wire [7 : 0] B
  .P(p_g339)      // output wire [17 : 0] P
);

////////////////////////////////////////////////////
//unsigned(0.10) * unsigned(8.0) for V

wire[17:0] p_r512,p_g429,p_b83;

	//512 * R�����Կ�������λ�ķ�ʽʵ�֣���ʡһ���˷���
mult_gen_0 mult_gen_6 (
  .CLK(clk),  // input wire CLK
  .A(10'd512),      // input wire [9 : 0] A
  .B(i_rgb_image_data[23:16]),      // input wire [7 : 0] B
  .P(p_r512)      // output wire [17 : 0] P
);

	//429 * G
mult_gen_0 mult_gen_7 (
  .CLK(clk),  // input wire CLK
  .A(10'd429),      // input wire [9 : 0] A
  .B(i_rgb_image_data[15:8]),      // input wire [7 : 0] B
  .P(p_g429)      // output wire [17 : 0] P
);

	//83 * B
mult_gen_0 mult_gen_8 (
  .CLK(clk),  // input wire CLK
  .A(10'd83),      // input wire [9 : 0] A
  .B(i_rgb_image_data[7:0]),      // input wire [7 : 0] B
  .P(p_b83)      // output wire [17 : 0] P
);

////////////////////////////////////////////////////////////////////////////////////////////////////////
//step2 Yȫ���Ӻͣ�U��V�ֱ�Լ����ͱ������Ӻ�

////////////////////////////////////////////////////
//for Y
reg[19:0] y_sum;

always @(posedge clk)
	if(!rst_n) y_sum <= 20'd0;
	else y_sum <= {2'd0,p_r306} + {2'd0,p_g601} + {2'd0,p_b117};

////////////////////////////////////////////////////
//for U
reg[19:0] u_sum1,u_sum2;

always @(posedge clk)
	if(!rst_n) u_sum1 <= 20'd0;
	else u_sum1 <= {2'd0,p_b512} + 20'd131072;
	
always @(posedge clk)
	if(!rst_n) u_sum2 <= 20'd0;
	else u_sum2 <= {2'd0,p_r173} + {2'd0,p_g339};
	
////////////////////////////////////////////////////
//for V
reg[19:0] v_sum1,v_sum2;

always @(posedge clk)
	if(!rst_n) v_sum1 <= 20'd0;
	else v_sum1 <= {2'd0,p_r512} + 20'd131072;
	
always @(posedge clk)
	if(!rst_n) v_sum2 <= 20'd0;
	else v_sum2 <= {2'd0,p_g429} + {2'd0,p_b83};
	
////////////////////////////////////////////////////////////////////////////////////////////////////////
//step3 ����ж�

////////////////////////////////////////////////////
//for Y
reg[17:0] y_result;

always @(posedge clk)
	if(!rst_n) y_result <= 18'd0;
	else if(y_sum[19:18] != 2'b00) y_result <= 18'h3ffff;	//�������ȡ���ֵ
	else y_result <= y_sum[17:0];
	
////////////////////////////////////////////////////
//for U
reg[17:0] u_result;
wire[19:0] u_sub = u_sum1-u_sum2;

always @(posedge clk)
	if(!rst_n) u_result <= 18'd0;
	else if(u_sum1 >= u_sum2) begin
		if(u_sub[19:18] != 2'b00) u_result <= 18'h3ffff;	//�������ȡ���ֵ
		else u_result <= u_sub[17:0];
	end
	else u_result <= 18'd0;	//�������ȡ0
	
////////////////////////////////////////////////////
//for V
reg[17:0] v_result;
wire[19:0] v_sub = v_sum1-v_sum2;

always @(posedge clk)
	if(!rst_n) v_result <= 18'd0;
	else if(v_sum1 >= v_sum2) begin
		if(v_sub[19:18] != 2'b00) v_result <= 18'h3ffff;	//�������ȡ���ֵ
		else v_result <= v_sub[17:0];
	end
	else v_result <= 18'd0;	//�������ȡ0

////////////////////////////////////////////////////////////////////////////////////////////////////////
//step4 ����10λ��YUV444תYUV422
reg yuv_sel;	//0--Y0U0, 1--Y1V0

always @(posedge clk)
	if(!rst_n) yuv_sel <= 1'b0;
	else if(r_rgb_image_rst[4]) yuv_sel <= 1'b0;
	else if(r_rgb_image_vld[4]) yuv_sel <= ~yuv_sel;
	
always @(posedge clk)
	if(!rst_n) o_yuv_image_data <= 16'd0;
	else if(r_rgb_image_vld[4]) begin
		if(!yuv_sel) o_yuv_image_data <= {y_result[17:10],u_result[17:10]};	//ȡY0U0
		else o_yuv_image_data <= {y_result[17:10],v_result[17:10]};	//ȡY1V0
	end
	else o_yuv_image_data <= 16'd0;
	
	
endmodule

