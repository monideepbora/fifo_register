
all:
	ghdl -a fifo.vhd fifo_tb.vhd
	ghdl -e fifo_tb
	./fifo_tb

clean: 
	rm *.o *.cf fifo_tb
