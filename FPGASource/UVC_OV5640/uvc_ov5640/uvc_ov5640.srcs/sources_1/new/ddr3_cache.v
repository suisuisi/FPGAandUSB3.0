/////////////////////////////////////////////////////////////////////////////

module ddr3_cache(
				//DDR3������IP���û��ӿ��źţ�ʱ���븴λ
			input clk,	//ʱ���źţ���DDR3ʱ�ӣ�400MHz����1/4����100MHz
			input image_lcd_clk,	//LCD����ʱ��33MHz
			input rst_n,	//��λ�ź�
			
			//DDR3 Controller IP�ӿ�
				//DDR3������IP���û��ӿ��źţ������ź�
			output reg[27:0] app_addr,		//DDR3��ַ����
			output reg[2:0] app_cmd,		//DDR3�������ߣ�3��b000--д��3'b001--����3��b011--wr_bytes��With ECC enabled, the wr_bytes operation is required for writes with any non-zero app_wdf_mask bits.��
			output reg app_en,				//DDR3���������źţ��ߵ�ƽ��Ч
			input app_rdy,					//DDR3������Ӧ�źţ���ʾ��ǰ��app_en�����Ѿ������Ӧ�����Լ�������
				//DDR3������IP���û��ӿ��źţ�д�����ź�
			output[127:0] app_wdf_data,		//DDR3д����������
			output app_wdf_end,			//DDR3���һ���ֽ�д��ָʾ�źţ���app_wdf_dataͬ��ָʾ��ǰ����Ϊ���һ������д��
			output reg app_wdf_wren,		//DDR3д������ʹ���źţ���ʾ��ǰд��������Ч
			input app_wdf_rdy,				//DDR3����ִ��д�����ݲ��������ź����߱�ʾд����FIFO�Ѿ�׼���ý�������
				//DDR3������IP���û��ӿ��źţ��������ź�
			input[127:0] app_rd_data,		//DDR3��ȡ��������
			input app_rd_data_end,			//DDR3���һ���ֽڶ�ȡָʾ�źţ���app_rd_dataͬ��ָʾ��ǰ����Ϊ���һ�����ݶ���
			input app_rd_data_valid,		//DDR3��������ʹ���źţ���ʾ��ǰ����������Ч
			
				//ImageSensor����д��DDR3�ӿ�
			input image_pclk,
			input image_ddr3_clr,			
			input image_ddr3_wren_left,
			input[15:0] image_ddr3_wrdb_left,
			input image_ddr3_wren_righ,
			input[15:0] image_ddr3_wrdb_righ,
			
				//LCDģ���DDR3���ݽӿ�
			output[15:0] image_lcd_data_left,	//�����LCDģ�����ʾ��DDR3��������
			input image_lcd_rdreq_left,		//LCDģ�鷢���Ķ�FIFO�����źţ��ߵ�ƽ��Ч
			output[15:0] image_lcd_data_righ,	//��DDR3֡ͼ������			
			input image_lcd_rdreq_righ,		//��DDR3֡ͼ�������ź�
			input image_lcd_clr		//LCDģ�鷢���Ķ�FIFO��λ���͵�ƽ��Ч
			
		);
		
////////////////////////////////////////////////////
//DDR3�ĵ��β�����������32*128bit = 256*16bit����
parameter BURST_WR_128BIT = 10'd8;//10'd256;	//burstд��������
parameter BURST_RD_128BIT = 10'd256;	//burst����������	
parameter DLY_CLK_AFTER_RD = 10'd16;

parameter DDR3_ADDR_LEFT_STAR = 17'h0_0000;	
parameter DDR3_ADDR_RIGH_STAR = 17'h0_1000;

////////////////////////////////////////////////////
//image_ddr3_clrͬ����clkʱ����
wire image_ddr3_clr_r;

register_diff_clk		register_diff_clk_dc1(
							.clk(clk),		
							.rst_n(rst_n),	
							.in_a(image_ddr3_clr),
							.out_b(image_ddr3_clr_r)	
						);

////////////////////////////////////////////////////
//д����FIFO
//����FIFO���ݴ����32*128bitʱ�ͷ���дDDR3����	
wire[9:0] wfifo_rd_data_count1,wfifo_rd_data_count2;
wire[127:0] wfifo_rd_data1,wfifo_rd_data2;
reg wfifo_rd_en1,wfifo_rd_en2;
	
fifo_generator_1 	fifo_for_ddr3_write_left (
  .rst(!rst_n || image_ddr3_clr_r),                	// input wire rst
  .wr_clk(image_pclk),         	// input wire wr_clk
  .rd_clk(clk),                	// input wire rd_clk
  .din(image_ddr3_wrdb_left),       	// input wire [15 : 0] din
  .wr_en(image_ddr3_wren_left),     	// input wire wr_en
  .rd_en(wfifo_rd_en1),         	// input wire rd_en
  .dout(wfifo_rd_data1),        	// output wire [127 : 0] dout
  .full(),                   	// output wire full
  .empty(),                  	// output wire empty
  .rd_data_count(wfifo_rd_data_count1)  // output wire [9 : 0] rd_data_count
);	

fifo_generator_1 	fifo_for_ddr3_write_righ (
  .rst(!rst_n || image_ddr3_clr_r),                	// input wire rst
  .wr_clk(image_pclk),         	// input wire wr_clk
  .rd_clk(clk),                	// input wire rd_clk
  .din(image_ddr3_wrdb_righ),       	// input wire [15 : 0] din
  .wr_en(image_ddr3_wren_righ),     	// input wire wr_en
  .rd_en(wfifo_rd_en2),         	// input wire rd_en
  .dout(wfifo_rd_data2),        	// output wire [127 : 0] dout
  .full(),                   	// output wire full
  .empty(),                  	// output wire empty
  .rd_data_count(wfifo_rd_data_count2)  // output wire [9 : 0] rd_data_count
);		

reg[21:0] user_ddr3_write_addr1;	//DDR3д���ַ
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) user_ddr3_write_addr1 <= {DDR3_ADDR_LEFT_STAR,5'd0};
	else if(image_ddr3_clr_r) user_ddr3_write_addr1 <= {DDR3_ADDR_LEFT_STAR,5'd0};
	else if(cstate == SWRED1) user_ddr3_write_addr1 <= user_ddr3_write_addr1+1'b1;	
	
reg[21:0] user_ddr3_write_addr2;	//DDR3д���ַ
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) user_ddr3_write_addr2 <= {DDR3_ADDR_RIGH_STAR,5'd0};
	else if(image_ddr3_clr_r) user_ddr3_write_addr2 <= {DDR3_ADDR_RIGH_STAR,5'd0};
	else if(cstate == SWRED2) user_ddr3_write_addr2 <= user_ddr3_write_addr2+1'b1;		
	
////////////////////////////////////////////////////
//image_lcd_clrͬ����clkʱ����
wire image_lcd_clr_r;
wire pos_image_lcd_clr;
						
pulse_detection		uut_pulse_detection_dc2(
						.clk(clk),       	
						.in_sig(image_lcd_clr),	//�����ź�
						.out_sig(image_lcd_clr_r),	//�������ź�ͬ��������ʱ���������
						.pos_sig(pos_image_lcd_clr),	//�����źŵ������ؼ�⣬�����屣��һ��ʱ������
						.neg_sig()	//�����źŵ��½��ؼ�⣬�����屣��һ��ʱ������
					);						
						
reg[3:0] clrcnt;

always @(posedge clk or negedge rst_n)
	if(!rst_n) clrcnt <= 4'd0;
	else if(pos_image_lcd_clr) clrcnt <= 4'd1;
	else if(clrcnt > 4'd0) clrcnt <= clrcnt+1'b1;
	else clrcnt <= 4'd0;
	
wire rfifo_clr = (clrcnt != 4'd0);	
						
		
////////////////////////////////////////////////////
//������FIFO
//����FIFO��������128*128bitʱ�ͷ����DDR3����	
wire[9:0] rfifo_wr_data_count1;
wire[9:0] rfifo_wr_data_count2;
		
fifo_generator_2 		fifo_for_ddr3_read_left (
  .rst(!rst_n || rfifo_clr),                      // input wire rst
  .wr_clk(clk),                // input wire wr_clk
  .rd_clk(image_lcd_clk),                // input wire rd_clk
  .din(app_rd_data),                  // input wire [127 : 0] din		//DDR3��������
  .wr_en(app_rd_data_valid & ~rdfifo_sel),          // input wire wr_en			//DDR3����������Ч�ź�
  .rd_en(image_lcd_rdreq_left),                  // input wire rd_en
  .dout(image_lcd_data_left),                    // output wire [15 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .wr_data_count(rfifo_wr_data_count1)  // output wire [9 : 0] wr_data_count
);	

fifo_generator_2 		fifo_for_ddr3_read_righ (
  .rst(!rst_n || rfifo_clr),                      // input wire rst
  .wr_clk(clk),                // input wire wr_clk
  .rd_clk(image_lcd_clk),                // input wire rd_clk
  .din(app_rd_data),                  // input wire [127 : 0] din		//DDR3��������
  .wr_en(app_rd_data_valid & rdfifo_sel),          // input wire wr_en			//DDR3����������Ч�ź�
  .rd_en(image_lcd_rdreq_righ),                  // input wire rd_en
  .dout(image_lcd_data_righ),                    // output wire [15 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .wr_data_count(rfifo_wr_data_count2)  // output wire [9 : 0] wr_data_count
);	
			
reg[16:0] user_ddr3_read_addr1;		//DDR3��ȡ��ַleft
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) user_ddr3_read_addr1 <= DDR3_ADDR_LEFT_STAR;
	else if(rfifo_clr) user_ddr3_read_addr1 <= DDR3_ADDR_LEFT_STAR;
	else if(cstate == SRDED1) user_ddr3_read_addr1 <= user_ddr3_read_addr1+1'b1;
	
reg[16:0] user_ddr3_read_addr2;		//DDR3��ȡ��ַrigh
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) user_ddr3_read_addr2 <= DDR3_ADDR_RIGH_STAR;
	else if(rfifo_clr) user_ddr3_read_addr2 <= DDR3_ADDR_RIGH_STAR;
	else if(cstate == SRDED2) user_ddr3_read_addr2 <= user_ddr3_read_addr2+1'b1;	
	
////////////////////////////////////////////////////
//������дDDR3������״̬
parameter SIDLE = 4'd0;
parameter SWRDB1 = 4'd1;
parameter SWRED1 = 4'd2;
parameter SWRDB2 = 4'd3;
parameter SWRED2 = 4'd4;
parameter SRDDB1 = 4'd5;
parameter SRDED1 = 4'd6;
parameter SRDWT1 = 4'd7;
parameter SRDDB2 = 4'd8;
parameter SRDED2 = 4'd9;
parameter SRDWT2 = 4'd10;
parameter SSTOP = 4'd11;
	
reg[3:0] nstate,cstate;
reg[9:0] num;
reg[9:0] wrnum;

always @(posedge clk or negedge rst_n)
	if(!rst_n) cstate <= SIDLE;
	else cstate <= nstate;

	//���ݶ�д�ٲÿ���״̬��
always @(*) begin
	case(cstate)
		SIDLE: begin
			if((rfifo_wr_data_count1 < BURST_RD_128BIT) && !image_lcd_clr_r) nstate = SRDDB1;	
			else if((rfifo_wr_data_count2 < BURST_RD_128BIT) && !image_lcd_clr_r) nstate = SRDDB2;
			else if((wfifo_rd_data_count1 >= BURST_WR_128BIT) && !image_ddr3_clr_r) nstate = SWRDB1;
			else if((wfifo_rd_data_count2 >= BURST_WR_128BIT) && !image_ddr3_clr_r) nstate = SWRDB2;
			else nstate = SIDLE;
		end
		SWRDB1: begin	//д����
			if((wrnum > (BURST_WR_128BIT+1)) && (num > BURST_WR_128BIT)) nstate = SWRED1;
			else nstate = SWRDB1;
		end
		SWRED1: nstate = SSTOP;	
		SWRDB2: begin	//д����
			if((wrnum > (BURST_WR_128BIT+1)) && (num > BURST_WR_128BIT)) nstate = SWRED2;
			else nstate = SWRDB2;
		end
		SWRED2: nstate = SSTOP;		
		
		SRDDB1: begin	//������
			if((num > BURST_RD_128BIT) && (rdnum >= BURST_RD_128BIT-8)) nstate = SRDWT1;
			else nstate = SRDDB1;
		end
		SRDWT1: begin
			if(dlynum >= DLY_CLK_AFTER_RD/*BURST_RD_128BIT*/) nstate = SRDED1;	
			else nstate = SRDWT1;
		end			
		SRDED1: nstate = SSTOP;	
			
		SRDDB2: begin	//������
			if((num > BURST_RD_128BIT) && (rdnum >= BURST_RD_128BIT-8)) nstate = SRDWT2;
			else nstate = SRDDB2;
		end
		SRDWT2: begin
			if(dlynum >= DLY_CLK_AFTER_RD/*BURST_RD_128BIT*/) nstate = SRDED2;	
			else nstate = SRDWT2;
		end		
		SRDED2: nstate = SSTOP;
		
		SSTOP: nstate = SIDLE;
		default: nstate = SIDLE;
	endcase
end

////////////////////////////////////////////////////
//��������FIFO�л�
reg rdfifo_sel;	//0--left FIFO write, 1--right FIFO write
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) rdfifo_sel <= 1'b0;
	else if(cstate == SRDDB1) rdfifo_sel <= 1'b0; 
	else if(cstate == SRDDB2) rdfifo_sel <= 1'b1;	
	
////////////////////////////////////////////////////	
//����д��������������

always @(posedge clk or negedge rst_n)
	if(!rst_n) num <= 10'd0;
	else if((cstate == SWRDB1) || (cstate == SWRDB2)) begin
		if(app_rdy) num <= num+1'b1;
		else ;
	end
	else if((cstate == SRDDB1) || (cstate == SRDDB2)) begin
		if(app_rdy) num <= num+1'b1;
		else ;
	end
	else num <= 10'd0;	
	
////////////////////////////////////////////////////	
//д���ݿ����źż�����

always @(posedge clk or negedge rst_n)
	if(!rst_n) wrnum <= 10'd0;
	else if((cstate == SWRDB1) || (cstate == SWRDB2)) begin
		if(app_wdf_rdy) wrnum <= wrnum+1'b1;
		else ;
	end
	else wrnum <= 10'd0;	
		
	//дDDR3����ʹ��
always @(posedge clk or negedge rst_n)
	if(!rst_n) app_wdf_wren <= 1'b0;
	else if(((cstate == SWRDB1) || (cstate == SWRDB2)) && (wrnum > 10'd0) && (wrnum <= BURST_WR_128BIT)) app_wdf_wren <= 1'b1;
	else app_wdf_wren <= 1'b0;		
	
assign app_wdf_end = app_wdf_wren;	
		
////////////////////////////////////////////////////
//��д���ݿ���ʱ�����
		
always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		app_cmd <= 3'd0;
		app_en <= 1'b0;
		app_addr <= 28'd0;		
	end
	else if(cstate == SWRDB1) begin	//дDDR3 left
		app_cmd <= 3'b000;		
		
		if(app_rdy) begin										
			if(num < BURST_WR_128BIT) app_en <= 1'b1;
			else app_en <= 1'b0;
		end
		else ;
	
		{app_addr[27:6],app_addr[2:0]} <= {user_ddr3_write_addr1,3'd0};	
		if(app_rdy) app_addr[5:3] <= num[2:0];				
		else ;		
	end
	else if(cstate == SWRDB2) begin	//дDDR3 righ
		app_cmd <= 3'b000;		
		
		if(app_rdy) begin										
			if(num < BURST_WR_128BIT) app_en <= 1'b1;
			else app_en <= 1'b0;
		end
		else ;
	
		{app_addr[27:6],app_addr[2:0]} <= {user_ddr3_write_addr2,3'd0};	
		if(app_rdy) app_addr[5:3] <= num[2:0];				
		else ;		
	end	
	else if(cstate == SRDDB1) begin	//��DDR3 left
		app_cmd <= 3'b001;

		if(app_rdy) begin		
			if(num < BURST_RD_128BIT) app_en <= 1'b1;	
			else app_en <= 1'b0;
		end
		else ;
		
		{app_addr[27:11],app_addr[2:0]} <= {user_ddr3_read_addr1,3'd0};	
		if(app_rdy) app_addr[10:3] <= num[7:0];
		else ;			
	end
	else if(cstate == SRDDB2) begin	//��DDR3 righ
		app_cmd <= 3'b001;

		if(app_rdy) begin		
			if(num < BURST_RD_128BIT) app_en <= 1'b1;	
			else app_en <= 1'b0;
		end
		else ;
		
		{app_addr[27:11],app_addr[2:0]} <= {user_ddr3_read_addr2,3'd0};	
		if(app_rdy) app_addr[10:3] <= num[7:0];
		else ;			
	end	
	else begin
		app_cmd <= 3'd0;
		app_en <= 1'b0;
		app_addr <= 28'd0;	
	end

////////////////////////////////////////////////////
//�����ݸ���������
reg[9:0] rdnum;	

always @(posedge clk or negedge rst_n)
	if(!rst_n) rdnum <= 10'd0;
	else if(cstate == SIDLE) rdnum <= 10'd0;
	else if(app_rd_data_valid) rdnum <= rdnum+1'b1;
	else ;
	
reg[9:0] dlynum;	

always @(posedge clk or negedge rst_n)
	if(!rst_n) dlynum <= 10'd0;
	else if((cstate == SRDWT1) || (cstate == SRDWT2)) dlynum <= dlynum+1'b1;
	else dlynum <= 10'd0;
	
////////////////////////////////////////////////////
//д���ݿ���ʱ�����
		
always @(*)
	if(!rst_n) wfifo_rd_en1 <= 1'b0; 	
	else if((cstate == SWRDB1) && app_wdf_rdy && (wrnum > 10'd0) && (wrnum <= BURST_WR_128BIT)) wfifo_rd_en1 <= 1'b1;
	else wfifo_rd_en1 <= 1'b0; 

always @(*)
	if(!rst_n) wfifo_rd_en2 <= 1'b0; 	
	else if((cstate == SWRDB2) && app_wdf_rdy && (wrnum > 10'd0) && (wrnum <= BURST_WR_128BIT)) wfifo_rd_en2 <= 1'b1;
	else wfifo_rd_en2 <= 1'b0; 	

assign app_wdf_data = (cstate == SWRDB1) ? wfifo_rd_data1:wfifo_rd_data2;


endmodule

