
module sim_rgb2yuv(
					
		);
		
reg clk;
reg rst_n;	//��λ�ź�				

reg image_sensor_vsync;	//��Ƶ��ͬ���źţ��ߵ�ƽ��Ч����Ч��Ƶ����ʱ���ź����ͣ�
reg image_sensor_href;	//��Ƶ��ͬ���ź�
reg[23:0] image_sensor_data;	//��Ƶ��������		

wire w_yuv_image_rst;
wire w_yuv_image_vld;
wire[15:0] w_yuv_image_data;
	
////////////////////////////////////////////////////
//������ģ������

rgb2yuv			u5_rgb2yuv(		 
						.clk(clk),
						.rst_n(rst_n),
						//input Image Data Flow
						.i_rgb_image_rst(image_sensor_vsync),
						.i_rgb_image_vld(image_sensor_href),
						.i_rgb_image_data(image_sensor_data),
						//output Image Data Flow
						.o_yuv_image_rst(w_yuv_image_rst),
						.o_yuv_image_vld(w_yuv_image_vld),
						.o_yuv_image_data(w_yuv_image_data)	//bit15-8 is Y, bit7-0 is U or V, YUV422
					);	
					
integer i,j;	
	
initial begin
	clk = 0;
	rst_n = 0;
	image_sensor_vsync = 0;
	image_sensor_href = 0;
	image_sensor_data = 0;
	#1000;
	rst_n = 1;
	#10_000;
	
	image_sensor_vsync = 1;
	#10_000;
	image_sensor_vsync = 0;
	#10_000;
	
	for(i=0;i<480;i=i+1) begin
		for(j=0;j<640;j=j+1) begin
			@(posedge clk) #3;
			image_sensor_href = 1;
			image_sensor_data[23:16] = {$random} % 256;	//0-255֮��������
			image_sensor_data[15:8] = {$random} % 256;	//0-255֮��������
			image_sensor_data[7:0] = {$random} % 256;	//0-255֮��������
		end
		@(posedge clk) #3;
		image_sensor_href = 0;
		#10_000;
	end	
	
	#10000;
	$stop;
end	
	
always #10 clk = ~clk;	
	

endmodule

