/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////
module image_capture(
			input clk,	//ʱ���ź�
			input rst_n,	//��λ�ź�				
				//ImageSensorͼ��ɼ��ӿ�
			input image_sensor_pclk,	//��Ƶʱ��
			(*mark_debug = "true"*) input image_sensor_vsync,	//��Ƶ��ͬ���źţ��ߵ�ƽ��Ч����Ч��Ƶ����ʱ���ź����ͣ�
			(*mark_debug = "true"*) input image_sensor_href,	//��Ƶ��ͬ���ź�
			input[7:0] image_sensor_data,	//��Ƶ��������		
				//ImageSensor����д��DDR3�ӿ�
			input image_ddr3_wready,
			(*mark_debug = "true"*) output image_ddr3_wren,
			(*mark_debug = "true"*) output reg image_ddr3_line_end,
			(*mark_debug = "true"*) output reg image_ddr3_frame_start,
			(*mark_debug = "true"*) output reg image_ddr3_frame_end,
			(*mark_debug = "true"*) output reg image_ddr3_clr,
			output[15:0] image_ddr3_wrdb
		);
	
parameter RESOLUTION_HMAX = 10'd640;
parameter RESOLUTION_VMAX = 10'd480;	
	
////////////////////////////////////////////////////
//image_sensor_vsyncͬ����clkʱ����
wire pos_image_sensor_vsync;

pulse_detection		uut_pulse_detection1(
						.clk(clk),       	
						.in_sig(image_sensor_vsync),	//�����ź�
						.out_sig(),	//�������ź�ͬ��������ʱ���������
						.pos_sig(pos_image_sensor_vsync),	//�����źŵ������ؼ�⣬�����屣��һ��ʱ������
						.neg_sig()	//�����źŵ��½��ؼ�⣬�����屣��һ��ʱ������
					);						
						
reg[11:0] rst_cnt;
						
always @(posedge clk or negedge rst_n)
	if(!rst_n) rst_cnt <= 12'd0;
	else if(pos_image_sensor_vsync) rst_cnt <= 12'd1;
	else if(rst_cnt != 12'd0) rst_cnt <= rst_cnt+1'b1;
	else rst_cnt <= 12'd0;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) image_ddr3_clr <= 1'b1;
	else if((rst_cnt >= 12'h800) && (rst_cnt <= 12'h900)) image_ddr3_clr <= 1'b1;
	else image_ddr3_clr <= 1'b0;
						
////////////////////////////////////////////////////
//д�����ݲ���
/*
(*mark_debug = "true"*) reg[11:0] hcnt;

	//д��ͼ��H���������
always @(posedge image_sensor_pclk)		
	if(image_sensor_vsync) hcnt <= 12'd0;
	else if(image_sensor_href) hcnt <= hcnt+1'b1;
	else hcnt <= 12'd0;
	
reg image_cut_n;	//д��ͼ�����
	
always @(posedge image_sensor_pclk)		
	if(image_sensor_vsync) image_cut_n <= 1'b0;
	else if((hcnt > 12'd0) & (hcnt <= RESOLUTION_HMAX)) image_cut_n <= 1'b1;
	else image_cut_n <= 1'b0;
			*/
////////////////////////////////////////////////////
//���ݻ���FIFO����
//�����ݴ�Image Sensor��PCLKʱ����ת����FPGA�ڵ�50MHzʱ����
wire[9:0] image_fifo_rd_data_count;	//������Ч����
reg image_fifo_rd_en;	//FIFO�������ź�
		
fifo_generator_3 	uut_image_cache_fifo (
  .rst(image_ddr3_clr),                      // input wire rst
  .wr_clk(image_sensor_pclk),                // input wire wr_clk
  .rd_clk(clk),                // input wire rd_clk
  .din({8'd0,image_sensor_data}),                      // input wire [15 : 0] din
  .wr_en(image_sensor_href/* & image_cut_n*/),                  // input wire wr_en
  .rd_en(image_fifo_rd_en & image_ddr3_wready),                  // input wire rd_en
  .dout(image_ddr3_wrdb),                    // output wire [15 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(image_fifo_rd_data_count)  // output wire [9 : 0] rd_data_count
);

////////////////////////////////////////////////////
//��������16�����ݼ�������״̬��
parameter RFIFO_IDLE	= 3'd0;
parameter RFIFO_RDDB	= 3'd1;
parameter RFIFO_END1	= 3'd2;
reg[2:0] rfifo_state;
reg[9:0] dcnt;	//��FIFO���ݸ���������
reg[3:0] dly_cnt;

always @(posedge clk or negedge rst_n)
	if(!rst_n) rfifo_state <= RFIFO_IDLE;
	else if(image_ddr3_clr) rfifo_state <= RFIFO_IDLE;
	else begin
		case(rfifo_state)
			RFIFO_IDLE: if(image_fifo_rd_data_count >= (RESOLUTION_HMAX-5)) rfifo_state <= RFIFO_RDDB;
						else rfifo_state <= RFIFO_IDLE;
			RFIFO_RDDB: if(dcnt >= (RESOLUTION_HMAX+1)) rfifo_state <= RFIFO_END1;
						else rfifo_state <= RFIFO_RDDB;
			RFIFO_END1: if(dly_cnt >= 4'hf) rfifo_state <= RFIFO_IDLE;	
						else rfifo_state <= RFIFO_END1;							
			default: rfifo_state <= RFIFO_IDLE;
		endcase
	end
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) dly_cnt <= 10'd0;
	else if(rfifo_state == RFIFO_END1) dly_cnt <= dly_cnt+1'b1;
	else dly_cnt <= 10'd0;	
	
	//��FIFO���ݸ���������
always @(posedge clk or negedge rst_n)
	if(!rst_n) dcnt <= 10'd0;
	else if(rfifo_state == RFIFO_IDLE) dcnt <= 10'd0;
	else if(image_ddr3_wready) dcnt <= dcnt+1'b1;
	else ;

	//��FIFOʹ���źŲ����߼�
always @(posedge clk or negedge rst_n)
	if(!rst_n) image_fifo_rd_en	<= 1'b0;
	else if(rfifo_state == RFIFO_RDDB) begin
		if(dcnt < RESOLUTION_HMAX) image_fifo_rd_en <= 1'b1;
		else image_fifo_rd_en <= 1'b0;
	end
	else image_fifo_rd_en <= 1'b0;
	
////////////////////////////////////////////////////
//�͸�DDR3������ʹ���źš��н����źź�֡�����źŲ���

assign image_ddr3_wren = image_fifo_rd_en;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) image_ddr3_line_end <= 1'b0;
	else if((rfifo_state == RFIFO_RDDB) && (dcnt == (RESOLUTION_HMAX-1))) image_ddr3_line_end <= 1'b1;
	else image_ddr3_line_end <= 1'b0;

(*mark_debug = "true"*) reg[9:0] line_cnt;

always @(posedge clk or negedge rst_n)
	if(!rst_n) line_cnt <= 10'd0;
	else if(image_ddr3_clr) line_cnt <= 10'd0;
	else if(image_ddr3_line_end) line_cnt <= line_cnt+1'b1;

always @(posedge clk or negedge rst_n)
	if(!rst_n) image_ddr3_frame_start <= 1'b0;
	else if((line_cnt == 10'd0) && (rfifo_state == RFIFO_RDDB) && (dcnt == 10'd0)) image_ddr3_frame_start <= 1'b1;
	else image_ddr3_frame_start <= 1'b0;		
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) image_ddr3_frame_end <= 1'b0;
	else if((line_cnt == (RESOLUTION_VMAX-1)) && image_ddr3_line_end) image_ddr3_frame_end <= 1'b1;
	else image_ddr3_frame_end <= 1'b0;		

		
endmodule

