# modelsim tcl script to simulate the RTL design of a FIFO register
#############################################################

################### PARAMETERS ###################
set SOURCE_PATH   ./
transcript off

################ COMPILE SOURCE ###################

vlib work
vmap work work

vlog -work work $SOURCE_PATH/fifo.v 

#testbench , mixed simualtion
vcom -work work $SOURCE_PATH/fifo_tb.vhd

################### SIMULATION #####################
vsim work.fifo_tb

################### LOAD WAVEFORMS ###################
do wave.do

################### RUN ###################
run 400ns
