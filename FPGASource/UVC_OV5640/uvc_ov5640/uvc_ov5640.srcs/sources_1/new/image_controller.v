/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
module image_controller(
			input clk,	//50MHzʱ��
			input rst_n,	//��λ�źţ��͵�ƽ��Ч
				//ImageSensorͼ��ɼ��ӿ�
			(*mark_debug = "true"*) input image_sensor_pclk,	//��Ƶʱ��
			(*mark_debug = "true"*) input image_sensor_vsync,	//��Ƶ��ͬ���źţ��ߵ�ƽ��Ч����Ч��Ƶ����ʱ���ź����ͣ�
			(*mark_debug = "true"*) input image_sensor_href,	//��Ƶ��ͬ���ź�
			(*mark_debug = "true"*) input[7:0] image_sensor_data,	//��Ƶ��������
				//ImageSensor�������ýӿ�
			(*mark_debug = "true"*) output image_sensor_scl,	//��������IICʱ���ź�
			(*mark_debug = "true"*) inout image_sensor_sda,		//��������IIC�����ź�	
				//ImageSensor��λ��͹��Ľӿ�
			output image_sensor_reset_n,	//��λ�ӿڣ��͵�ƽ��Ч
			output image_sensor_pwdn,	//�͹���ʹ���źţ��ߵ�ƽ��Ч
				//ImageSensor����д��DDR3�ӿ�
			input image_ddr3_wready,
			output image_ddr3_wren,
			output image_ddr3_line_end,
			output image_ddr3_frame_start,
			output image_ddr3_frame_end,			
			output image_ddr3_clr,
			output[15:0] image_ddr3_wrdb			
		);

		
	//�͹���ʹ���źţ��ߵ�ƽ��Ч
assign image_sensor_pwdn = ~rst_n;
	
	//��λ�ӿڣ��͵�ƽ��Ч
assign image_sensor_reset_n = rst_n;		

////////////////////////////////////////////////////
//IIC�Ĵ�����ʼ������
wire tiic_init_done;	//IIC������ɱ�־λ���ߵ�ƽ��Ч

I2C_OV5640_Init_RAW		uut_I2C_OV5640_Init_RAW(
								.clk(clk),			//50MHz
								.rst_n(rst_n),		//Global Reset
								.i2c_sclk(image_sensor_scl),	//I2C CLOCK
								.i2c_sdat(image_sensor_sda),	//I2C DATA
								.config_done(tiic_init_done)	//Config Done
							);


////////////////////////////////////////////////////
//��Ƶ���뻺�����

image_capture		uut_image_capture(
						.clk(clk),	//ʱ���ź�
						.rst_n(rst_n & tiic_init_done),	//��λ�ź�				
							//ImageSensor�ɼ��ӿ�
						.image_sensor_pclk(image_sensor_pclk),	//��Ƶʱ��
						.image_sensor_vsync(image_sensor_vsync),	//��Ƶ��ͬ���źţ��ߵ�ƽ��Ч����Ч��Ƶ����ʱ���ź����ͣ�
						.image_sensor_href(image_sensor_href),	//��Ƶ��ͬ���ź�
						.image_sensor_data(image_sensor_data),	//��Ƶ��������
							//ImageSensor����д��DDR3�ӿ�
						.image_ddr3_wready(image_ddr3_wready),
						.image_ddr3_wren(image_ddr3_wren),
						.image_ddr3_line_end(image_ddr3_line_end),
						.image_ddr3_frame_start(image_ddr3_frame_start),
						.image_ddr3_frame_end(image_ddr3_frame_end),
						.image_ddr3_clr(image_ddr3_clr),
						.image_ddr3_wrdb(image_ddr3_wrdb)	
					);
					
					
endmodule

