onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fifo_tb/UUT/clk
add wave -noupdate /fifo_tb/UUT/sync_reset
add wave -noupdate /fifo_tb/UUT/wr_en
add wave -noupdate /fifo_tb/UUT/rd_en
add wave -noupdate -radix hexadecimal /fifo_tb/UUT/wr_data
add wave -noupdate -radix hexadecimal /fifo_tb/UUT/rd_data
add wave -noupdate -radix hexadecimal -childformat {{{/fifo_tb/UUT/fifo_mem[0]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[1]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[2]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[3]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[4]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[5]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[6]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[7]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[8]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[9]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[10]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[11]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[12]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[13]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[14]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[15]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[16]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[17]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[18]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[19]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[20]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[21]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[22]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[23]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[24]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[25]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[26]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[27]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[28]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[29]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[30]} -radix hexadecimal} {{/fifo_tb/UUT/fifo_mem[31]} -radix hexadecimal}} -expand -subitemconfig {{/fifo_tb/UUT/fifo_mem[0]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[1]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[2]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[3]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[4]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[5]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[6]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[7]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[8]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[9]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[10]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[11]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[12]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[13]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[14]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[15]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[16]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[17]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[18]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[19]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[20]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[21]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[22]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[23]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[24]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[25]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[26]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[27]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[28]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[29]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[30]} {-height 15 -radix hexadecimal} {/fifo_tb/UUT/fifo_mem[31]} {-height 15 -radix hexadecimal}} /fifo_tb/UUT/fifo_mem
add wave -noupdate /fifo_tb/UUT/flag_full
add wave -noupdate /fifo_tb/UUT/flag_empty
add wave -noupdate /fifo_tb/UUT/flag_almost_full
add wave -noupdate /fifo_tb/UUT/flag_almost_empty
add wave -noupdate /fifo_tb/UUT/wr_index
add wave -noupdate /fifo_tb/UUT/rd_index
add wave -noupdate /fifo_tb/UUT/fifo_counter
add wave -noupdate /fifo_tb/UUT/flag_full_reg
add wave -noupdate /fifo_tb/UUT/flag_empty_reg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {350214 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 228
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
configure wave -timelineunits ps
update
WaveRestoreZoom {341163 ps} {403097 ps}
