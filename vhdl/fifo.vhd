-- Description : FIFO Entity in VHDL
-- Author : Monideep Bora


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo is
  generic (
    width : natural := 32; -- 32 bits of data in one location
    depth : natural := 32; -- 32 locations of data
    almost_full_threshold : natural := 24; -- 8 locations to full
    almost_empty_threshold : natural := 8 -- 8 locations to empty 
  ); 
  port (
    -- clock and synchronous reset 
    clk : in std_logic;
    sync_reset : in std_logic;

    -- enable signals
    wr_en : in std_logic;
    rd_en : in std_logic;

    -- buses (separate read and write ports)
    wr_data : in std_logic_vector(width-1 DOWNTO 0);
    rd_data : out std_logic_vector(width-1 DOWNTO 0);

    -- flags  
    flag_full : out std_logic;
    flag_empty : out std_logic;
    flag_almost_full : out std_logic; -- special feature!
    flag_almost_empty : out std_logic -- special feature!
  );
end fifo;

architecture arch of fifo is
    -- memory element declaration
    -- 'depth' number of locations of 'width' number of bits each
    type fifo_mem_type is array(0 to depth-1) of std_logic_vector(width-1 DOWNTO 0);
    signal fifo_mem : fifo_mem_type := (others=>(others => '0')); -- all locations initilized to 0
    -- indices that point to next location to be written to/read from
    signal wr_index : integer range 0 to depth-1 := 0;
    signal rd_index : integer range 0 to depth-1 := 0;

    -- counter that increments/decrements on write/read respectively.
    signal fifo_counter : integer range -1 to depth + 1 := 0; -- empty fifo has counter = 0

    -- registered flag signals
    signal flag_full_reg, flag_empty_reg : std_logic;

begin
    main_proc:process(clk,sync_reset) is
        begin
            if rising_edge(clk) then
                if sync_reset = '1' then -- sync_reset resets the indices and counter.
                    fifo_counter <= 0;
                    wr_index <= 0;
                    rd_index <= 0;
                else --actual fifo synchronos logic follows

                    -- increments/decrements the counter on write/read
                    if(wr_en = '1' and rd_en = '0') then --using exclusive statements to exclude wrong control logic 
                        fifo_counter <= fifo_counter + 1;
                    elsif(wr_en = '0' and rd_en = '1') then --using exclusive statements to exclude wrong control logic 
                        fifo_counter <= fifo_counter - 1;
                    elsif(wr_en = '1' and rd_en = '1') then --assert invalid signals
                        report "Invalid read or write enable control signals from upstream." severity failure;
                    end if;

                    -- increments the write index if within limits or wraps around
                    if(wr_en = '1' and flag_full_reg = '0') then
                        if(wr_index = depth - 1) then
                            wr_index <= 0;
                            report "Write index full, will overflow" severity warning;
                        else
                            wr_index <= wr_index + 1;
                        end if;
                    end if;

                    -- increments the read index if within limits or wraps around
                    if(rd_en = '1' and flag_empty_reg = '0') then
                        if(rd_index = depth - 1) then
                            rd_index <= 0;
                            report "Read index full, will overflow." severity warning;
                        else
                            rd_index <= rd_index + 1;
                        end if;
                    end if;

                    -- synchronous write construct, register from write bus to next fifo location
                    if(wr_en = '1') then
                        fifo_mem(wr_index) <= wr_data; --the index has to be integer
                    end if;   
                end if; -- end sync reset
            end if; -- end rising clock
        end process;
        
        -- asynchronous read operation on index updated during last clock cycle.
        rd_data <= fifo_mem(rd_index);

        -- combinational logic to update the flags 
        flag_full_reg <= '1'    when fifo_counter > depth-1 else '0';
        flag_empty_reg <= '1'   when fifo_counter = 0       else '0';

        flag_full <= flag_full_reg;     -- full flag is read inside the process 
        flag_empty <= flag_empty_reg;   -- empty flag is read inside the process

        flag_almost_full <= '1'     when fifo_counter > almost_full_threshold   else '0'; -- flag updates in the threshold value + 1
        flag_almost_empty <= '1'    when fifo_counter < almost_empty_threshold  else '0'; -- flag updates in the threshold value + 1 

end arch ; -- arch