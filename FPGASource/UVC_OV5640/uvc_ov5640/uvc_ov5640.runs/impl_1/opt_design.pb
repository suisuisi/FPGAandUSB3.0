
O
Command: %s
53*	vivadotcl2

opt_design2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7k325t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7k325t2default:defaultZ17-349h px? 
n
,Running DRC as a precondition to command %s
22*	vivadotcl2

opt_design2default:defaultZ4-22h px? 
R

Starting %s Task
103*constraints2
DRC2default:defaultZ18-103h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
U
DRC finished with %s
272*project2
0 Errors2default:defaultZ1-461h px? 
d
BPlease refer to the DRC report (report_drc) for more information.
274*projectZ1-462h px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 1511.289 ; gain = 0.0002default:defaulth px? 
g

Starting %s Task
103*constraints2,
Cache Timing Information2default:defaultZ18-103h px? 
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
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
P
;Ending Cache Timing Information Task | Checksum: 1a2f9b49b
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:01 . Memory (MB): peak = 1511.289 ; gain = 0.0002default:defaulth px? 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px? 
?

Phase %s%s
101*constraints2
1 2default:default27
#Generate And Synthesize Debug Cores2default:defaultZ18-101h px? 
k
)Generating Script for core instance : %s 214*	chipscope2
dbg_hub2default:defaultZ16-329h px? 
?
Generating IP %s for %s.
1712*coregen2+
xilinx.com:ip:xsdbm:3.02default:default2

dbg_hub_CV2default:defaultZ19-3806h px? 
k
)Generating Script for core instance : %s 214*	chipscope2
u_ila_02default:defaultZ16-329h px? 
?
Generating IP %s for %s.
1712*coregen2)
xilinx.com:ip:ila:6.22default:default2

u_ila_0_CV2default:defaultZ19-3806h px? 
?
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2+
xilinx.com:ip:xsdbm:3.02default:default2$
9e989f5f4cba10ae2default:defaultZ16-220h px? 
?
NRe-using generated and synthesized IP, "%s", from Vivado IP cache entry "%s".
146*	chipscope2)
xilinx.com:ip:ila:6.22default:default2$
22a29bd1ba5505c52default:defaultZ16-220h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.2012default:default2
1702.6372default:default2
2.5082default:defaultZ17-268h px? 
W
BPhase 1 Generate And Synthesize Debug Cores | Checksum: 23b4b6a7c
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:12 ; elapsed = 00:00:38 . Memory (MB): peak = 1702.926 ; gain = 125.5432default:defaulth px? 
i

Phase %s%s
101*constraints2
2 2default:default2
Retarget2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
12default:default2
12default:defaultZ31-138h px? 
K
Retargeted %s cell(s).
49*opt2
02default:defaultZ31-49h px? 
<
'Phase 2 Retarget | Checksum: 11fdd4430
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:15 ; elapsed = 00:00:40 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Retarget2default:default2
2572default:default2
3972default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Retarget2default:default2
3162default:defaultZ31-1021h px? 
u

Phase %s%s
101*constraints2
3 2default:default2(
Constant propagation2default:defaultZ18-101h px? 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px? 
H
3Phase 3 Constant propagation | Checksum: 1696009d5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:16 ; elapsed = 00:00:41 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2(
Constant propagation2default:default2
252default:default2
4802default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2(
Constant propagation2default:default2
2792default:defaultZ31-1021h px? 
f

Phase %s%s
101*constraints2
4 2default:default2
Sweep2default:defaultZ18-101h px? 
9
$Phase 4 Sweep | Checksum: 161b4a59f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:17 ; elapsed = 00:00:43 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2
Sweep2default:default2
02default:default2
7692default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2
Sweep2default:default2
13182default:defaultZ31-1021h px? 
r

Phase %s%s
101*constraints2
5 2default:default2%
BUFG optimization2default:defaultZ18-101h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out1_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out1_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out3_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out3_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out4_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out4_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out5_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out5_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2e
Qu2_mig_7series_1/u_mig_7series_0_mig/u_ddr3_infrastructure/pll_clk3_out_BUFG_inst2default:default2
02default:default2`
Lu2_mig_7series_1/u_mig_7series_0_mig/u_ddr3_infrastructure/pll_clk3_out_BUFG2default:defaultZ31-194h px? 
W
!Inserted %s BUFG(s) on clock nets140*opt2
52default:defaultZ31-193h px? 
D
/Phase 5 BUFG optimization | Checksum: c6f6e2e4
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:18 ; elapsed = 00:00:44 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
EPhase %s created %s cells of which %s are BUFGs and removed %s cells.395*opt2%
BUFG optimization2default:default2
02default:default2
02default:default2
02default:defaultZ31-662h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2%
BUFG optimization2default:default2
12default:defaultZ31-1021h px? 
|

Phase %s%s
101*constraints2
6 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px? 
O
:Phase 6 Shift Register Optimization | Checksum: 1770359d3
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:21 ; elapsed = 00:00:46 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2/
Shift Register Optimization2default:default2
02default:default2
02default:defaultZ31-389h px? 
x

Phase %s%s
101*constraints2
7 2default:default2+
Post Processing Netlist2default:defaultZ18-101h px? 
J
5Phase 7 Post Processing Netlist | Checksum: b2dccb66
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:22 ; elapsed = 00:00:47 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
?
.Phase %s created %s cells and removed %s cells267*opt2+
Post Processing Netlist2default:default2
02default:default2
12default:defaultZ31-389h px? 
?
?In phase %s, %s netlist objects are constrained preventing optimization. Please run opt_design with -debug_log to get more detail. 510*opt2+
Post Processing Netlist2default:default2
792default:defaultZ31-1021h px? 
/
Opt_design Change Summary
*commonh px? 
/
=========================
*commonh px? 


*commonh px? 


*commonh px? 
?
z-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Phase                        |  #Cells created  |  #Cells Removed  |  #Constrained objects preventing optimizations  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Retarget                     |             257  |             397  |                                            316  |
|  Constant propagation         |              25  |             480  |                                            279  |
|  Sweep                        |               0  |             769  |                                           1318  |
|  BUFG optimization            |               0  |               0  |                                              1  |
|  Shift Register Optimization  |               0  |               0  |                                              0  |
|  Post Processing Netlist      |               0  |               1  |                                             79  |
-------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
a

Starting %s Task
103*constraints2&
Connectivity Check2default:defaultZ18-103h px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.090 . Memory (MB): peak = 1717.566 ; gain = 0.0002default:defaulth px? 
J
5Ending Logic Optimization Task | Checksum: 186e5f6dc
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:22 ; elapsed = 00:00:47 . Memory (MB): peak = 1717.566 ; gain = 140.1842default:defaulth px? 
a

Starting %s Task
103*constraints2&
Power Optimization2default:defaultZ18-103h px? 
s
7Will skip clock gating for clocks with period < %s ns.
114*pwropt2
2.002default:defaultZ34-132h px? 
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
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
=
Applying IDT optimizations ...
9*pwroptZ34-9h px? 
?
Applying ODC optimizations ...
10*pwroptZ34-10h px? 
?
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
0.9632default:default2
0.0002default:defaultZ32-619h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 


*pwropth px? 
e

Starting %s Task
103*constraints2*
PowerOpt Patch Enables2default:defaultZ18-103h px? 
?
?WRITE_MODE attribute of %s BRAM(s) out of a total of %s has been updated to save power.
    Run report_power_opt to get a complete listing of the BRAMs updated.
129*pwropt2
32default:default2
272default:defaultZ34-162h px? 
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
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
d
+Structural ODC has moved %s WE to EN ports
155*pwropt2
12default:defaultZ34-201h px? 
?
CNumber of BRAM Ports augmented: %s newly gated: %s Total Ports: %s
65*pwropt2
162default:default2
12default:default2
542default:defaultZ34-65h px? 
h
1Number of Flops added for Enable Generation: %s

23*pwropt2
52default:defaultZ34-23h px? 
N
9Ending PowerOpt Patch Enables Task | Checksum: 21be0a526
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 2293.770 ; gain = 0.0002default:defaulth px? 
J
5Ending Power Optimization Task | Checksum: 21be0a526
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:00:21 ; elapsed = 00:00:13 . Memory (MB): peak = 2293.770 ; gain = 576.2032default:defaulth px? 
\

Starting %s Task
103*constraints2!
Final Cleanup2default:defaultZ18-103h px? 
a

Starting %s Task
103*constraints2&
Logic Optimization2default:defaultZ18-103h px? 
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
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2e
Qu2_mig_7series_1/u_mig_7series_0_mig/u_ddr3_infrastructure/pll_clk3_out_BUFG_inst2default:default2
02default:default2`
Lu2_mig_7series_1/u_mig_7series_0_mig/u_ddr3_infrastructure/pll_clk3_out_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out5_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out5_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out4_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out4_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out3_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out3_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
?
4Inserted BUFG %s to drive %s load(s) on clock net %s141*opt2B
.u1_clk_wiz_0/inst/clk_out1_clk_wiz_1_BUFG_inst2default:default2
02default:default2=
)u1_clk_wiz_0/inst/clk_out1_clk_wiz_1_BUFG2default:defaultZ31-194h px? 
W
!Inserted %s BUFG(s) on clock nets140*opt2
52default:defaultZ31-193h px? 
J
5Ending Logic Optimization Task | Checksum: 1bc38dd33
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:05 ; elapsed = 00:00:04 . Memory (MB): peak = 2293.770 ; gain = 0.0002default:defaulth px? 
E
0Ending Final Cleanup Task | Checksum: 1bc38dd33
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:07 ; elapsed = 00:00:05 . Memory (MB): peak = 2293.770 ; gain = 0.0002default:defaulth px? 
b

Starting %s Task
103*constraints2'
Netlist Obfuscation2default:defaultZ18-103h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0202default:default2
2293.7702default:default2
0.0002default:defaultZ17-268h px? 
K
6Ending Netlist Obfuscation Task | Checksum: 1bc38dd33
*commonh px? 
?

%s
*constraints2s
_Time (s): cpu = 00:00:00 ; elapsed = 00:00:00.020 . Memory (MB): peak = 2293.770 ; gain = 0.0002default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
732default:default2
332default:default2
92default:default2
02default:defaultZ4-41h px? 
\
%s completed successfully
29*	vivadotcl2

opt_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
opt_design: 2default:default2
00:00:552default:default2
00:01:102default:default2
2293.7702default:default2
782.4802default:defaultZ17-268h px? 
?
4The following parameters have non-default value.
%s
395*common24
 tcl.collectionResultDisplayLimit2default:defaultZ17-600h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0192default:default2
2293.7702default:default2
0.0002default:defaultZ17-268h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:012default:default2 
00:00:00.0662default:default2
2293.7702default:default2
0.0002default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0202default:default2
2293.7702default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2l
XE:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.runs/impl_1/UVC_OV5640_opt.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:112default:default2
00:00:062default:default2
2293.7702default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
pExecuting : report_drc -file UVC_OV5640_drc_opted.rpt -pb UVC_OV5640_drc_opted.pb -rpx UVC_OV5640_drc_opted.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2w
creport_drc -file UVC_OV5640_drc_opted.rpt -pb UVC_OV5640_drc_opted.pb -rpx UVC_OV5640_drc_opted.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
^E:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.runs/impl_1/UVC_OV5640_drc_opted.rpt^E:/FILE/at7_img_ex11_uvc/UVC_OV5640/uvc_ov5640/uvc_ov5640.runs/impl_1/UVC_OV5640_drc_opted.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 


End Record