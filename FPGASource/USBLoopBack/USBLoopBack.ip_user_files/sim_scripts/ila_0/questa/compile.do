vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 \
"D:/Xilinx/Vivado/2016.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ila_v6_1_1/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/ltlib_v1_0_0/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbm_v1_1_3/hdl/verilog" "+incdir+../../../../at7.srcs/sources_1/ip/ila_0/xsdbs_v1_0_2/hdl/verilog" \
"../../../../at7.srcs/sources_1/ip/ila_0/sim/ila_0.v" \

vlog -work xil_defaultlib "glbl.v"

