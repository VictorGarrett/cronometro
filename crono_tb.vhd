library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crono_tb is
end crono_tb;

architecture sim of crono_tb is

    -- Component declaration
    component crono
        port(
            out_su_disp: out unsigned(6 downto 0);
            out_sd_disp: out unsigned(6 downto 0);
            out_cu_disp: out unsigned(6 downto 0);
            out_cd_disp: out unsigned(6 downto 0);
            
            out_su_debug: out unsigned(3 downto 0);
            out_sd_debug: out unsigned(3 downto 0);
            out_cu_debug: out unsigned(3 downto 0);
            out_cd_debug: out unsigned(3 downto 0);
            
            clk: in std_logic;
            rst: in std_logic;
            run_btn: in std_logic;
            clr_btn: in std_logic
        );
    end component;

    signal clk       : std_logic := '0';
    signal rst       : std_logic := '1';
    signal run_btn   : std_logic := '1';
    signal clr_btn   : std_logic := '1';
    signal out_su_disp, out_sd_disp, out_cu_disp, out_cd_disp : unsigned(6 downto 0);
    signal out_su_debug, out_sd_debug, out_cu_debug, out_cd_debug : unsigned(3 downto 0);

    constant clk_period : time := 10 ns;

begin

    uut: crono
        port map(
            out_su_disp => out_su_disp,
            out_sd_disp => out_sd_disp,
            out_cu_disp => out_cu_disp,
            out_cd_disp => out_cd_disp,
            
            out_su_debug => out_su_debug,
            out_sd_debug => out_sd_debug,
            out_cu_debug => out_cu_debug,
            out_cd_debug => out_cd_debug,
            
            clk => clk,
            rst => rst,
            run_btn => run_btn,
            clr_btn => clr_btn
        );

    process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    process
    begin
        wait for 100 ns;
        rst <= '0';

		  run_btn <= '1';
        wait for 50 ns;
        run_btn <= '0';
        wait for 10 ns;
        run_btn <= '1';

		  wait for 1000 ns;
		  
        wait for 200 ns;
        clr_btn <= '0';
        wait for 10 ns;
        clr_btn <= '1';

        wait for 100 ns;
        run_btn <= '1';
        wait for 10 ns;
        run_btn <= '0';

        wait for 500 ns;
    end process;

end sim;