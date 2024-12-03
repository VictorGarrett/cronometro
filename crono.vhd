library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crono is
	port(   out_su_disp: out unsigned(6 downto 0);
			out_sd_disp: out unsigned(6 downto 0);
			
			out_cu_disp: out unsigned(6 downto 0);
			out_cd_disp: out unsigned(6 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			run_btn: in std_logic;
			clr_btn: in std_logic
	);
	
end crono;

architecture arch of crono is

	component contador
		port(
			out_su: out unsigned(3 downto 0);
			out_sd: out unsigned(3 downto 0);
			
			out_cu: out unsigned(3 downto 0);
			out_cd: out unsigned(3 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			clr: in std_logic;
		);
	end component;

	component hex_to_7_seg
		port(
			hex_in: in unsigned(3 downto 0);
			7_seg_out: out unsigned(6 downto 0);
		);
	end component;
	

	signal out_su_s: unsigned(3 downto 0);
	signal out_sd_s: unsigned(3 downto 0);
	signal out_cu_s: unsigned(3 downto 0);
	signal out_cd_s: unsigned(3 downto 0);

	signal is_running: std_logic;
begin
	
	cont: port map contador(out_su=>out_su_s, out_sd=>out_sd_s, out_cu=>out_cu_s, out_cd=>out_cd_s, clk=>clk, rst=>rst, en=>is_running, clr=>(clr_btn and not is_running))

	process(clk, run_btn)
	begin
		if rising_edge(clk)
			if run_btn = 0
				is_running <= not is_running;
			end if;
		end if;
	end process;

	conv_su: port map hex_to_7_seg(hex_in=>out_su_s, 7_seg_out=>out_su_disp)
	conv_sd: port map hex_to_7_seg(hex_in=>out_sd_s, 7_seg_out=>out_sd_disp)
	conv_cu: port map hex_to_7_seg(hex_in=>out_cu_s, 7_seg_out=>out_cu_disp)
	conv_cd: port map hex_to_7_seg(hex_in=>out_cd_s, 7_seg_out=>out_cd_disp)

end architecture;