library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
	port( out_u: out unsigned(3 downto 0);
			out_d: out unsigned(3 downto 0);
			
			load_u: in unsigned(3 downto 0);
			load_d: in unsigned(3 downto 0);
			
			clk: in std_logic;
			rst: in std_logic;
			en: in std_logic;
			clr: in std_logic;
			ld: in std_logic
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

	signal out_u_s: unsigned(3 downto 0);
	signal out_d_s: unsigned(3 downto 0);
	
	signal u_is_top: std_logic;
	signal internal_ld: std_logic;

	signal internal_load_u: unsigned(3 downto 0);
	signal internal_load_d: unsigned(3 downto 0);
	
	
	
begin
	
	
	out_u <= out_u_s;
	out_d <= out_d_s;
	
	internal_load_u <= "0010" when ld = '0' else load_u;
	internal_load_d <= "0001" when ld = '0' else load_d;
	
	internal_ld <=  out_u_s(3) and not out_u_s(2) and not out_u_s(1) and not out_u_s(0) and
						 not out_d_s(3) and out_d_s(2) and out_d_s(1) and not out_d_s(0);
	
	u_is_top <= out_u_s(3) and not out_u_s(2) and not out_u_s(1) and out_u_s(0);

	counter_u: cont_4b port map (rst=>rst, clk=>clk, en=>en, clr=>clr or u_is_top, q=>out_u_s, ld=>ld or internal_ld, load=>internal_load_u);
	counter_d: cont_4b port map (rst=>rst, clk=>clk, en=>en and (u_is_top or internal_ld or ld), clr=>clr, q=>out_d_s, ld=>ld or internal_ld, load=>internal_load_d);


end architecture;