onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+dist_mem_gen_minecraftDirt -L xil_defaultlib -L xpm -L dist_mem_gen_v8_0_11 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.dist_mem_gen_minecraftDirt xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {dist_mem_gen_minecraftDirt.udo}

run -all

endsim

quit -force
