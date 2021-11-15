// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Mon Nov 15 23:41:38 2021
// Host        : DESKTOP-1TCF4DO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               C:/Users/Administrator/Desktop/FPGAUSB/CYUSB3014/FPGASource/USBLoopBack/StreamerOUT/streamout/streamout.srcs/sources_1/ip/ila_0/ila_0_stub.v
// Design      : ila_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2018.3" *)
module ila_0(clk, probe0, probe1, probe2, probe3, probe4, probe5)
/* synthesis syn_black_box black_box_pad_pin="clk,probe0[6:0],probe1[1:0],probe2[31:0],probe3[0:0],probe4[7:0],probe5[31:0]" */;
  input clk;
  input [6:0]probe0;
  input [1:0]probe1;
  input [31:0]probe2;
  input [0:0]probe3;
  input [7:0]probe4;
  input [31:0]probe5;
endmodule
