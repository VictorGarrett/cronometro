library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity crono is
	port( out_su_disp: out unsigned(6 downto 0);
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
			clr: in std_logic
		);
	end component;
	
	component enable_pulse_generator is
		port(
			  clk_in  : in  std_logic; 
			  rst     : in  std_logic;  
			  enable  : out std_logic   
		);
	end component;

	component hex_to_7_seg
		port(
			H: in unsigned(0 to 3);
			Q: out unsigned(0 to 6)
		);
	end component;
	

	signal out_su_s: unsigned(3 downto 0);
	signal out_sd_s: unsigned(3 downto 0);
	signal out_cu_s: unsigned(3 downto 0);
	signal out_cd_s: unsigned(3 downto 0);

	signal is_running: std_logic := '0';
	signal clk_enable: std_logic := '0';
begin
	
	clk_pulse: enable_pulse_generator port map(clk_in=>clk, rst=>rst, enable=>clk_enable)
	
	cont: contador port map(out_su=>out_su_s, out_sd=>out_sd_s, out_cu=>out_cu_s, out_cd=>out_cd_s, clk=>clk, rst=>rst, en=>is_running and clk_enable, clr=>(not clr_btn and not is_running));

	process(clk, run_btn)
	begin

		if rising_edge(clk) then
			if run_btn = '0' then
				is_running <= not is_running;
			end if;
		end if;
	end process;

	conv_su: hex_to_7_seg port map(H=>out_su_s, Q=>out_su_disp);
	conv_sd: hex_to_7_seg port map(H=>out_sd_s, Q=>out_sd_disp);
	conv_cu: hex_to_7_seg port map(H=>out_cu_s, Q=>out_cu_disp);
	conv_cd: hex_to_7_seg port map(H=>out_cd_s, Q=>out_cd_disp);
	
	out_su_debug <= out_su_s;
	out_sd_debug <= out_sd_s;
	out_cu_debug <= out_cu_s;
	out_cd_debug <= out_cd_s;
	

end architecture;