onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /single_core_processor_tb/clk
add wave -noupdate -radix unsigned /single_core_processor_tb/status
add wave -noupdate -radix unsigned /single_core_processor_tb/rst
add wave -noupdate -radix unsigned /single_core_processor_tb/end_process
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/clk
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/status
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rst
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/dram_wrEn
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/read_IRAM
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/pc_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/dram_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/iram_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/ar_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/bus_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/end_process
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/alu_op
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/write_en
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/read_en
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/inc_en
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/alu_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/r_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/ac_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/ra_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rb_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/ro_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rn_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rp_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rc_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rr_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/rt_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/dr_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/tr_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/ir_out
add wave -noupdate -radix unsigned /single_core_processor_tb/processor/core1/z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13317497 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 325
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {10824650 ps} {11840074 ps}
