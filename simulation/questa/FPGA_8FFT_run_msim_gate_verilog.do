transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {FPGA_8FFT.vo}

vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_16FFT {C:/Users/denlo/Documents/Quartus/FPGA_16FFT/FFT16_top_tb.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  FFT16_top_tb

add wave *
view structure
view signals
run -all
