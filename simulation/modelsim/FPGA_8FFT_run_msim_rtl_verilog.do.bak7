transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/butterfly2.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/multiplier.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/get_negative.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/adder3.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/butterfly2_tb.v}

vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/butterfly2_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  butterfly2_tb

add wave *
view structure
view signals
run -all
