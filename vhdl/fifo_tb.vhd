library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_tb is
  generic(
    this_width : integer := 32
  );
end fifo_tb;

architecture arch of fifo_tb is
    constant t : time := 5 ns; --clock time period of 5 ns
    signal width : integer := 32;

    signal clk : std_logic;
    signal reset : std_logic := '1';
    signal wr_en : std_logic;
    signal rd_en : std_logic := '0';    
    signal wr_data : std_logic_vector(this_width-1 DOWNTO 0);
    signal rd_data : std_logic_vector(this_width-1 DOWNTO 0);
    signal flag_full : std_logic;
    signal flag_empty : std_logic;
    signal flag_almost_full : std_logic; 
    signal flag_almost_empty : std_logic; 

    signal count : unsigned(31 DOWNTO 0) := (others => '0'); 

    component fifo
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
    end component;
    

begin
    UUT:fifo
    generic map(
        width => 32,
        depth => 32,
        almost_full_threshold => 24, 
        almost_empty_threshold => 8 
    )
    port map(
        clk => clk,
        sync_reset => reset,
        wr_en => wr_en,
        rd_en => rd_en,
        wr_data => wr_data,
        rd_data => rd_data,
        flag_full => flag_full,
        flag_empty => flag_empty,
        flag_almost_full => flag_almost_full,
        flag_almost_empty => flag_almost_empty
    );

    reset <= '1', '0' after 5 ns;

    clk_proc:process is
        begin
            clk <= '1';
            wait for t/2;
            clk <= '0';
            wait for t/2;
        end process;

        -- counter assigned to write data bus
        wr_data <= std_logic_vector(count);

    main_proc:process is
        begin
            wait until reset = '0';
            wait until clk = '1';
            wr_en <= '1';
            
            report "Writing begins...";

            -- write an incrementing value to all 32 locations 
            for i in 1 to 32 loop
                count <= count + 1;
                wait until clk = '1';
                report "Value: "& integer'image(to_integer(unsigned(wr_data))) & " written at index: " & integer'image(i-1);  
            end loop;

            -- reading all 32 locations 
            wr_en <= '0';
            rd_en <= '1';
           
            report "";
            report "Writing ends, Reading begins...";
            report "";

            -- reading locations and verifying by assert statements    
            for i in 1 to 32 loop
                wait until clk = '1';
                report "Value: "& integer'image(to_integer(unsigned(rd_data))) & " read from index: " & integer'image(i-1);
                count <= count - 1;
                assert rd_data = std_logic_vector(33-count) report "Mismatch" severity warning;
            end loop;

            rd_en <= '0';

            report "";
            report "Testbench ends.";    

            wait; -- wait indefinitely     
        end process;


    
    
    


end arch ; -- arch