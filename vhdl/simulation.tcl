# modelsim tcl script to simulate the RTL design of a FIFO register
#############################################################

################### PARAMETERS ###################
set SOURCE_PATH   ./
transcript off

################ COMPILE SOURCE ###################

vlib work
vmap work work

vcom -work work $SOURCE_PATH/fifo.vhd

#testbench
vcom -work work $SOURCE_PATH/fifo_tb.vhd

################### SIMULATION #####################
vsim work.fifo_tb

################### LOAD WAVEFORMS ###################
do wave.do

################### RUN ###################
run 400ns
