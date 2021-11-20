// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Nov 17 22:44:07 2021
// Host        : DESKTOP-1TCF4DO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, PHASE 0.000, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [9:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [7:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [17:0]P;

  wire [9:0]A;
  wire [7:0]B;
  wire CLK;
  wire [17:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "10" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "17" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule

(* C_A_TYPE = "1" *) (* C_A_WIDTH = "10" *) (* C_B_TYPE = "1" *) 
(* C_B_VALUE = "10000001" *) (* C_B_WIDTH = "8" *) (* C_CCM_IMP = "0" *) 
(* C_CE_OVERRIDES_SCLR = "0" *) (* C_HAS_CE = "0" *) (* C_HAS_SCLR = "0" *) 
(* C_HAS_ZERO_DETECT = "0" *) (* C_LATENCY = "3" *) (* C_MODEL_TYPE = "0" *) 
(* C_MULT_TYPE = "1" *) (* C_OPTIMIZE_GOAL = "1" *) (* C_OUT_HIGH = "17" *) 
(* C_OUT_LOW = "0" *) (* C_ROUND_OUTPUT = "0" *) (* C_ROUND_PT = "0" *) 
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintex7" *) (* downgradeipidentifiedwarnings = "yes" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14
   (CLK,
    A,
    B,
    CE,
    SCLR,
    ZERO_DETECT,
    P,
    PCASC);
  input CLK;
  input [9:0]A;
  input [7:0]B;
  input CE;
  input SCLR;
  output [1:0]ZERO_DETECT;
  output [17:0]P;
  output [47:0]PCASC;

  wire \<const0> ;
  wire [9:0]A;
  wire [7:0]B;
  wire CLK;
  wire [17:0]P;
  wire [47:0]NLW_i_mult_PCASC_UNCONNECTED;
  wire [1:0]NLW_i_mult_ZERO_DETECT_UNCONNECTED;

  assign PCASC[47] = \<const0> ;
  assign PCASC[46] = \<const0> ;
  assign PCASC[45] = \<const0> ;
  assign PCASC[44] = \<const0> ;
  assign PCASC[43] = \<const0> ;
  assign PCASC[42] = \<const0> ;
  assign PCASC[41] = \<const0> ;
  assign PCASC[40] = \<const0> ;
  assign PCASC[39] = \<const0> ;
  assign PCASC[38] = \<const0> ;
  assign PCASC[37] = \<const0> ;
  assign PCASC[36] = \<const0> ;
  assign PCASC[35] = \<const0> ;
  assign PCASC[34] = \<const0> ;
  assign PCASC[33] = \<const0> ;
  assign PCASC[32] = \<const0> ;
  assign PCASC[31] = \<const0> ;
  assign PCASC[30] = \<const0> ;
  assign PCASC[29] = \<const0> ;
  assign PCASC[28] = \<const0> ;
  assign PCASC[27] = \<const0> ;
  assign PCASC[26] = \<const0> ;
  assign PCASC[25] = \<const0> ;
  assign PCASC[24] = \<const0> ;
  assign PCASC[23] = \<const0> ;
  assign PCASC[22] = \<const0> ;
  assign PCASC[21] = \<const0> ;
  assign PCASC[20] = \<const0> ;
  assign PCASC[19] = \<const0> ;
  assign PCASC[18] = \<const0> ;
  assign PCASC[17] = \<const0> ;
  assign PCASC[16] = \<const0> ;
  assign PCASC[15] = \<const0> ;
  assign PCASC[14] = \<const0> ;
  assign PCASC[13] = \<const0> ;
  assign PCASC[12] = \<const0> ;
  assign PCASC[11] = \<const0> ;
  assign PCASC[10] = \<const0> ;
  assign PCASC[9] = \<const0> ;
  assign PCASC[8] = \<const0> ;
  assign PCASC[7] = \<const0> ;
  assign PCASC[6] = \<const0> ;
  assign PCASC[5] = \<const0> ;
  assign PCASC[4] = \<const0> ;
  assign PCASC[3] = \<const0> ;
  assign PCASC[2] = \<const0> ;
  assign PCASC[1] = \<const0> ;
  assign PCASC[0] = \<const0> ;
  assign ZERO_DETECT[1] = \<const0> ;
  assign ZERO_DETECT[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  (* C_A_TYPE = "1" *) 
  (* C_A_WIDTH = "10" *) 
  (* C_B_TYPE = "1" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "8" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "3" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "1" *) 
  (* C_OPTIMIZE_GOAL = "1" *) 
  (* C_OUT_HIGH = "17" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "kintex7" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_14_viv i_mult
       (.A(A),
        .B(B),
        .CE(1'b0),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_i_mult_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_i_mult_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2015"
`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="cds_rsa_key", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=64)
`pragma protect key_block
g7azmhtm6FcP7uNFjuXJjN8Z6yccOPk3SSjzvKB27peFKmnPmQmov5+YTGwYqqN9LpdyiUExk8K6
vPnJqontvQ==

`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
MFrqn2K0Cr7TmQ5al162oDGiY83d+AkTWOgFyXPYrTNznygR/tx44RAp24ytphNK9p6shs2EFMg/
Qqz0l8DCWiVEoJ/T8vMpnAn7Y+poGVGS1qAR3qE2njrl81VcGBZJeFaWIudhfr/DLTuuf2T/dWDU
YpelM3KbfYNPPiPy8PU=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
FZca5XZouG+/BYoQ8qrJTmnJanku4IprIWRkO6VciHehE5WehR0wsZJhfKlqLEeY1oTPA4bXaxmY
NjYkrop4EOwW8t47/hj2kFLI1OKUAE/TAhCGg/aNSOViUbB3dUomG/y+TBuDt9L6g0Arj1vb/5Pt
IChc5ZdEfRr1lJMTpFfP+5qmEH6lePPdzgPZATPB4Zrj0P6EyiEsU1FKBuAKd9iYNGiLCxVomaz0
3/RwK2Nl+/l4mc7PJt5Hso+4s1qHb4s2wD+OgbIwdH26ZkEnKVFpaLiuWQKu9uhDLGnsBMPf7XDE
p29f+mrvP9Zi/3nonA2aBKrTwR7XuH+ZYoakxA==

`pragma protect key_keyowner="ATRENTA", key_keyname="ATR-SG-2015-RSA-3", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
jP68OjlYJglq3zpmKrXOhq7Sex8XNW8fQKp4hUNmuw06OOoKhQASNTnjtyVjAIk/VXb64ViBu1ds
cNMJybDSWBhnChfJq4h9PNybShGJXxSm3NDOo5wUHKf10Eti3fSotB9rVks+tNdTEZo4O97kgfdD
G1FNOqlsYcQiShEGLLiEQ2yYtgJBxJ+jc8mFjIEfPhAYy1ElrvtFEpnhkNS2LfE7xdWOQdO/XoKK
ibeY08pgncTI3pvO6TMbXushf0AX2S7hgfk8ysZrT+0gktqFrJnyR6oljS6VVPLtRNW2vo/cC8XQ
Bzvwwt4cpSo5KLS4XxB6qClZipItck2AUEdIbQ==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2017_05", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
o7jAZIoXlFbFtDYmtXhfRBlb07dhBb6Wp03mlT4T0FXtvccSHWhWZgc+VUNwt6TohLihOwvSipPP
XVXpGL4pUVYNdQBCVpFzhMkt6jhyUgsF5t10yI5Of6YEfQrDHigceoBukM3+/zJHPprrPQE6FUvC
wXSGhBCXnHJs1R+n4l0714w8/WftPQhlD9QGQp1qT2VARQXUKBRxcRjxe9TcLfs0P4xnN7uHu0R6
JTmV+MHmhGpetSZGx+B2Wa1MQofUPURqwE70IwBoUhdXH8+39DT5I6x2+wMY6RcVATnhNd2BCgPd
RzAhwfrcqRiU9aB+eNNdFR8ve9M2nGMmV2JxZg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Cl1Dz+fZIDYEIQuUd0pSg+5jknmtX/JERd+yOZ2SRaVra/4pU/eCTjEXMzhz4VFGYB6dgUxMsGBk
nL2WNdn/uaSPpi6mNF0UHQvZik4pUkYPrnRbFveVqW8i1t95SG0RW96uD19206lWrp5U1lqc4fH7
sfKHi8ZpU3MAg0DOO0E=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Qqp76m2aV9ue8Qai7QUavb+lhRYdu/txrnwYLzwTe0vS0S2OD1vxr8VeIT3bF/ZuXlTGm4S/UCSF
bgOPp7VqEOeGNfsSPK+VpQ+foQMENCQYccwKquBDSg/sLjpPK9uuoGLBLxjw2OwsRzplVFXiPcRN
LYK1/FmCP7RJBNgmhh/ti99a+WSl6i2YIIRGocNplQlG8FXq8ZTTHd/x2Gtdf/zGvJOy/fNsos6S
Oq9yJ0rMmbGeWbri5c04gZM08pUmXBsivgOHm2IVEZZFM4SBqrsi0xa52hs2kelc3iKJcWiTvU3X
0fJP9qNFuIjXBPPZvEYwhVtIh6DwiIC2viSscQ==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
ZSjwi5XTakfXAf8sfT7rIYZW13TRZnx77yrtb6uDO8zhn5cbi80yKD05YZWNqUyJTbro5ALdyH3d
5C9tyLvu9vmbxzUt4do6e0/Z2D/FUgphy67Ek0fLN2CoIrSj7MWUdaKNumggNVvoaBy1ihm9IyA8
kwgxyj6IO3qdYYnA8hXBBisYIAbLExTl+B7GkwIV/20mqly/GWDOFfGRyKSjK3fhz7P381YYmTvq
IsVliYILVwhk5o+tTkUhcmOuSW/sxyxUtjQN9hvhimpCNjaIVEPAJT17J78rlHktON6nPAJglYAM
FkjDRVz+ZyBEswC0Tu4L3SPAmu3c52RSkwQHxA==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
B57y68/zz3xTnMLzk9lZMuvCsXfuku3sg4yY0zc98gmWiZ5TKjJaSsNlgvQ5MtiRLzKIJcEmRv/h
4SQM2ocz35nO/5abcGztWIfRtxHbICA9yUj0A+3FTBhr3n5DPumvWR5jvUGlkmhA8EZAiYdVN8RI
cIpWmGhLhRChuDAdibH7WRjTAjsmTXjFzVw8kxeB7ltSJX41cFUubmGZVdnZT8ulDZwubVmKLDrg
sMJ9RxGRlxGdI0rlTqcibYMjsJ1v3dBpdPvnodl3oD5TehAP1Y3AbfYVHHTyZCTOWgSRD2S+hEzN
rqV1gUdiZJCUBNCZH8nNbNodEo5WaGRki7Q6bQ==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7264)
`pragma protect data_block
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
QwxJZk/Dxpy+SUuUNQWf7DG8NFZia8abKA==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
