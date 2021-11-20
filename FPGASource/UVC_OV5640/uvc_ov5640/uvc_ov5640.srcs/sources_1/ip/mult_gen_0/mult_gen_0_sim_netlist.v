// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Nov 17 22:44:07 2021
// Host        : DESKTOP-1TCF4DO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mult_gen_0/mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_14,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module mult_gen_0
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
  mult_gen_0_mult_gen_v12_0_14 U0
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
(* C_VERBOSITY = "0" *) (* C_XDEVICEFAMILY = "kintex7" *) (* ORIG_REF_NAME = "mult_gen_v12_0_14" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module mult_gen_0_mult_gen_v12_0_14
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
  mult_gen_0_mult_gen_v12_0_14_viv i_mult
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
fYXZa41RgN+AHp4CrNj106MejSxNq5DUNUwZ2/bF6MpWZJ3KWrZzAQh1s+8fd2vc7kN9b+4uGYe3
+V5Q2oa6xwDn0zfjNv9eSUT/78vl924/ObiwcVLchJAiPXibQiG+OV9rTwTHrE8Onurzw8r196mk
cYISgfnxjBVjh51X59MORgYJy/4MgRSk2O1M8/p/7WF3uXoF4odTCa4Qj0J7QcoFhdpiDEBZnzQM
ia25vktCW1TxHrfE2CDF2IOObDmZcWH+FE12b0od6jH7OXT2Avn3lQ9VgUKRYmevLrkgiLbsTsO+
eDph1jO5SLuIPFrn3NDvB86Uj5S+Rink668Dvg==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
I22AyMFX4X++gltiDuAU78QYn16XeK+NkCBVJ185jTpet+TIdSmafJxo8Rw5Olz62cbMG9hvw1YE
Ls/xaplLSSX1v82Dtfpd1m7fnnmvP1sLVkt6niGkLelvtl47jRPcfx7HfEZMjjTOKRRFUoPEvv79
4z0KUDkSCQbmCkPfTmufWmLciXxZHo5Kw0H/QVfhReur+NhItUUAnAWyd8C+3ajWD+KCCgC1Dt61
WSdlOYD6EbTr5JEwweyJq+DJAqXNya26DyMKhfzrMisXC0xdW22MPM64iIpYe/cp6+ntbKPF8GfC
36pkaElN2hEr9kqxIw/uCJO/aIBSk6VM1FgD7Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 7248)
`pragma protect data_block
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
0cVHXqhYbqT8
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
