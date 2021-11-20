`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module UVC_OV5640(
			// DDR3接口
			inout [31:0]       ddr3_dq,
			inout [3:0]        ddr3_dqs_n,
			inout [3:0]        ddr3_dqs_p,
			output [14:0]     ddr3_addr,
			output [2:0]        ddr3_ba,
			output            ddr3_ras_n,
			output            ddr3_cas_n,
			output            ddr3_we_n,
			output            ddr3_reset_n,
			output [0:0]       ddr3_ck_p,
			output [0:0]       ddr3_ck_n,
			output [0:0]       ddr3_cke,
			output [3:0]     ddr3_dm,
			output [0:0]       ddr3_odt,
			// Single-ended system clock
			input       sys_clk_i,
			//input		ext_rst_n,	//高电平有效
				//ImageSensor图像接口
			//output image_sensor_xclk,	//输出时钟
			input image_sensor_pclk,	//视频时钟
			input image_sensor_vsync,	//视频场同步信号，高电平有效（有效视频传输时该信号拉低）
			input image_sensor_href,	//视频行同步信号
			input[7:0] image_sensor_data,	//视频数据总线
			output image_sensor_scl,	//串行配置IIC时钟信号
			inout image_sensor_sda,		//串行配置IIC数据信号	
			output image_sensor_reset_n,	//复位接口，低电平有效
			//output image_sensor_pwdn,	//低功耗使能信号，高电平有效		
				//FX3 Slave FIFO接口
			input fx3_flaga,	//地址00时，slave fifo写入满标志位
			input fx3_flagb,	//地址00时，slave fifo写入快满标志位，该位拉低后还可以写入6个Byte数据
			input fx3_flagc,	//ctl[8]，地址11时，slave fifo读空标志位
			input fx3_flagd,	//ctl[9]，地址11时，slave fifo读快空标志位，该位拉低后还可以写入6个Byte数据（该信号处上电为高电平）
			output fx3_pclk,		//Slave FIFO同步时钟信号
			output fx3_slcs_n,		//Slave FIFO片选信号，低电平有效
			output fx3_slwr_n,		//Slave FIFO写使能信号，低电平有效
			output fx3_slrd_n,		//Slave FIFO读使能信号，低电平有效
			output fx3_sloe_n,		//Slave FIFO输出使能信号，低电平有效
			output fx3_pktend_n,
			output[1:0] fx3_a,
			output[31:0] fx3_db,
			output FX3_RESET,	
				//拨码开关
			//input switch,			
		/*		//VGA驱动接口
			output[4:0] vga_r,
			output[5:0] vga_g,
			output[4:0] vga_b,
			output[2:0] vga_rgb,
			output vga_hsy,vga_vsy,
			output vga_clk,
			output adv7123_blank_n,
			output adv7123_sync_n,	*/	
				//LED指示灯接口
			output[0:0] led		//用于测试的LED指示灯
    );



assign FX3_RESET = 1'b1;
//切换显示数据
wire switch,switch_in;
//assign switch = 1'b0;


vio_0 u9_vio (
  .clk(sys_clk_i),                // input wire clk
  .probe_in0(switch_in),    // input wire [0 : 0] probe_in0
  .probe_out0(switch)  // output wire [0 : 0] probe_out0
);
////////////////////////////////////////////////////
//PLL例化
wire clk_200m;
wire clk_25m;
wire clk_50m;
//wire clk_65m;
wire clk_75m;
wire clk_108m;
wire clk_130m;
wire sys_rst_n;
	
  clk_wiz_1 	u1_clk_wiz_0
   (
   // Clock in ports
    .clk_in1(sys_clk_i),      // input clk_in1
    // Clock out ports
    .clk_out1(clk_200m),     // output clk_out1
	.clk_out2(clk_25m),
	.clk_out3(clk_50m),
	.clk_out4(fx3_pclk),	//75MHz@180°
	.clk_out5(clk_75m),
	.clk_out6(clk_108m),
	.clk_out7(clk_130m),
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(sys_rst_n));      // output locked	
	
//assign image_sensor_xclk = clk_25m;
	
////////////////////////////////////////////////////
//DDR3 controller例化
	//DDR3控制器IP的用户接口信号：时钟与复位
wire ui_clk;	//时钟信号，是DDR3时钟（400MHz）的1/4，即100MHz
wire ui_clk_sync_rst;	//复位信号
	//DDR3控制器IP的用户接口信号：控制信号
wire[27:0] app_addr;	//DDR3地址总线
wire[2:0] app_cmd;		//DDR3命令总线，3‘b000--写；3'b001--读；3‘b011--wr_bytes（With ECC enabled, the wr_bytes operation is required for writes with any non-zero app_wdf_mask bits.）
wire app_en;	//DDR3操作请求信号，高电平有效
wire app_rdy;	//DDR3操作响应信号，表示当前的app_en请求已经获得响应，可以继续操作
wire init_calib_complete;	//校准初始化完成标志信号，高电平有效
	//DDR3控制器IP的用户接口信号：写数据信号
wire[127:0] app_wdf_data;	//DDR3写入数据总线
wire app_wdf_end;	//DDR3最后一个字节写入指示信号，与app_wdf_data同步指示当前操作为最后一个数据写入
//input [15:0]        app_wdf_mask;	//DDR3写入数据位屏蔽信号
wire app_wdf_wren;	//DDR3写入数据使能信号，表示当前写入数据有效
wire app_wdf_rdy;	//DDR3可以执行写入数据操作，该信号拉高表示写数据FIFO已经准备好接收数据
	//DDR3控制器IP的用户接口信号：读数据信号
wire[127:0] app_rd_data;	//DDR3读取数据总线
wire app_rd_data_end;	//DDR3最有一个字节读取指示信号，与app_rd_data同步指示当前操作为最后一个数据读出
wire app_rd_data_valid;	//DDR3读出数据使能信号，表示当前读出数据有效
	//DDR3控制器IP的用户接口信号：刷新请求与响应
wire app_ref_req = 1'b0;	//DDR3刷新请求信号，高电平有效，该信号拉高必须保持到app_ref_ack拉高表示刷新请求已经响应
wire app_ref_ack;	//DDR3刷新响应信号，高电平有效，该信号拉高表示已经执行DDR3的刷新操作
	//DDR3控制器IP的用户接口信号：ZQ校准请求与响应
wire app_zq_req = 1'b0;	//DDR3 ZQ校准命令请求信号，高电平有效，该信号拉高必须保持到app_zq_ack拉高表示刷新请求已经响应
wire app_zq_ack;	//DDR3 ZQ校准响应信号，高电平有效，该信号拉高表示已经执行DDR3的ZQ校准操作
	//DDR3控制器IP的用户接口信号：
wire app_sr_req = 1'b0;
wire app_sr_active;
		  
		  
mig_7series_0 		u2_mig_7series_1 (
    // Memory interface ports
    .ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
    .ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
    .ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
    .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
    .ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
    .ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
    .ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
    .ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
    .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
    .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
    .init_calib_complete            (init_calib_complete),  // output			init_calib_complete
      
    .ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
    .ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
    // Application interface ports
    .app_addr                       (app_addr),  // input [27:0]		app_addr
    .app_cmd                        (app_cmd),  // input [2:0]		app_cmd
    .app_en                         (app_en),  // input				app_en
    .app_wdf_data                   (app_wdf_data),  // input [127:0]		app_wdf_data
    .app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
    .app_wdf_wren                   (app_wdf_wren),  // input				app_wdf_wren
    .app_rd_data                    (app_rd_data),  // output [127:0]		app_rd_data
    .app_rd_data_end                (app_rd_data_end),  // output			app_rd_data_end
    .app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
    .app_rdy                        (app_rdy),  // output			app_rdy
    .app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
    .app_sr_req                     (app_sr_req),  // input			app_sr_req
    .app_ref_req                    (app_ref_req),  // input			app_ref_req
    .app_zq_req                     (app_zq_req),  // input			app_zq_req
    .app_sr_active                  (app_sr_active),  // output			app_sr_active
    .app_ref_ack                    (app_ref_ack),  // output			app_ref_ack
    .app_zq_ack                     (app_zq_ack),  // output			app_zq_ack
    .ui_clk                         (ui_clk),  // output			ui_clk
    .ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
    .app_wdf_mask                   (16'h00/*app_wdf_mask*/),  // input [15:0]		app_wdf_mask
    // System Clock Ports
    .sys_clk_i                      (clk_200m),  // input			sys_clk_i
    .sys_rst                        (1'b1) // input sys_rst
    );	

////////////////////////////////////////////////////
//ImageSensor图像采集控制模块
	//ImageSensor数据写入DDR3接口
wire image_ddr3_wready;	
wire image_ddr3_wren_left;
wire image_ddr3_clr;
wire[15:0] image_ddr3_wrdb_left;
wire image_ddr3_frame_start;
wire image_ddr3_line_end;
wire image_ddr3_frame_end;

image_controller	u3_image_controller(
			.clk(clk_50m),	//时钟信号
			.rst_n(1'b1),	//复位信号
				//ImageSensor图像采集接口
			.image_sensor_pclk(image_sensor_pclk),
			.image_sensor_vsync(~image_sensor_vsync),
			.image_sensor_href(image_sensor_href),
			.image_sensor_data(image_sensor_data),
				//ImageSensor串行配置接口
			.image_sensor_scl(image_sensor_scl),
			.image_sensor_sda(image_sensor_sda),	
				//ImageSensor复位与低功耗接口
			.image_sensor_reset_n(image_sensor_reset_n),
			.image_sensor_pwdn( ),
				//ImageSensor数据写入DDR3接口
			.image_ddr3_wready(image_ddr3_wready),	
			.image_ddr3_wren(image_ddr3_wren_left),
			.image_ddr3_wrdb(image_ddr3_wrdb_left),	
			.image_ddr3_line_end(image_ddr3_line_end),
			.image_ddr3_frame_start(image_ddr3_frame_start),
			.image_ddr3_frame_end(image_ddr3_frame_end),
			.image_ddr3_clr(image_ddr3_clr)		
		);

////////////////////////////////////////////////////
//Bayer2RGB处理模块
wire w_rgb_image_rst;
wire w_rgb_image_vld;
wire[23:0] w_rgb_image_data;	//R = w_rgb_image_data[23:16], G = w_rgb_image_data[7:0], B = w_rgb_image_data[15:8]	

bayer2rgb			u4_bayer2rgb(		 
						.clk(clk_50m),
						.rst_n(1'b1),
						//input Image Data Flow
						.i_bayer_image_vld(image_ddr3_wren_left),
						.o_bayer_image_tready(image_ddr3_wready),
						.i_bayer_image_data(image_ddr3_wrdb_left[7:0]),	
						.i_bayer_image_sof(image_ddr3_frame_start),
						.i_bayer_image_eof(image_ddr3_frame_end),
						.i_bayer_image_eol(image_ddr3_line_end),
						//output Image Data Flow
						.o_rgb_image_rst(w_rgb_image_rst),
						.o_rgb_image_vld(w_rgb_image_vld),
						.o_rgb_image_data(w_rgb_image_data)
					);	


////////////////////////////////////////////////////
//RGB2YUV转换模块
wire w_yuv_image_rst;
wire w_yuv_image_vld;
wire[15:0] w_yuv_image_data;	
					
rgb2yuv			u5_rgb2yuv(		 
						.clk(clk_50m),
						.rst_n(sys_rst_n),
						//input Image Data Flow
						.i_rgb_image_rst(w_rgb_image_rst),
						.i_rgb_image_vld(w_rgb_image_vld),
						.i_rgb_image_data({w_rgb_image_data[23:16],w_rgb_image_data[7:0],w_rgb_image_data[15:8]}),
						//output Image Data Flow
						.o_yuv_image_rst(w_yuv_image_rst),
						.o_yuv_image_vld(w_yuv_image_vld),
						.o_yuv_image_data(w_yuv_image_data)	//bit15-8 is Y, bit7-0 is U or V, YUV422
					);						
		 
////////////////////////////////////////////////////
//DDR3的读写缓存控制模块	
wire image_lcd_clk;			//读DDR3数据同步时钟
wire image_lcd_clr;			//读DDR3帧图像同步信号，高电平有效（无数据）
//wire image_lcd_rdreq_left;		//读DDR3帧图像请求信号
//wire[15:0] image_lcd_data_left;	//读DDR3帧图像数据
wire image_lcd_rdreq;
wire[15:0] image_lcd_data;	//读DDR3帧图像数据
			
ddr3_cache		u6_ddr3_cache(
					.clk(ui_clk),
					.image_lcd_clk(image_lcd_clk),
					.rst_n(!ui_clk_sync_rst & init_calib_complete),
					.app_addr(app_addr),
					.app_cmd(app_cmd),
					.app_en(app_en),
					.app_rdy(app_rdy),
					.app_wdf_data(app_wdf_data),
					.app_wdf_end(app_wdf_end),
					.app_wdf_wren(app_wdf_wren),
					.app_wdf_rdy(app_wdf_rdy),
					.app_rd_data(app_rd_data),
					.app_rd_data_end(app_rd_data_end),
					.app_rd_data_valid(app_rd_data_valid),
					.image_pclk(clk_50m),
					
					.image_ddr3_clr(w_yuv_image_rst),					
					.image_ddr3_wren_left(1'b0/*image_ddr3_wren_left*/),
					.image_ddr3_wrdb_left(16'd0/*{image_ddr3_wrdb_left[7:3],image_ddr3_wrdb_left[7:2],image_ddr3_wrdb_left[7:3]}*/),
					.image_ddr3_wren_righ(w_yuv_image_vld),
					.image_ddr3_wrdb_righ(w_yuv_image_data),
					
					.image_lcd_rdreq_left(1'b0/*image_lcd_rdreq_left*/),
					.image_lcd_data_left(/*image_lcd_data_left*/),		
					.image_lcd_rdreq_righ(image_lcd_rdreq),
					.image_lcd_data_righ(image_lcd_data),
					
					.image_lcd_clr(image_lcd_clr)
				);	
				
////////////////////////////////////////////////////
//液晶显示驱动模块
/*
lcd_driver		u6_lcd_driver(	
					.clk_25m(clk_25m),
					.clk_50m(clk_50m),
					.clk_65m(clk_65m),
					.clk_75m(clk_75m),
					.clk_108m(clk_108m),
					.clk_130m(clk_130m),
					.rst_n(sys_rst_n),
					.vga_r(vga_r),
					.vga_g(vga_g),
					.vga_b(vga_b),
					.vga_rgb(vga_rgb),
					.vga_hsy(vga_hsy),
					.vga_vsy(vga_vsy),
					.vga_clk(vga_clk),
					.adv7123_blank_n(adv7123_blank_n),
					.adv7123_sync_n(adv7123_sync_n),
					.lcd_synclk(image_lcd_clk),
					.lcd_rfdb1(),	
				//	.lcd_rfdb2(image_lcd_data_right),
				//	.lcd_rfreq1(),	
				//	.lcd_rfreq2(image_lcd_rdreq_right),
				//	.lcd_rfclr(image_lcd_clr)		
				//	);	*/								
						
//-------------------------------------
//FX3 Slave FIFO 图像数据传输模块

lcd_driver		u7_lcd_driver(	
					.clk(clk_75m),
					.rst_n(1'b1),
					.switch(switch),
					.vga_rst_n(fx3_flagb),
					.vga_rgb(fx3_db[7:0]),
					.vga_hsy(fx3_a[1]),
					.vga_vsy(fx3_a[0]),				
					.lcd_synclk(image_lcd_clk),
					.lcd_rfdb(image_lcd_data),	
					.lcd_rfreq(image_lcd_rdreq),		
					.lcd_rfclr(image_lcd_clr)		
					);		

assign fx3_db[31:8] = 24'hzzzzzz;	

						
////////////////////////////////////////////////////
//LED闪烁逻辑产生模块例化

led_controller		u8_led_controller(
						.clk(ui_clk),			
						.rst_n(!ui_clk_sync_rst),
						.led(led[0])
					);	
	
	
endmodule

