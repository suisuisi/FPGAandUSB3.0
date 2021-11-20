vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/v_demosaic_v1_0_4

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap v_demosaic_v1_0_4 riviera/v_demosaic_v1_0_4

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/src" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/src" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_AXIvideo2MultiBayer2.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_Debayer.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerG.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerG_DIV1_TABLE.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerG_DIV2_TABLE.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerG_linebuf_bkb.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerRandBatG.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerRatBorBatR.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_DebayerRatBorBatRkbM.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_fifo_w8_d2_A.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_fifo_w8_d2_A_x.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_fifo_w16_d2_A.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_fifo_w16_d2_A_x.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_MultiPixStream2AXIvi.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_reg_unsigned_short_s.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_start_for_DebayerpcA.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_start_for_MultiPircU.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_start_for_ZipperRqcK.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_CTRL_s_axi.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mac_mujbC.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mul_mug8j.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mul_muhbi.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mul_muibs.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mux_32mb6.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic_mux_53fYi.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_ZipperRemoval.v" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/hdl/verilog/v_demosaic_0_v_demosaic.v" \

vlog -work v_demosaic_v1_0_4  -v2k5 "+incdir+../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/src" \
"../../../ipstatic/hdl/v_demosaic_v1_0_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/src" \
"../../../../uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/sim/v_demosaic_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

