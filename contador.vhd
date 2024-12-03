library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
	port( out_su: out unsigned(3 downto 0);
			out_sd: out unsigned(3 downto 0);
			
			out_cu: out unsigned(3 downto 0);
			out_cd: out unsigned(3 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			clr: in std_logic;
	);
	
end contador;

architecture arch of contador is

	component cont_4b
		port(
				rst: in std_logic;
				clk: in std_logic;
				q: out unsigned(3 downto 0);
				en: in std_logic;
				clr: in std_logic;
				ld: in std_logic;
				load: in unsigned(3 downto 0)
		);
	end component;

	signal out_su_s: unsigned(3 downto 0);
	signal out_sd_s: unsigned(3 downto 0);
	
	signal out_cu_s: unsigned(3 downto 0);
	signal out_cd_s: unsigned(3 downto 0);
	
	signal cu_is_top: std_logic;
	
	
	
begin
	
	out_su <= out_su_s;
	out_sd <= out_sd_s;
	
	out_cu <= out_cu_s;
	out_cd <= out_cd_s;
	
	
	cu_is_top <= out_cu_s(3) and not out_cu_s(2) and not out_cu_s(1) and out_cu_s(0);
	cd_is_top <= out_cd_s(3) and not out_cd_s(2) and not out_cd_s(1) and out_cd_s(0);
	su_is_top <= out_su_s(3) and not out_su_s(2) and not out_su_s(1) and out_su_s(0);
	sd_is_top <= not out_sd_s(3) and out_sd_s(2) and not out_sd_s(1) and out_sd_s(0);

	counter_cu: cont_4b port map (rst=>rst, clk=>clk, en=>en, clr=>clr or cu_is_top, q=>out_cu_s, ld=>0, load=>"0000");
	counter_cd: cont_4b port map (rst=>rst, clk=>clk, en=>en and u_is_top, clr=>clr or (cu_is_top and cd_is_top), q=>out_cd_s, ld=>0, load=>"0000");

	
	counter_su: cont_4b port map (rst=>rst, clk=>clk, en=>en and cd_is_top and cu_is_top, clr=>clr or su_is_top, q=>out_su_s, ld=>0, load=>"0000");
	counter_sd: cont_4b port map (rst=>rst, clk=>clk, en=>en and su_is_top, clr=>clr or (su_is_top and sd_is_top), q=>out_sd_s, ld=>0, load=>"0000");

end architecture;