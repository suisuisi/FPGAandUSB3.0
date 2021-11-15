module usb_controller(
				input clk,		//100MHz
				input rst_n,	
					//FX3 Slave FIFO接口
				input fx3_flaga,
				input fx3_flagb,	
				input fx3_flagc,	//ctl[9]
				input fx3_flagd,	//ctl[8]
				//output fx3_pclk,		//Slave FIFO同步时钟信号
				output reg fx3_slcs_n,		//Slave FIFO片选信号，低电平有效
				output reg fx3_slwr_n,		//Slave FIFO写使能信号，低电平有效
				output reg fx3_slrd_n,		//Slave FIFO读使能信号，低电平有效
				output reg fx3_sloe_n,		//Slave FIFO输出使能信号，低电平有效
				output reg fx3_pktend_n,	//包结束信号
				output reg[1:0] fx3_a,			//操作FIFO地址
				inout[31:0] fx3_db		//数据
			);



/////////////////////////////////////////////////////////////
//FX3 FIFO同步时钟产生
//assign fx3_pclk = clk;

/////////////////////////////////////////////////////////////
//寄存器和参数定义

reg[9:0] num;		//数据寄存器
reg[3:0] delaycnt;	//计数器
reg[3:0] fxstate;	//状态寄存器
parameter	FXS_REST	= 4'd0;
parameter	FXS_IDLE	= 4'd1;
//parameter	FXS_READ	= 4'd2;
//parameter	FXS_RDLY	= 4'd3;
//parameter	FXS_RSOP	= 4'd4;
parameter	FXS_WRIT	= 4'd5;
parameter	FXS_WSOP	= 4'd6;

wire[9:0] fifo_used;	//FIFO已经使用数据个数
reg fifo_rdreq;			//FIFO读请求信号，高电平有效
/*
/////////////////////////////////////////////////////////////
reg fx3_dir;	//FX3读写方向指示信号，1--read, 0--write

always @(posedge clk or negedge rst_n)
	if(!rst_n) fx3_dir <= 1'b1;		//read
	else if(fxstate == FXS_RSOP) fx3_dir <= 1'b0;		//write
	else if(fxstate == FXS_WSOP) fx3_dir <= 1'b1;		//read
*/
/////////////////////////////////////////////////////////////
//定时读取FX3 FIFO数据并送入FIFO中

	//定时读写操作状态机
always @(posedge clk or negedge rst_n)
	if(!rst_n) fxstate <= FXS_REST;
	else begin
		case(fxstate)
			FXS_REST: begin
				fxstate <= FXS_IDLE;
			end
			FXS_IDLE: begin
			//	if(fx3_dir && fx3_flaga) fxstate <= FXS_READ;	//读数据，读取数据个数必须是8-1024
				if(/*!fx3_dir &&*/ fx3_flaga) fxstate <= FXS_WRIT;	//写数据
				else fxstate <= FXS_IDLE;
			end	
		/*	FXS_READ: begin
				if(!fx3_flagb) fxstate <= FXS_RDLY;
				else fxstate <= FXS_READ;
			end	 
			FXS_RDLY: begin	//读取flagd拉低后的6个数据 
				if(delaycnt >= 4'd6) fxstate <= FXS_RSOP;
				else fxstate <= FXS_RDLY;				
			end
			FXS_RSOP: fxstate <= FXS_IDLE;*/
			FXS_WRIT: begin	
				if(num >= 10'd256) fxstate <= FXS_WSOP;
				else fxstate <= FXS_WRIT;
			end	
			FXS_WSOP: begin
				if(delaycnt >= 4'd4) fxstate <= FXS_IDLE;
				else fxstate <= FXS_WSOP;
			end
			default: fxstate <= FXS_IDLE;
		endcase
	end

	//数据计数器，用于产生读写时序
always @(posedge clk or negedge rst_n)
	if(!rst_n) num <= 10'd0;
	//else if(fxstate == FXS_READ) num <= num+1'b1;	//Slave FIFO读操作
	else if(fxstate == FXS_WRIT) num <= num+1'b1;	//Slave FIFO写操作
	else num <= 10'd0;
	
	//6个clock的延时计数器
always @(posedge clk or negedge rst_n)
	if(!rst_n) delaycnt <= 4'd0;
	//else if(fxstate == FXS_RDLY) delaycnt <= delaycnt+1'b1;
	else if(fxstate == FXS_WSOP) delaycnt <= delaycnt+1'b1;
	else delaycnt <= 4'd0;
	
/////////////////////////////////////////////////////////////
//FX3 Slave FIFO控制信号时序产生
parameter FX3_ON	= 1'b0;
parameter FX3_OFF	= 1'b1;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
		fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
		fx3_pktend_n <= FX3_OFF;	//包结束信号
		fx3_a <= 2'b00;			//操作FIFO地址
	end
	else if(fxstate == FXS_IDLE) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
		fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
		fx3_pktend_n <= FX3_OFF;	//包结束信号
		fx3_a <= 2'b00;	//写数据
		//if(fx3_dir) fx3_a <= 2'b11;	//读数据
		//else fx3_a <= 2'b00;	//写数据	
	end
/*	else if(fxstate == FXS_READ) begin	//cs = 0; addr = 2'b11;rd = 0; oe=0
		fx3_slcs_n <= FX3_ON;		//Slave FIFO片选信号，低电平有效
		fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
		fx3_slrd_n <= FX3_ON;		//Slave FIFO读使能信号，低电平有效
		fx3_sloe_n <= FX3_ON;		//Slave FIFO输出使能信号，低电平有效
		fx3_pktend_n <= FX3_OFF;	//包结束信号
		fx3_a <= 2'b11;			//FIFO读地址			
	end
	else if(fxstate == FXS_RDLY) begin
		if(delaycnt == 4'd2) begin	//rd = 1;
			fx3_slcs_n <= FX3_ON;		//Slave FIFO片选信号，低电平有效
			fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
			fx3_sloe_n <= FX3_ON;		//Slave FIFO输出使能信号，低电平有效
			fx3_pktend_n <= FX3_OFF;	//包结束信号
			fx3_a <= 2'b11;			//FIFO读地址			
		end
		else if(delaycnt == 4'd6) begin
			fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
			fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
			fx3_pktend_n <= FX3_OFF;	//包结束信号
			fx3_a <= 2'b11;			//操作FIFO地址
		end 
	end	*/
	else if(fxstate == FXS_WRIT) begin
		if(num == 10'd0) begin	//cs = 0; addr = 2'b00;wr = 0;
			fx3_slcs_n <= FX3_ON;		//Slave FIFO片选信号，低电平有效
			fx3_slwr_n <= FX3_ON;		//Slave FIFO写使能信号，低电平有效
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
			fx3_pktend_n <= FX3_OFF;	//包结束信号
			fx3_a <= 2'b00;			//FIFO读地址			
		end
		else if(num == 10'd255) begin	//fx3_pktend_n =0
			fx3_slcs_n <= FX3_ON;		//Slave FIFO片选信号，低电平有效
			fx3_slwr_n <= FX3_ON;		//Slave FIFO写使能信号，低电平有效
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
			fx3_pktend_n <= FX3_ON;		//包结束信号
			fx3_a <= 2'b00;			//FIFO读地址		
		end		
		else if(num == 10'd256) begin	//cs = 0; addr = 2'b00;
			fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
			fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
			fx3_pktend_n <= FX3_OFF;		//包结束信号
			fx3_a <= 2'b00;			//FIFO读地址		
		end	
	end
	else if(fxstate == FXS_WSOP) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
		fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
		fx3_pktend_n <= FX3_OFF;	//包结束信号
		fx3_a <= 2'b00;			//操作FIFO地址	
	end
	else begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFO片选信号，低电平有效
		fx3_slwr_n <= FX3_OFF;		//Slave FIFO写使能信号，低电平有效
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO读使能信号，低电平有效
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO输出使能信号，低电平有效
		fx3_pktend_n <= FX3_OFF;	//包结束信号
	end 

reg[31:0] fx3_wdb;	//FX3写数据寄存器

always @(posedge clk or negedge rst_n)
	if(!rst_n) fx3_wdb <= 32'd0;
	else if((fxstate == FXS_WRIT) && (num < 10'd256)) fx3_wdb <= fx3_wdb+1'b1;


assign fx3_db = fx3_wdb;	//FX3数据总线方向控制	
	
/////////////////////////////////////////////////////////////
//在线逻辑分析仪，调试查看

ila_0 	uut_ila (
	.clk(clk), // input wire clk
	.probe0({fx3_flaga,fx3_flagb,fx3_slcs_n,fx3_slwr_n,fx3_slrd_n,fx3_sloe_n,fx3_pktend_n}), // input wire [6:0]  probe0  
	.probe1(fx3_a), // input wire [1:0]  probe1 
	.probe2(fx3_db) // input wire [31:0]  probe2
);	

endmodule

