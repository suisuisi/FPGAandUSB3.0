
w
Command: %s
53*	vivadotcl2F
2link_design -top UVC_OV5640 -part xc7k325tffg900-22default:defaultZ4-113h px? 
g
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_12default:defaultZ12-437h px? 
j
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_12default:defaultZ12-434h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2w
ce:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.dcp2default:default2 
u1_clk_wiz_02default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2?
me:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0.dcp2default:default2$
u2_mig_7series_12default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2o
[e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/vio_0/vio_0.dcp2default:default2
u9_vio2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_3/fifo_generator_3.dcp2default:default2N
:u3_image_controller/uut_image_capture/uut_image_cache_fifo2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2}
ie:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/v_demosaic_0.dcp2default:default21
u4_bayer2rgb/uut_v_demosaic_12default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2y
ee:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mult_gen_0/mult_gen_0.dcp2default:default2)
u5_rgb2yuv/mult_gen_02default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2.dcp2default:default29
%u6_ddr3_cache/fifo_for_ddr3_read_left2default:defaultZ1-454h px? 
?
-Reading design checkpoint '%s' for cell '%s'
275*project2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1.dcp2default:default2:
&u6_ddr3_cache/fifo_for_ddr3_write_left2default:defaultZ1-454h px? 
h
-Analyzing %s Unisim elements for replacement
17*netlist2
13552default:defaultZ29-17h px? 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
12default:defaultZ29-28h px? 
x
Netlist was created with %s %s291*project2
Vivado2default:default2
2018.32default:defaultZ1-479h px? 
W
Loading part %s157*device2$
xc7k325tffg900-22default:defaultZ21-403h px? 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px? 
?
FRemoving redundant OBUF since it is not driving a top-level port. %s 
33*opt2?
?u2_mig_7series_1/u_mig_7series_0_mig/u_memc_ui_top_std/mem_intfc0/ddr_phy_top0/u_ddr_mc_phy_wrapper/gen_cs_n_obuf.gen_cs_obuf[0].u_cs_n_obuf2default:defaultZ31-33h px? 
g
1Inserted %s IBUFs to IO ports without IO buffers.100*opt2
12default:defaultZ31-140h px? 
?
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt22
u1_clk_wiz_0/inst/clkin1_ibufg2default:default2
	sys_clk_i2default:defaultZ31-35h px? 
?
?Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2 
IBUF_LOW_PWR2default:default2*
u1_clk_wiz_0/clk_in12default:default2 
IBUF_LOW_PWR2default:default8Z18-550h px? 
?
?Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
DRIVE2default:default23
u2_mig_7series_1/ddr3_cs_n[0]2default:default2
DRIVE2default:default8Z18-550h px? 
?
?Could not create '%s' constraint because net '%s' is not directly connected to top level port. Synthesis is ignored for %s but preserved for implementation.
528*constraints2
SLEW2default:default23
u2_mig_7series_1/ddr3_cs_n[0]2default:default2
SLEW2default:default8Z18-550h px? 
?
Core: %s UUID: %s 
209*	chipscope2
u9_vio2default:default28
$ad56ad37-1ebc-550c-8b95-bc7f1ccb09402default:defaultZ16-324h px? 
?
Cannot debug net '%s'; %s3*	chipscope2:
$u3_image_controller/image_sensor_sda2default:default2A
-it is not accessible from the fabric routing.2default:default8Z16-3h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2&
u2_mig_7series_1	2default:default8Z20-848h px? 
?
^Cannot set scoped property '%s', because the property does not exist for objects of type '%s'.335*netlist2
	VCCAUX_IO2default:default2
pin2default:default2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2
3722default:default8@Z29-160h px?
?
^Cannot set scoped property '%s', because the property does not exist for objects of type '%s'.335*netlist2
SLEW2default:default2
pin2default:default2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2
3732default:default8@Z29-160h px?
?
^Cannot set scoped property '%s', because the property does not exist for objects of type '%s'.335*netlist2

IOSTANDARD2default:default2
pin2default:default2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2
3742default:default8@Z29-160h px?
?
^Cannot set scoped property '%s', because the property does not exist for objects of type '%s'.335*netlist2
PACKAGE_PIN2default:default2
pin2default:default2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2
3752default:default8@Z29-160h px?
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
?e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/mig_7series_0_1/mig_7series_0/user_design/constraints/mig_7series_0.xdc2default:default2&
u2_mig_7series_1	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2
ie:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_board.xdc2default:default2'
u1_clk_wiz_0/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2
ie:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1_board.xdc2default:default2'
u1_clk_wiz_0/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2y
ce:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc2default:default2'
u1_clk_wiz_0/inst	2default:default8Z20-848h px? 
?
%Done setting XDC timing constraints.
35*timing2y
ce:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc2default:default2
572default:default8@Z38-35h px? 
?
Deriving generated clocks
2*timing2y
ce:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc2default:default2
572default:default8@Z38-2h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
get_clocks: 2default:default2
00:00:102default:default2
00:00:102default:default2
1507.7732default:default2
586.7772default:defaultZ17-268h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2y
ce:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/clk_wiz_1/clk_wiz_1.xdc2default:default2'
u1_clk_wiz_0/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_3/fifo_generator_3.xdc2default:default2S
=u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_3/fifo_generator_3.xdc2default:default2S
=u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_left/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_left/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_righ/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_righ/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_left/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_left/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_righ/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
qe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_righ/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2q
[e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/vio_0/vio_0.xdc2default:default2
u9_vio	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2q
[e:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/vio_0/vio_0.xdc2default:default2
u9_vio	2default:default8Z20-847h px? 
?
Parsing XDC File [%s]
179*designutils2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default8Z20-179h px? 
?
No ports matched '%s'.
584*	planAhead2
FX3_SCL2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
952default:default8@Z12-584h px? 
?
"'%s' expects at least one object.
55*common2 
set_property2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
952default:default8@Z17-55h px?
?
No ports matched '%s'.
584*	planAhead2
FX3_SCL2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
962default:default8@Z12-584h px? 
?
"'%s' expects at least one object.
55*common2 
set_property2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
962default:default8@Z17-55h px?
?
No ports matched '%s'.
584*	planAhead2
FX3_SDA2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
972default:default8@Z12-584h px? 
?
"'%s' expects at least one object.
55*common2 
set_property2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
972default:default8@Z17-55h px?
?
No ports matched '%s'.
584*	planAhead2
FX3_SDA2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
982default:default8@Z12-584h px? 
?
"'%s' expects at least one object.
55*common2 
set_property2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
982default:default8@Z17-55h px?
?
$%s: '%s' is not a valid startpoint.
402*constraints2!
set_max_delay2default:default2*
image_sensor_reset_n2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
1212default:default8@Z18-402h px? 
?
$%s: '%s' is not a valid startpoint.
402*constraints2!
set_max_delay2default:default2&
image_sensor_scl2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
1212default:default8@Z18-402h px? 
?
$%s: '%s' is not a valid startpoint.
402*constraints2!
set_min_delay2default:default2*
image_sensor_reset_n2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
1222default:default8@Z18-402h px? 
?
$%s: '%s' is not a valid startpoint.
402*constraints2!
set_min_delay2default:default2&
image_sensor_scl2default:default2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default2
1222default:default8@Z18-402h px? 
?
Finished Parsing XDC File [%s]
178*designutils2j
TE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/constrs_1/new/uvc.xdc2default:default8Z20-178h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_3/fifo_generator_3_clocks.xdc2default:default2S
=u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_3/fifo_generator_3_clocks.xdc2default:default2S
=u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2
ie:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/v_demosaic_0.xdc2default:default28
"u4_bayer2rgb/uut_v_demosaic_1/inst	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2
ie:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/v_demosaic_0/v_demosaic_0.xdc2default:default28
"u4_bayer2rgb/uut_v_demosaic_1/inst	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1_clocks.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_left/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1_clocks.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_left/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1_clocks.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_righ/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_1/fifo_generator_1_clocks.xdc2default:default2?
)u6_ddr3_cache/fifo_for_ddr3_write_righ/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2_clocks.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_left/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2_clocks.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_left/U0	2default:default8Z20-847h px? 
?
$Parsing XDC File [%s] for cell '%s'
848*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2_clocks.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_righ/U0	2default:default8Z20-848h px? 
?
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2?
xe:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.srcs/sources_1/ip/fifo_generator_2/fifo_generator_2_clocks.xdc2default:default2>
(u6_ddr3_cache/fifo_for_ddr3_read_righ/U0	2default:default8Z20-847h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
wu6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
vu6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/rd_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2V
@C:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_gray.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gcx.clkx/wr_pntr_cdc_inst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_rrst_wr	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2X
BC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_single.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_single_inst_wrst_rd	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_write_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_left/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u6_ddr3_cache/fifo_for_ddr3_read_righ/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.gic_rst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gsckt_wrst.xpm_cdc_sync_rst_inst_wrst	2default:default8Z20-1687h px? 
?
%Sourcing Tcl File [%s] for cell '%s'
1448*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1689h px? 
?
.Finished Sourcing Tcl File [%s] for cell '%s'
1446*designutils2Z
DC:/Xilinx/Vivado/2018.3/data/ip/xpm/xpm_cdc/tcl/xpm_cdc_sync_rst.tcl2default:default2?
?u3_image_controller/uut_image_capture/uut_image_cache_fifo/U0/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/ngwrdrst.grst.g7serrst.gnrst_full.gsckt_bsy_o.xpm_cdc_sync_rst_sckt_bsy_o	2default:default8Z20-1687h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0082default:default2
1511.2892default:default2
0.0002default:defaultZ17-268h px? 
?
!Unisim Transformation Summary:
%s111*project2?
?  A total of 268 instances were transformed.
  IOBUF => IOBUF (IBUF, OBUFT): 1 instances
  IOBUFDS_DIFF_OUT_DCIEN => IOBUFDS_DIFF_OUT_DCIEN (IBUFDS_IBUFDISABLE_INT, IBUFDS_IBUFDISABLE_INT, INV, OBUFTDS_DCIEN, OBUFTDS_DCIEN): 4 instances
  IOBUF_DCIEN => IOBUF_DCIEN (IBUF_IBUFDISABLE, OBUFT_DCIEN): 32 instances
  OBUFDS => OBUFDS_DUAL_BUF (INV, OBUFDS, OBUFDS): 1 instances
  RAM32M => RAM32M (RAMD32, RAMD32, RAMD32, RAMD32, RAMD32, RAMD32, RAMS32, RAMS32): 230 instances
2default:defaultZ1-111h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
192default:default2
132default:default2
92default:default2
02default:defaultZ4-41h px? 
]
%s completed successfully
29*	vivadotcl2
link_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2!
link_design: 2default:default2
00:00:262default:default2
00:00:272default:default2
1511.2892default:default2
1102.4962default:defaultZ17-268h px? 
?
4The following parameters have non-default value.
%s
395*common24
 tcl.collectionResultDisplayLimit2default:defaultZ17-600h px? 


End Record