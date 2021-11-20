`timescale 1ns / 1ps
/////////////////////////////////////////////////////////////////////////////


`timescale 1ns/1ps
module bayer2rgb(
		input clk,
		input rst_n,
		//input Image Data Flow
		input i_bayer_image_vld,
		output o_bayer_image_tready,
		input[7:0] i_bayer_image_data,	
		input i_bayer_image_sof,
		input i_bayer_image_eof,
		input i_bayer_image_eol,
		//output Image Data Flow
		output reg o_rgb_image_rst,
		output o_rgb_image_vld,
		output[23:0] o_rgb_image_data
    );
	
reg[15:0] cnt;
reg[5:0] i_axi_ctrl_awaddr;
reg i_axi_ctrl_awvalid;
wire o_axi_ctrl_awready;
reg[31:0] i_axi_ctrl_awdata;
reg i_axi_ctrl_wvalid;
wire o_axi_ctrl_wready;

parameter IMAGE_WIDTH = 32'd640;////32'd2944;//32'd2880;//
parameter IMAGE_HIGHT = 32'd480;////32'd2000;//32'd1620;//

////////////////////////////////////////////////////
//demoasic IP例化

v_demosaic_0		uut_v_demosaic_1 (
  .s_axi_CTRL_AWADDR	(i_axi_ctrl_awaddr),      // input wire [5 : 0] s_axi_CTRL_AWADDR
  .s_axi_CTRL_AWVALID	(i_axi_ctrl_awvalid),    // input wire s_axi_CTRL_AWVALID
  .s_axi_CTRL_AWREADY	(o_axi_ctrl_awready),    // output wire s_axi_CTRL_AWREADY
  .s_axi_CTRL_WDATA		(i_axi_ctrl_awdata),        // input wire [31 : 0] s_axi_CTRL_WDATA
  .s_axi_CTRL_WSTRB		(4'hf/*s_axi_CTRL_WSTRB*/),        // input wire [3 : 0] s_axi_CTRL_WSTRB
  .s_axi_CTRL_WVALID	(i_axi_ctrl_wvalid),      // input wire s_axi_CTRL_WVALID
  .s_axi_CTRL_WREADY	(o_axi_ctrl_wready),      // output wire s_axi_CTRL_WREADY
  .s_axi_CTRL_BRESP		(/*s_axi_CTRL_BRESP*/),        // output wire [1 : 0] s_axi_CTRL_BRESP
  .s_axi_CTRL_BVALID	(/*s_axi_CTRL_BVALID*/),      // output wire s_axi_CTRL_BVALID
  .s_axi_CTRL_BREADY	(1'b1/*s_axi_CTRL_BREADY*/),      // input wire s_axi_CTRL_BREADY
  .s_axi_CTRL_ARADDR	(6'd0),      // input wire [5 : 0] s_axi_CTRL_ARADDR
  .s_axi_CTRL_ARVALID	(1'b0),    // input wire s_axi_CTRL_ARVALID
  .s_axi_CTRL_ARREADY	(),    // output wire s_axi_CTRL_ARREADY
  .s_axi_CTRL_RDATA		(),        // output wire [31 : 0] s_axi_CTRL_RDATA
  .s_axi_CTRL_RRESP		(/*s_axi_CTRL_RRESP*/),        // output wire [1 : 0] s_axi_CTRL_RRESP
  .s_axi_CTRL_RVALID	(),      // output wire s_axi_CTRL_RVALID
  .s_axi_CTRL_RREADY	(1'b1/*s_axi_CTRL_RREADY*/),      // input wire s_axi_CTRL_RREADY
  .ap_clk				(clk),                            // input wire ap_clk
  .ap_rst_n				(rst_n),                        // input wire ap_rst_n
  .interrupt			(/*interrupt*/),                      // output wire interrupt
  .s_axis_video_TVALID	(i_bayer_image_vld),  // input wire s_axis_video_TVALID
  .s_axis_video_TREADY	(o_bayer_image_tready),  // output wire s_axis_video_TREADY
  .s_axis_video_TDATA	(i_bayer_image_data),    // input wire [7 : 0] s_axis_video_TDATA
  .s_axis_video_TKEEP	(1'b1/*s_axis_video_TKEEP*/),    // input wire [0 : 0] s_axis_video_TKEEP
  .s_axis_video_TSTRB	(1'b1/*s_axis_video_TSTRB*/),    // input wire [0 : 0] s_axis_video_TSTRB
  .s_axis_video_TUSER	(i_bayer_image_sof),    // input wire [0 : 0] s_axis_video_TUSER
  .s_axis_video_TLAST	(i_bayer_image_eol),    // input wire [0 : 0] s_axis_video_TLAST
  .s_axis_video_TID		(1'b1/*s_axis_video_TID*/),        // input wire [0 : 0] s_axis_video_TID
  .s_axis_video_TDEST	(1'b1/*s_axis_video_TDEST*/),    // input wire [0 : 0] s_axis_video_TDEST
  .m_axis_video_TVALID	(o_rgb_image_vld),  // output wire m_axis_video_TVALID
  .m_axis_video_TREADY	(1'b1/*m_axis_video_TREADY*/),  // input wire m_axis_video_TREADY
  .m_axis_video_TDATA	(o_rgb_image_data),    // output wire [23 : 0] m_axis_video_TDATA
  .m_axis_video_TKEEP	(/*m_axis_video_TKEEP*/),    // output wire [2 : 0] m_axis_video_TKEEP
  .m_axis_video_TSTRB	(/*m_axis_video_TSTRB*/),    // output wire [2 : 0] m_axis_video_TSTRB
  .m_axis_video_TUSER	(/*m_axis_video_TUSER*/),    // output wire [0 : 0] m_axis_video_TUSER
  .m_axis_video_TLAST	(/*m_axis_video_TLAST*/),    // output wire [0 : 0] m_axis_video_TLAST
  .m_axis_video_TID		(/*m_axis_video_TID*/),        // output wire [0 : 0] m_axis_video_TID
  .m_axis_video_TDEST	(/*m_axis_video_TDEST*/)    // output wire [0 : 0] m_axis_video_TDEST
);

////////////////////////////////////////////////////	
//demoasic IP初始化

always @(posedge clk)
	if(!rst_n) cnt <= 16'd0;
	else if(cnt < 16'hffff) cnt <= cnt+1'b1;
	
wire timer_1 = (cnt == 16'h8000);
wire timer_2 = (cnt == 16'h8004);

wire timer_3 = (cnt == 16'h9000);
wire timer_4 = (cnt == 16'h9004);

wire timer_5 = (cnt == 16'ha000);
wire timer_6 = (cnt == 16'ha004);

wire timer_7 = (cnt == 16'hb000);
wire timer_8 = (cnt == 16'hb004);

	
always @(posedge clk)	
	if(!rst_n) begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;	
	end
	//register 0x0010 (active width) = IMAGE_WIDTH
	else if(timer_1) begin
		i_axi_ctrl_awaddr <= 6'h10;
		i_axi_ctrl_awvalid <= 1'b1;	
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;		
	end
	else if(timer_2) begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;	
		i_axi_ctrl_awdata <= IMAGE_WIDTH;
		i_axi_ctrl_wvalid <= 1'b1;	
	end
	//register 0x0018 (active height) = IMAGE_HIGHT
	else if(timer_3) begin
		i_axi_ctrl_awaddr <= 6'h18;
		i_axi_ctrl_awvalid <= 1'b1;	
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;		
	end	
	else if(timer_4) begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;		
		i_axi_ctrl_awdata <= IMAGE_HIGHT;
		i_axi_ctrl_wvalid <= 1'b1;	
	end		
	//register 0x0028 (bayer phase) = 0- RG/GB, 1 - GR/BG, 2 - GB/RG, 3- BG/GR
	else if(timer_5) begin
		i_axi_ctrl_awaddr <= 6'h28;
		i_axi_ctrl_awvalid <= 1'b1;
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;		
	end	
	else if(timer_6) begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;		
		i_axi_ctrl_awdata <= 32'd1;	//GR/BG
		//i_axi_ctrl_awdata <= 32'd2;	//GB/RG			
		//i_axi_ctrl_awdata <= 32'd3;	// BG/GR
		i_axi_ctrl_wvalid <= 1'b1;	
	end	
	//register 0 (ctrl): bit7=1 (auto_restart)		
	else if(timer_7) begin	
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b1;
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;		
	end	
	else if(timer_8) begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;		
		i_axi_ctrl_awdata <= 32'h0000_0081;
		i_axi_ctrl_wvalid <= 1'b1;		
	end			
	else begin
		i_axi_ctrl_awaddr <= 6'd0;
		i_axi_ctrl_awvalid <= 1'b0;
		i_axi_ctrl_awdata <= 32'd0;
		i_axi_ctrl_wvalid <= 1'b0;		
	end

////////////////////////////////////////////////////
//延时计数器，产生复位信号
reg[11:0] dly;

always @(posedge clk)
	if(!rst_n) dly <= 12'd0;
	else if(i_bayer_image_eof) dly <= 12'd1;
	else if(dly != 12'd0) dly <= dly+1'b1;
	else dly <= 12'd0;
	
always @(posedge clk)
	if(!rst_n) o_rgb_image_rst <= 1'b0;
	else if((dly >= 12'd3200) && (dly <= 12'd3300)) o_rgb_image_rst <= 1'b1;
	else o_rgb_image_rst <= 1'b0;
	
	
endmodule

