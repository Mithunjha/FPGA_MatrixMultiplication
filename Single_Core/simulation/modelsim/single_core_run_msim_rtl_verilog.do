transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/core.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/bus.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/register.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/instr_memory.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/control_unit.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/reginc.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/alu.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/acc.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/DRAM.v}
vlog -vlog01compat -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/single_core_processor.v}

vlog -sv -work work +incdir+F:/Single_Core/Single_Core {F:/Single_Core/Single_Core/single_core_processor_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  single_core_processor_tb

add wave *
view structure
view signals
run -all
