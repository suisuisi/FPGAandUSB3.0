set_property SRC_FILE_INFO {cfile:e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc rfile:../../../uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.2
