


# 50MHz
set_property IOSTANDARD LVCMOS18 [get_ports sys_clk_i]
set_property PACKAGE_PIN D27 [get_ports sys_clk_i]



#set_property IOSTANDARD LVCMOS15 [get_ports ddr3_reset_n]

set_property IOSTANDARD LVCMOS33 [get_ports {led[0]}]
set_property PACKAGE_PIN T21 [get_ports {led[0]}]



# sensor


set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_scl]
set_property PACKAGE_PIN AF25 [get_ports image_sensor_scl]
set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_sda]
set_property PACKAGE_PIN AF20 [get_ports image_sensor_sda]
set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_reset_n]
set_property PACKAGE_PIN AE25 [get_ports image_sensor_reset_n]
#set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_pwdn]
#set_property PACKAGE_PIN J5 [get_ports image_sensor_pwdn]
set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_pclk]
set_property PACKAGE_PIN AE28 [get_ports image_sensor_pclk]
#set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_xclk]
#set_property PACKAGE_PIN E2 [get_ports image_sensor_xclk]
set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_vsync]
set_property PACKAGE_PIN AB29 [get_ports image_sensor_vsync]
set_property IOSTANDARD LVCMOS18 [get_ports image_sensor_href]
set_property PACKAGE_PIN AA28 [get_ports image_sensor_href]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets image_sensor_pclk_IBUF]

set_property PACKAGE_PIN AG28 [get_ports {image_sensor_data[0]}]
set_property PACKAGE_PIN AG27 [get_ports {image_sensor_data[1]}]
set_property PACKAGE_PIN AF27 [get_ports {image_sensor_data[2]}]
set_property PACKAGE_PIN AF28 [get_ports {image_sensor_data[3]}]
set_property PACKAGE_PIN AE26 [get_ports {image_sensor_data[4]}]
set_property PACKAGE_PIN AC26 [get_ports {image_sensor_data[5]}]
set_property PACKAGE_PIN AB22 [get_ports {image_sensor_data[6]}]
set_property PACKAGE_PIN AA22 [get_ports {image_sensor_data[7]}]
set_property IOSTANDARD LVCMOS18 [get_ports {image_sensor_data[*]}]




#USB3
set_property PACKAGE_PIN AC21 [get_ports {fx3_db[0]}]
set_property PACKAGE_PIN AC20 [get_ports {fx3_db[1]}]
set_property PACKAGE_PIN AE23 [get_ports {fx3_db[2]}]
set_property PACKAGE_PIN AA23 [get_ports {fx3_db[3]}]
set_property PACKAGE_PIN AE24 [get_ports {fx3_db[4]}]
set_property PACKAGE_PIN AF23 [get_ports {fx3_db[5]}]
set_property PACKAGE_PIN AC22 [get_ports {fx3_db[6]}]
set_property PACKAGE_PIN AA26 [get_ports {fx3_db[7]}]
set_property PACKAGE_PIN AD22 [get_ports {fx3_db[8]}]
set_property PACKAGE_PIN Y25 [get_ports {fx3_db[9]}]
set_property PACKAGE_PIN AD24 [get_ports {fx3_db[10]}]
set_property PACKAGE_PIN AC24 [get_ports {fx3_db[11]}]
set_property PACKAGE_PIN AB24 [get_ports {fx3_db[12]}]
set_property PACKAGE_PIN AC25 [get_ports {fx3_db[13]}]
set_property PACKAGE_PIN AG20 [get_ports {fx3_db[14]}]
set_property PACKAGE_PIN Y26 [get_ports {fx3_db[15]}]
set_property PACKAGE_PIN Y28 [get_ports {fx3_db[16]}]
set_property PACKAGE_PIN AJ24 [get_ports {fx3_db[17]}]
set_property PACKAGE_PIN W29 [get_ports {fx3_db[18]}]
set_property PACKAGE_PIN W28 [get_ports {fx3_db[19]}]
set_property PACKAGE_PIN AK25 [get_ports {fx3_db[20]}]
set_property PACKAGE_PIN Y23 [get_ports {fx3_db[21]}]
set_property PACKAGE_PIN Y24 [get_ports {fx3_db[22]}]
set_property PACKAGE_PIN AK20 [get_ports {fx3_db[23]}]
set_property PACKAGE_PIN AK23 [get_ports {fx3_db[24]}]
set_property PACKAGE_PIN Y20 [get_ports {fx3_db[25]}]
set_property PACKAGE_PIN Y21 [get_ports {fx3_db[26]}]
set_property PACKAGE_PIN AF21 [get_ports {fx3_db[27]}]
set_property PACKAGE_PIN AA21 [get_ports {fx3_db[28]}]
set_property PACKAGE_PIN AH25 [get_ports {fx3_db[29]}]
set_property PACKAGE_PIN AG25 [get_ports {fx3_db[30]}]
set_property PACKAGE_PIN AK24 [get_ports {fx3_db[31]}]
set_property IOSTANDARD LVCMOS18 [get_ports {fx3_db[*]}]

set_property PACKAGE_PIN AJ23 [get_ports {fx3_a[0]}]
set_property PACKAGE_PIN AF22 [get_ports {fx3_a[1]}]
set_property IOSTANDARD LVCMOS18 [get_ports {fx3_a[*]}]

set_property PACKAGE_PIN AG23 [get_ports fx3_pclk]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_pclk]
set_property PACKAGE_PIN H20 [get_ports FX3_RESET]
set_property IOSTANDARD LVCMOS18 [get_ports FX3_RESET]
set_property PACKAGE_PIN AA20 [get_ports FX3_SCL]
set_property IOSTANDARD LVCMOS18 [get_ports FX3_SCL]
set_property PACKAGE_PIN AB20 [get_ports FX3_SDA]
set_property IOSTANDARD LVCMOS18 [get_ports FX3_SDA]

set_property PACKAGE_PIN AD23 [get_ports fx3_flaga]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_flaga]
set_property PACKAGE_PIN AG22 [get_ports fx3_flagb]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_flagb]
set_property PACKAGE_PIN AH22 [get_ports fx3_flagc]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_flagc]
set_property PACKAGE_PIN AJ22 [get_ports fx3_flagd]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_flagd]
set_property PACKAGE_PIN AK21 [get_ports fx3_slcs_n]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_slcs_n]
set_property PACKAGE_PIN AH21 [get_ports fx3_slwr_n]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_slwr_n]
set_property PACKAGE_PIN AH20 [get_ports fx3_sloe_n]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_sloe_n]
set_property PACKAGE_PIN AE20 [get_ports fx3_slrd_n]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_slrd_n]
set_property PACKAGE_PIN W27 [get_ports fx3_pktend_n]
set_property IOSTANDARD LVCMOS18 [get_ports fx3_pktend_n]



set_max_delay -from [get_ports *image*] 10.000
set_min_delay -from [get_ports *image*] 0.000

#create_debug_port u_ila_0 probe
#set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
#set_property port_width 1 [get_debug_ports u_ila_0/probe3]
#connect_debug_port u_ila_0/probe3 [get_nets [list switch_IBUF]]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 4 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER true [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL true [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list u1_clk_wiz_0/inst/clk_out3]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 8 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u3_image_controller/image_sensor_data[0]} {u3_image_controller/image_sensor_data[1]} {u3_image_controller/image_sensor_data[2]} {u3_image_controller/image_sensor_data[3]} {u3_image_controller/image_sensor_data[4]} {u3_image_controller/image_sensor_data[5]} {u3_image_controller/image_sensor_data[6]} {u3_image_controller/image_sensor_data[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 10 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u3_image_controller/uut_image_capture/line_cnt[0]} {u3_image_controller/uut_image_capture/line_cnt[1]} {u3_image_controller/uut_image_capture/line_cnt[2]} {u3_image_controller/uut_image_capture/line_cnt[3]} {u3_image_controller/uut_image_capture/line_cnt[4]} {u3_image_controller/uut_image_capture/line_cnt[5]} {u3_image_controller/uut_image_capture/line_cnt[6]} {u3_image_controller/uut_image_capture/line_cnt[7]} {u3_image_controller/uut_image_capture/line_cnt[8]} {u3_image_controller/uut_image_capture/line_cnt[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list u3_image_controller/uut_image_capture/image_ddr3_clr]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list u3_image_controller/uut_image_capture/image_ddr3_frame_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list u3_image_controller/uut_image_capture/image_ddr3_frame_start]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list u3_image_controller/uut_image_capture/image_ddr3_line_end]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list u3_image_controller/uut_image_capture/image_ddr3_wren]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list u3_image_controller/image_sensor_href]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list u3_image_controller/uut_image_capture/image_sensor_href]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list u3_image_controller/image_sensor_pclk]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list u3_image_controller/image_sensor_scl]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list u3_image_controller/uut_image_capture/image_sensor_vsync]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list u3_image_controller/image_sensor_vsync]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets image_lcd_clk]
