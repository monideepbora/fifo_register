/* Description : FIFO module in verilog 
 Author : Monideep Bora */

 module fifo #(
     parameter width = 32,
     parameter depth = 32,
     parameter almost_full_threshold = 24,
     parameter almost_empty_threshold = 8
 )

 (
    // clock, synchronous reset and enable signals 
    input wire  clk, sync_reset, 
                wr_en, rd_en,

    // buses (separate read and write ports)
    input wire [width-1:0] wr_data, 
    output wire [width-1:0] rd_data,

    // flags  
    output wire flag_full, flag_empty,
                flag_almost_full,
                flag_almost_empty    
 );

    // memory element declaration
    // 'depth' number of locations of 'width' number of bits each   
    reg [width-1:0] fifo_mem [0:depth-1];

    // indices that point to next location to be written to/read from
    reg[$clog2(depth)-1:0] wr_index = 0, rd_index=0;
    // counter that increments/decrements on write/read respectively.
    // counter has to accomodate for overflows
    reg[$clog2(depth)+1:0]fifo_counter=0;
    // registered flag signals
    wire flag_full_reg, flag_empty_reg;

    //initialize memory locations
    integer i;
    initial
    begin
        for(i=0;i!=1024;i=i+1)
        begin 
            fifo_mem[i] = 0;
        end
    end

     always @(posedge clk,posedge sync_reset) begin
        if(sync_reset)
            begin // sync_reset resets the indices and counter.
                fifo_counter <= 1'b0;
                wr_index <= 1'b0;
                rd_index <= 1'b0;
            end
        else
            begin //  increments/decrements the counter on write/read
                if(wr_en==1'b1 && rd_en==1'b0)
                    fifo_counter = fifo_counter + 1;
                else if (wr_en==1'b0 && rd_en==1'b1) 
                    fifo_counter = fifo_counter - 1;
            
                // increments the read index if within limits or wraps around
                if(rd_en==1'b1 && flag_empty_reg==1'b0)
                    if(rd_index==depth-1)
                        rd_index <= 0;
                    else
                        rd_index <= rd_index + 1;

                // increments the write index if within limits or wraps around
                if(wr_en==1'b1 && flag_full_reg==1'b0)
                    if(wr_index==depth-1)
                        wr_index <= 0;
                    else
                        wr_index <= wr_index + 1;
                // synchronous write construct, register from write bus to next fifo location
                if(wr_en==1'b1)
                    begin
                        fifo_mem[wr_index] <= wr_data;
                    end
            end
        
     end

    // asynchronous read operation on index updated during last clock cycle.
     assign rd_data = fifo_mem[rd_index];

    // combinational logic to update the flags 
     assign flag_full_reg = (fifo_counter > depth-1) ? 1 : 0;
     assign flag_empty_reg = (fifo_counter == 1'b0 ) ? 1 : 0;

     assign flag_full = flag_full_reg;
     assign flag_empty = flag_empty_reg;

     assign flag_almost_full = (fifo_counter > almost_full_threshold) ? 1 : 0;
     assign flag_almost_empty = (fifo_counter < almost_empty_threshold ) ? 1 : 0;

 endmodule