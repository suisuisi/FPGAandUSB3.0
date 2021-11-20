/////////////////////////////////////////////////////////////////////////////

module lcd_driver(	
				//系统时钟与复位信号
			input clk,
			input rst_n,
			(*mark_debug = "true"*)	input switch,
				//VGA驱动接口
			(*mark_debug = "true"*)	input vga_rst_n,
			(*mark_debug = "true"*)	output[7:0] vga_rgb,
			(*mark_debug = "true"*)	output vga_hsy,
			(*mark_debug = "true"*)	output reg vga_vsy,
				//LCD与FIFO的接口
			output lcd_synclk,	
			input[15:0] lcd_rfdb,	//FIFO读出数据总线
			output lcd_rfreq,		//FIFO读请求信号
			output reg lcd_rfclr		//FIFO复位信号，高电平有效
			);
			
//-----------------------------------------------------------
//`define VGA_640_480
`define VGA_1280_720

//实际输入的Image Sensor的图像分辨率
	parameter IMAGE_ACTUAL_RESOLUTION_X = 12'd640;
	parameter IMAGE_ACTUAL_RESOLUTION_Y = 12'd480;

//-----------------------------------------------------------
`ifdef VGA_640_480
	//VGA Timing 640*480 & 50MHz & 30Hz
		
	parameter VGA_HTT = 12'd1600-12'd1;	//Hor Total Time
	parameter VGA_HST = 12'd96;		//Hor Sync  Time
	parameter VGA_HBP = 12'd48;//+12'd16;		//Hor Back Porch
	parameter VGA_HVT = 12'd640;	//Hor Valid Time
	parameter VGA_HFP = 12'd16;		//Hor Front Porch

	parameter VGA_VTT = 12'd2100-12'd1;	//Ver Total Time
	parameter VGA_VST = 12'd2;		//Ver Sync Time
	parameter VGA_VBP = 12'd33;//-12'd4;		//Ver Back Porch
	parameter VGA_VVT = 12'd480;	//Ver Valid Time
	parameter VGA_VFP = 12'd10;		//Ver Front Porch
`endif

`ifdef VGA_1280_720
	//VGA Timing 1280*720 & 75MHz & 30Hz

	parameter VGA_HTT = 12'd3125-12'd1;	//Hor Total Time
	parameter VGA_HST = 12'd80;		//Hor Sync  Time
	parameter VGA_HBP = 12'd216;		//Hor Back Porch
	parameter VGA_HVT = 12'd1280;	//Hor Valid Time
	parameter VGA_HFP = 12'd72;		//Hor Front Porch

	parameter VGA_VTT = 12'd800-12'd1;	//Ver Total Time
	parameter VGA_VST = 12'd5;		//Ver Sync Time
	parameter VGA_VBP = 12'd22;		//Ver Back Porch
	parameter VGA_VVT = 12'd720;	//Ver Valid Time
	parameter VGA_VFP = 12'd3;		//Ver Front Porch
`endif

assign lcd_synclk = clk;

//-----------------------------------------------------------
	//x and y counter
reg[11:0] xcnt;
reg[11:0] ycnt;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) xcnt <= 12'd0;
	else if(!vga_rst_n) xcnt <= 12'd0;
	else if(xcnt >= VGA_HTT) xcnt <= 12'd0;
	else xcnt <= xcnt+1'b1;

always @(posedge clk or negedge rst_n)
	if(!rst_n) ycnt <= 12'd0;
	else if(!vga_rst_n) ycnt <= 12'd0;
	else if(xcnt == VGA_HTT) begin
		if(ycnt >= VGA_VTT) ycnt <= 12'd0;
		else ycnt <= ycnt+1'b1;
	end
	else ;
		
//-----------------------------------------------------------
	//vsy generate	
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) vga_vsy <= 1'b0;
	else if((ycnt >= (VGA_VST+VGA_VBP)) && (ycnt < (VGA_VST+VGA_VBP+VGA_VVT))) vga_vsy <= 1'b1;
	else vga_vsy <= 1'b0;	
	
//-----------------------------------------------------------	
	//vga valid signal generate
reg vga_valid;

always @(posedge clk or negedge rst_n)
	if(!rst_n) vga_valid <= 1'b0;
	else if((xcnt >= (VGA_HST+VGA_HBP)) && (xcnt < (VGA_HST+VGA_HBP+VGA_HVT+VGA_HVT))
				&& (ycnt >= (VGA_VST+VGA_VBP)) && (ycnt < (VGA_VST+VGA_VBP+VGA_VVT)))
		 vga_valid <= 1'b1;
	else vga_valid <= 1'b0;

assign vga_hsy = vga_valid;

//--------------------------------------------------
	//FIFO读请求信号和复位信号产生
reg lcd_rfreqr;
reg rfreq_div;

always @(posedge clk or negedge rst_n)
	if(!rst_n) lcd_rfreqr <= 1'b0;
	else if((xcnt >= (VGA_HST+VGA_HBP-12'd2)) && (xcnt < (VGA_HST+VGA_HBP+IMAGE_ACTUAL_RESOLUTION_X+IMAGE_ACTUAL_RESOLUTION_X)-12'd2)
				&& (ycnt >= (VGA_VST+VGA_VBP)) && (ycnt < (VGA_VST+VGA_VBP+IMAGE_ACTUAL_RESOLUTION_Y)))
		 lcd_rfreqr <= 1'b1;
	else lcd_rfreqr <= 1'b0;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) rfreq_div <= 1'b0; 
	else if(lcd_rfreqr) rfreq_div <= ~rfreq_div;
	else rfreq_div <= 1'b0;
	
assign lcd_rfreq = lcd_rfreqr & ~rfreq_div;
	

always @(posedge clk or negedge rst_n)
	if(!rst_n) lcd_rfclr <= 1'b1;
	else if(ycnt == 12'd0) lcd_rfclr <= 1'b1;
	else lcd_rfclr <= 1'b0;

//-----------------------------------------------------------
//灰度色阶产生
reg[7:0] lcd_gray_bar;
reg[7:0] gbcnt;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) gbcnt <= 8'd0;
	else if(vga_valid) begin
		if(gbcnt < 8'd159) gbcnt <= gbcnt+1'b1;
		else gbcnt <= 8'd0;
	end
	else gbcnt <= 8'd0;
	
always @ (posedge clk or negedge rst_n)
	if(!rst_n) lcd_gray_bar <= 8'h80;
	else if(!vga_valid) lcd_gray_bar <= 8'hc0;
	else if(gbcnt == 8'd159) lcd_gray_bar <= lcd_gray_bar+8'h10;
	else ;
	
//-----------------------------------------------------------
	//display corlor generate
reg[7:0] lcd_db_rgb;	// LCD色彩显示寄存器

always @ (posedge clk or negedge rst_n)
	if(!rst_n) lcd_db_rgb <= 8'd0;
	else if(switch) begin	//灰阶
		if(xcnt[0]) lcd_db_rgb <= 8'h80;	//UV
		else lcd_db_rgb <= lcd_gray_bar;	//Y
	end
	else begin	//摄像头
		if(xcnt < (VGA_HST+VGA_HBP+IMAGE_ACTUAL_RESOLUTION_X+IMAGE_ACTUAL_RESOLUTION_X) && (ycnt < (VGA_VST+VGA_VBP+IMAGE_ACTUAL_RESOLUTION_Y))) begin	//有效分辨率视场	
			//if(xcnt[0]) lcd_db_rgb <= 8'h80;	//UV
			//else lcd_db_rgb <= lcd_rfdb[7:0];	//Y
			if(xcnt[0]) lcd_db_rgb <= lcd_rfdb[7:0];	//UV
			else lcd_db_rgb <= lcd_rfdb[15:8];	//Y
		end
		else begin	//无效分辨率视场显示全白
			if(xcnt[0]) lcd_db_rgb <= 8'h80;	//UV
			else lcd_db_rgb <= 8'hff;	//Y		
		end
	end
	
//-----------------------------------------------------------
	//corlor data and clock generate
assign vga_rgb = vga_valid ? lcd_db_rgb:8'd0;

endmodule

