`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////

module UVC_OV5640(
			// DDR3�ӿ�
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
			//input		ext_rst_n,	//�ߵ�ƽ��Ч
				//ImageSensorͼ��ӿ�
			//output image_sensor_xclk,	//���ʱ��
			input image_sensor_pclk,	//��Ƶʱ��
			input image_sensor_vsync,	//��Ƶ��ͬ���źţ��ߵ�ƽ��Ч����Ч��Ƶ����ʱ���ź����ͣ�
			input image_sensor_href,	//��Ƶ��ͬ���ź�
			input[7:0] image_sensor_data,	//��Ƶ��������
			output image_sensor_scl,	//��������IICʱ���ź�
			inout image_sensor_sda,		//��������IIC�����ź�	
			output image_sensor_reset_n,	//��λ�ӿڣ��͵�ƽ��Ч
			//output image_sensor_pwdn,	//�͹���ʹ���źţ��ߵ�ƽ��Ч		
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
			output[31:0] fx3_db,
			output FX3_RESET,	
				//���뿪��
			//input switch,			
		/*		//VGA�����ӿ�
			output[4:0] vga_r,
			output[5:0] vga_g,
			output[4:0] vga_b,
			output[2:0] vga_rgb,
			output vga_hsy,vga_vsy,
			output vga_clk,
			output adv7123_blank_n,
			output adv7123_sync_n,	*/	
				//LEDָʾ�ƽӿ�
			output[0:0] led		//���ڲ��Ե�LEDָʾ��
    );



assign FX3_RESET = 1'b1;
//�л���ʾ����
wire switch,switch_in;
//assign switch = 1'b0;


vio_0 u9_vio (
  .clk(sys_clk_i),                // input wire clk
  .probe_in0(switch_in),    // input wire [0 : 0] probe_in0
  .probe_out0(switch)  // output wire [0 : 0] probe_out0
);
////////////////////////////////////////////////////
//PLL����
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
	.clk_out4(fx3_pclk),	//75MHz@180��
	.clk_out5(clk_75m),
	.clk_out6(clk_108m),
	.clk_out7(clk_130m),
    // Status and control signals
    .reset(1'b0), // input reset
    .locked(sys_rst_n));      // output locked	
	
//assign image_sensor_xclk = clk_25m;
	
////////////////////////////////////////////////////
//DDR3 controller����
	//DDR3������IP���û��ӿ��źţ�ʱ���븴λ
wire ui_clk;	//ʱ���źţ���DDR3ʱ�ӣ�400MHz����1/4����100MHz
wire ui_clk_sync_rst;	//��λ�ź�
	//DDR3������IP���û��ӿ��źţ������ź�
wire[27:0] app_addr;	//DDR3��ַ����
wire[2:0] app_cmd;		//DDR3�������ߣ�3��b000--д��3'b001--����3��b011--wr_bytes��With ECC enabled, the wr_bytes operation is required for writes with any non-zero app_wdf_mask bits.��
wire app_en;	//DDR3���������źţ��ߵ�ƽ��Ч
wire app_rdy;	//DDR3������Ӧ�źţ���ʾ��ǰ��app_en�����Ѿ������Ӧ�����Լ�������
wire init_calib_complete;	//У׼��ʼ����ɱ�־�źţ��ߵ�ƽ��Ч
	//DDR3������IP���û��ӿ��źţ�д�����ź�
wire[127:0] app_wdf_data;	//DDR3д����������
wire app_wdf_end;	//DDR3���һ���ֽ�д��ָʾ�źţ���app_wdf_dataͬ��ָʾ��ǰ����Ϊ���һ������д��
//input [15:0]        app_wdf_mask;	//DDR3д������λ�����ź�
wire app_wdf_wren;	//DDR3д������ʹ���źţ���ʾ��ǰд��������Ч
wire app_wdf_rdy;	//DDR3����ִ��д�����ݲ��������ź����߱�ʾд����FIFO�Ѿ�׼���ý�������
	//DDR3������IP���û��ӿ��źţ��������ź�
wire[127:0] app_rd_data;	//DDR3��ȡ��������
wire app_rd_data_end;	//DDR3����һ���ֽڶ�ȡָʾ�źţ���app_rd_dataͬ��ָʾ��ǰ����Ϊ���һ�����ݶ���
wire app_rd_data_valid;	//DDR3��������ʹ���źţ���ʾ��ǰ����������Ч
	//DDR3������IP���û��ӿ��źţ�ˢ����������Ӧ
wire app_ref_req = 1'b0;	//DDR3ˢ�������źţ��ߵ�ƽ��Ч�����ź����߱��뱣�ֵ�app_ref_ack���߱�ʾˢ�������Ѿ���Ӧ
wire app_ref_ack;	//DDR3ˢ����Ӧ�źţ��ߵ�ƽ��Ч�����ź����߱�ʾ�Ѿ�ִ��DDR3��ˢ�²���
	//DDR3������IP���û��ӿ��źţ�ZQУ׼��������Ӧ
wire app_zq_req = 1'b0;	//DDR3 ZQУ׼���������źţ��ߵ�ƽ��Ч�����ź����߱��뱣�ֵ�app_zq_ack���߱�ʾˢ�������Ѿ���Ӧ
wire app_zq_ack;	//DDR3 ZQУ׼��Ӧ�źţ��ߵ�ƽ��Ч�����ź����߱�ʾ�Ѿ�ִ��DDR3��ZQУ׼����
	//DDR3������IP���û��ӿ��źţ�
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
//ImageSensorͼ��ɼ�����ģ��
	//ImageSensor����д��DDR3�ӿ�
wire image_ddr3_wready;	
wire image_ddr3_wren_left;
wire image_ddr3_clr;
wire[15:0] image_ddr3_wrdb_left;
wire image_ddr3_frame_start;
wire image_ddr3_line_end;
wire image_ddr3_frame_end;

image_controller	u3_image_controller(
			.clk(clk_50m),	//ʱ���ź�
			.rst_n(1'b1),	//��λ�ź�
				//ImageSensorͼ��ɼ��ӿ�
			.image_sensor_pclk(image_sensor_pclk),
			.image_sensor_vsync(~image_sensor_vsync),
			.image_sensor_href(image_sensor_href),
			.image_sensor_data(image_sensor_data),
				//ImageSensor�������ýӿ�
			.image_sensor_scl(image_sensor_scl),
			.image_sensor_sda(image_sensor_sda),	
				//ImageSensor��λ��͹��Ľӿ�
			.image_sensor_reset_n(image_sensor_reset_n),
			.image_sensor_pwdn( ),
				//ImageSensor����д��DDR3�ӿ�
			.image_ddr3_wready(image_ddr3_wready),	
			.image_ddr3_wren(image_ddr3_wren_left),
			.image_ddr3_wrdb(image_ddr3_wrdb_left),	
			.image_ddr3_line_end(image_ddr3_line_end),
			.image_ddr3_frame_start(image_ddr3_frame_start),
			.image_ddr3_frame_end(image_ddr3_frame_end),
			.image_ddr3_clr(image_ddr3_clr)		
		);

////////////////////////////////////////////////////
//Bayer2RGB����ģ��
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
//RGB2YUVת��ģ��
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
//DDR3�Ķ�д�������ģ��	
wire image_lcd_clk;			//��DDR3����ͬ��ʱ��
wire image_lcd_clr;			//��DDR3֡ͼ��ͬ���źţ��ߵ�ƽ��Ч�������ݣ�
//wire image_lcd_rdreq_left;		//��DDR3֡ͼ�������ź�
//wire[15:0] image_lcd_data_left;	//��DDR3֡ͼ������
wire image_lcd_rdreq;
wire[15:0] image_lcd_data;	//��DDR3֡ͼ������
			
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
//Һ����ʾ����ģ��
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
//FX3 Slave FIFO ͼ�����ݴ���ģ��

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
//LED��˸�߼�����ģ������

led_controller		u8_led_controller(
						.clk(ui_clk),			
						.rst_n(!ui_clk_sync_rst),
						.led(led[0])
					);	
	
	
endmodule

