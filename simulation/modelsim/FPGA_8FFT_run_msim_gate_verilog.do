transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {FPGA_8FFT.vo}

vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_16FFT {C:/Users/denlo/Documents/Quartus/FPGA_16FFT/butterfly2_tb_tb.v}

vsim -t 1ps -L altera_ver -L cycloneive_ver -L gate_work -L work -voptargs="+acc"  butterfly2_tb_tb

add wave *
view structure
view signals
run -all
