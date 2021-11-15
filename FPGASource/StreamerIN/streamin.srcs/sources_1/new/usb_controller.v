module usb_controller(
				input clk,		//100MHz
				input rst_n,	
					//FX3 Slave FIFO�ӿ�
				input fx3_flaga,
				input fx3_flagb,	
				input fx3_flagc,	//ctl[9]
				input fx3_flagd,	//ctl[8]
				//output fx3_pclk,		//Slave FIFOͬ��ʱ���ź�
				output reg fx3_slcs_n,		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
				output reg fx3_slwr_n,		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
				output reg fx3_slrd_n,		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
				output reg fx3_sloe_n,		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
				output reg fx3_pktend_n,	//�������ź�
				output reg[1:0] fx3_a,			//����FIFO��ַ
				inout[31:0] fx3_db		//����
			);



/////////////////////////////////////////////////////////////
//FX3 FIFOͬ��ʱ�Ӳ���
//assign fx3_pclk = clk;

/////////////////////////////////////////////////////////////
//�Ĵ����Ͳ�������

reg[9:0] num;		//���ݼĴ���
reg[3:0] delaycnt;	//������
reg[3:0] fxstate;	//״̬�Ĵ���
parameter	FXS_REST	= 4'd0;
parameter	FXS_IDLE	= 4'd1;
//parameter	FXS_READ	= 4'd2;
//parameter	FXS_RDLY	= 4'd3;
//parameter	FXS_RSOP	= 4'd4;
parameter	FXS_WRIT	= 4'd5;
parameter	FXS_WSOP	= 4'd6;

wire[9:0] fifo_used;	//FIFO�Ѿ�ʹ�����ݸ���
reg fifo_rdreq;			//FIFO�������źţ��ߵ�ƽ��Ч
/*
/////////////////////////////////////////////////////////////
reg fx3_dir;	//FX3��д����ָʾ�źţ�1--read, 0--write

always @(posedge clk or negedge rst_n)
	if(!rst_n) fx3_dir <= 1'b1;		//read
	else if(fxstate == FXS_RSOP) fx3_dir <= 1'b0;		//write
	else if(fxstate == FXS_WSOP) fx3_dir <= 1'b1;		//read
*/
/////////////////////////////////////////////////////////////
//��ʱ��ȡFX3 FIFO���ݲ�����FIFO��

	//��ʱ��д����״̬��
always @(posedge clk or negedge rst_n)
	if(!rst_n) fxstate <= FXS_REST;
	else begin
		case(fxstate)
			FXS_REST: begin
				fxstate <= FXS_IDLE;
			end
			FXS_IDLE: begin
			//	if(fx3_dir && fx3_flaga) fxstate <= FXS_READ;	//�����ݣ���ȡ���ݸ���������8-1024
				if(/*!fx3_dir &&*/ fx3_flaga) fxstate <= FXS_WRIT;	//д����
				else fxstate <= FXS_IDLE;
			end	
		/*	FXS_READ: begin
				if(!fx3_flagb) fxstate <= FXS_RDLY;
				else fxstate <= FXS_READ;
			end	 
			FXS_RDLY: begin	//��ȡflagd���ͺ��6������ 
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

	//���ݼ����������ڲ�����дʱ��
always @(posedge clk or negedge rst_n)
	if(!rst_n) num <= 10'd0;
	//else if(fxstate == FXS_READ) num <= num+1'b1;	//Slave FIFO������
	else if(fxstate == FXS_WRIT) num <= num+1'b1;	//Slave FIFOд����
	else num <= 10'd0;
	
	//6��clock����ʱ������
always @(posedge clk or negedge rst_n)
	if(!rst_n) delaycnt <= 4'd0;
	//else if(fxstate == FXS_RDLY) delaycnt <= delaycnt+1'b1;
	else if(fxstate == FXS_WSOP) delaycnt <= delaycnt+1'b1;
	else delaycnt <= 4'd0;
	
/////////////////////////////////////////////////////////////
//FX3 Slave FIFO�����ź�ʱ�����
parameter FX3_ON	= 1'b0;
parameter FX3_OFF	= 1'b1;
	
always @(posedge clk or negedge rst_n)
	if(!rst_n) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
		fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
		fx3_pktend_n <= FX3_OFF;	//�������ź�
		fx3_a <= 2'b00;			//����FIFO��ַ
	end
	else if(fxstate == FXS_IDLE) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
		fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
		fx3_pktend_n <= FX3_OFF;	//�������ź�
		fx3_a <= 2'b00;	//д����
		//if(fx3_dir) fx3_a <= 2'b11;	//������
		//else fx3_a <= 2'b00;	//д����	
	end
/*	else if(fxstate == FXS_READ) begin	//cs = 0; addr = 2'b11;rd = 0; oe=0
		fx3_slcs_n <= FX3_ON;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
		fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
		fx3_slrd_n <= FX3_ON;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
		fx3_sloe_n <= FX3_ON;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
		fx3_pktend_n <= FX3_OFF;	//�������ź�
		fx3_a <= 2'b11;			//FIFO����ַ			
	end
	else if(fxstate == FXS_RDLY) begin
		if(delaycnt == 4'd2) begin	//rd = 1;
			fx3_slcs_n <= FX3_ON;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			fx3_sloe_n <= FX3_ON;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			fx3_pktend_n <= FX3_OFF;	//�������ź�
			fx3_a <= 2'b11;			//FIFO����ַ			
		end
		else if(delaycnt == 4'd6) begin
			fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			fx3_pktend_n <= FX3_OFF;	//�������ź�
			fx3_a <= 2'b11;			//����FIFO��ַ
		end 
	end	*/
	else if(fxstate == FXS_WRIT) begin
		if(num == 10'd0) begin	//cs = 0; addr = 2'b00;wr = 0;
			fx3_slcs_n <= FX3_ON;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			fx3_slwr_n <= FX3_ON;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			fx3_pktend_n <= FX3_OFF;	//�������ź�
			fx3_a <= 2'b00;			//FIFO����ַ			
		end
		else if(num == 10'd255) begin	//fx3_pktend_n =0
			fx3_slcs_n <= FX3_ON;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			fx3_slwr_n <= FX3_ON;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			fx3_pktend_n <= FX3_ON;		//�������ź�
			fx3_a <= 2'b00;			//FIFO����ַ		
		end		
		else if(num == 10'd256) begin	//cs = 0; addr = 2'b00;
			fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
			fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
			fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
			fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
			fx3_pktend_n <= FX3_OFF;		//�������ź�
			fx3_a <= 2'b00;			//FIFO����ַ		
		end	
	end
	else if(fxstate == FXS_WSOP) begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
		fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
		fx3_pktend_n <= FX3_OFF;	//�������ź�
		fx3_a <= 2'b00;			//����FIFO��ַ	
	end
	else begin
		fx3_slcs_n <= FX3_OFF;		//Slave FIFOƬѡ�źţ��͵�ƽ��Ч
		fx3_slwr_n <= FX3_OFF;		//Slave FIFOдʹ���źţ��͵�ƽ��Ч
		fx3_slrd_n <= FX3_OFF;		//Slave FIFO��ʹ���źţ��͵�ƽ��Ч
		fx3_sloe_n <= FX3_OFF;		//Slave FIFO���ʹ���źţ��͵�ƽ��Ч
		fx3_pktend_n <= FX3_OFF;	//�������ź�
	end 

reg[31:0] fx3_wdb;	//FX3д���ݼĴ���

always @(posedge clk or negedge rst_n)
	if(!rst_n) fx3_wdb <= 32'd0;
	else if((fxstate == FXS_WRIT) && (num < 10'd256)) fx3_wdb <= fx3_wdb+1'b1;


assign fx3_db = fx3_wdb;	//FX3�������߷������	
	
/////////////////////////////////////////////////////////////
//�����߼������ǣ����Բ鿴

ila_0 	uut_ila (
	.clk(clk), // input wire clk
	.probe0({fx3_flaga,fx3_flagb,fx3_slcs_n,fx3_slwr_n,fx3_slrd_n,fx3_sloe_n,fx3_pktend_n}), // input wire [6:0]  probe0  
	.probe1(fx3_a), // input wire [1:0]  probe1 
	.probe2(fx3_db) // input wire [31:0]  probe2
);	

endmodule

