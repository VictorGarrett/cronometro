library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cont_4b is
	port(
			rst: in std_logic;
			clk: in std_logic;
			q: out unsigned(3 downto 0);
			en: in std_logic;
			clr: in std_logic;
			ld: in std_logic;
			load: unsigned(3 downto 0)
	);
end cont_4b;
	
architecture arch of cont_4b is

	signal count: unsigned(3 downto 0);
	
begin

	process(clk, rst)
	begin

		if rst = '1' then
			count <= "0000";
		elsif rising_edge(clk) then
			if clr = '1' then
				count <= "0000";
			else
				if en = '1' then
					if ld = '1' then
						count <= load;
					else
						count <= count+1;
					end if;
				end if;
			end if;
		end if;
	end process;
	q <= count;
end architecture;