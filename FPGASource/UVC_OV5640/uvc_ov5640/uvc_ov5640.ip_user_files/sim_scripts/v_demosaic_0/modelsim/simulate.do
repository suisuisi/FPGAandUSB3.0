onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L xpm -L v_demosaic_v1_0_4 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.v_demosaic_0 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {v_demosaic_0.udo}

run -all

quit -force
