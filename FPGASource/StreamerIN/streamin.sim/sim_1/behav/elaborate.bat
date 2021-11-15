@echo off
set xv_path=D:\\Xilinx\\Vivado\\2016.2\\bin
call %xv_path%/xelab  -wto 0fd604fa43664afbb4172d9765411c21 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip --snapshot sim_fifo_behav xil_defaultlib.sim_fifo xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
