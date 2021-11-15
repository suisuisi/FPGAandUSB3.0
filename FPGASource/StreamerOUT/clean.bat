@echo off
del *.log
del *.btree
del *.jou
del *.str

#del output_files\*.rpt /q /f /s
#del simulation\modelsim\*.* /q /f /s
RMDIR /S /Q .Xil
RMDIR /S /Q lvds_prj.sim\sim_1

