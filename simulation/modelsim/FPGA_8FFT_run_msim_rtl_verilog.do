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
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/clock_divider.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/mux2in1.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/flash.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/FFT16_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/rom_twiddle.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/ram_16_byte.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/mux4in1.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/FFT16_top_tb.v}

vlog -vlog01compat -work work +incdir+C:/Users/denlo/Documents/Quartus/FPGA_8FFT {C:/Users/denlo/Documents/Quartus/FPGA_8FFT/FFT16_top_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  FFT16_top_tb

add wave *
view structure
view signals
run -all
