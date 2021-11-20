/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
module image_controller(
			input clk,	//50MHz时钟
			input rst_n,	//复位信号，低电平有效
				//ImageSensor图像采集接口
			(*mark_debug = "true"*) input image_sensor_pclk,	//视频时钟
			(*mark_debug = "true"*) input image_sensor_vsync,	//视频场同步信号，高电平有效（有效视频传输时该信号拉低）
			(*mark_debug = "true"*) input image_sensor_href,	//视频行同步信号
			(*mark_debug = "true"*) input[7:0] image_sensor_data,	//视频数据总线
				//ImageSensor串行配置接口
			(*mark_debug = "true"*) output image_sensor_scl,	//串行配置IIC时钟信号
			(*mark_debug = "true"*) inout image_sensor_sda,		//串行配置IIC数据信号	
				//ImageSensor复位与低功耗接口
			output image_sensor_reset_n,	//复位接口，低电平有效
			output image_sensor_pwdn,	//低功耗使能信号，高电平有效
				//ImageSensor数据写入DDR3接口
			input image_ddr3_wready,
			output image_ddr3_wren,
			output image_ddr3_line_end,
			output image_ddr3_frame_start,
			output image_ddr3_frame_end,			
			output image_ddr3_clr,
			output[15:0] image_ddr3_wrdb			
		);

		
	//低功耗使能信号，高电平有效
assign image_sensor_pwdn = ~rst_n;
	
	//复位接口，低电平有效
assign image_sensor_reset_n = rst_n;		

////////////////////////////////////////////////////
//IIC寄存器初始化配置
wire tiic_init_done;	//IIC配置完成标志位，高电平有效

I2C_OV5640_Init_RAW		uut_I2C_OV5640_Init_RAW(
								.clk(clk),			//50MHz
								.rst_n(rst_n),		//Global Reset
								.i2c_sclk(image_sensor_scl),	//I2C CLOCK
								.i2c_sdat(image_sensor_sda),	//I2C DATA
								.config_done(tiic_init_done)	//Config Done
							);


////////////////////////////////////////////////////
//视频输入缓存控制

image_capture		uut_image_capture(
						.clk(clk),	//时钟信号
						.rst_n(rst_n & tiic_init_done),	//复位信号				
							//ImageSensor采集接口
						.image_sensor_pclk(image_sensor_pclk),	//视频时钟
						.image_sensor_vsync(image_sensor_vsync),	//视频场同步信号，高电平有效（有效视频传输时该信号拉低）
						.image_sensor_href(image_sensor_href),	//视频行同步信号
						.image_sensor_data(image_sensor_data),	//视频数据总线
							//ImageSensor数据写入DDR3接口
						.image_ddr3_wready(image_ddr3_wready),
						.image_ddr3_wren(image_ddr3_wren),
						.image_ddr3_line_end(image_ddr3_line_end),
						.image_ddr3_frame_start(image_ddr3_frame_start),
						.image_ddr3_frame_end(image_ddr3_frame_end),
						.image_ddr3_clr(image_ddr3_clr),
						.image_ddr3_wrdb(image_ddr3_wrdb)	
					);
					
					
endmodule

