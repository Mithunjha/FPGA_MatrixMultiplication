transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/core.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/bus.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/register.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/instr_memory.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/control_unit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/reginc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/acc.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/multi_core_processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/DRAM.v}

vlog -sv -work work +incdir+C:/Users/Vinith\ Kugathasan/OneDrive/Desktop/Rectangular\ Core/N\ Core {C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/multi_core_processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  multi_core_processor_tb

add wave *
view structure
view signals
run -all
