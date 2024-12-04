library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity enable_pulse_generator is
    port(
        clk_in  : in  std_logic; 
        rst     : in  std_logic;  
        enable  : out std_logic   
    );
end enable_pulse_generator;

architecture behavioral of enable_pulse_generator is
    constant COUNT_MAX : unsigned(19 downto 0) := to_unsigned(500_000 - 1, 20);
    signal counter     : unsigned(19 downto 0) := (others => '0');
    signal enable_s  : std_logic := '0';
begin

    process(clk_in, rst)
    begin
        if rst = '1' then
            counter <= (others => '0');
            enable_s <= '0';
        elsif rising_edge(clk_in) then
            if counter = COUNT_MAX then
                counter <= (others => '0');
                enable_s <= '1'; 
            else
                counter <= counter + 1; 
                enable_s <= '0';         
            end if;
        end if;
    end process;

    enable <= enable_reg; 

end behavioral;