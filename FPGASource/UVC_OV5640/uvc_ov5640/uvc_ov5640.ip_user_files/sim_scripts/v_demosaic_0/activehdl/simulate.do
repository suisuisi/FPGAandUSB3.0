onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+v_demosaic_0 -L xil_defaultlib -L xpm -L v_demosaic_v1_0_4 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.v_demosaic_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {v_demosaic_0.udo}

run -all

endsim

quit -force
