library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hex_to_7_seg is
    port(
        H: in unsigned(3 downto 0);
        Q: out unsigned(6 downto 0)
    );
end hex_to_7_seg;

architecture hex_to_7_seg_arch of hex_to_7_seg is
begin
    -- Lógica corrigida para LEDs ativos em nível baixo
    Q(0) <= NOT ((NOT H(3) AND NOT H(2) AND NOT H(1) AND H(0)) OR 
                 (NOT H(3) AND H(2) AND NOT H(1) AND NOT H(0)) OR 
                 (H(3) AND H(2) AND NOT H(1) AND H(0)) OR 
                 (H(3) AND NOT H(2) AND H(1) AND H(0)));
                 
    Q(1) <= NOT ((H(3) AND H(1) AND H(0)) OR 
                 (H(2) AND H(1) AND NOT H(0)) OR 
                 (H(3) AND H(2) AND NOT H(0)) OR 
                 (NOT H(3) AND H(2) AND NOT H(1) AND H(0)));
                 
    Q(2) <= NOT ((H(3) AND H(2) AND H(1)) OR 
                 (H(3) AND H(2) AND NOT H(0)) OR 
                 (NOT H(3) AND NOT H(2) AND H(1) AND NOT H(0)));
                 
    Q(3) <= NOT ((H(2) AND H(1) AND H(0)) OR 
                 (NOT H(3) AND H(2) AND NOT H(1) AND NOT H(0)) OR 
                 (H(3) AND H(2) AND H(1) AND H(0)) OR 
                 (NOT H(3) AND NOT H(2) AND NOT H(1) AND H(0)) OR 
                 (H(3) AND NOT H(2) AND H(1) AND NOT H(0)));
                 
    Q(4) <= NOT ((NOT H(3) AND H(0)) OR 
                 (NOT H(2) AND NOT H(1) AND H(0)) OR 
                 (NOT H(3) AND H(2) AND NOT H(1)));
                 
    Q(5) <= NOT ((H(3) AND H(2) AND NOT H(1) AND H(0)) OR 
                 (NOT H(3) AND NOT H(2) AND H(1)) OR 
                 (NOT H(3) AND NOT H(2) AND H(0)) OR 
                 (NOT H(3) AND H(1) AND H(0)));
                 
    Q(6) <= NOT ((NOT H(3) AND NOT H(2) AND NOT H(1)) OR 
                 (NOT H(3) AND H(2) AND H(1) AND H(0)) OR 
                 (H(3) AND H(2) AND NOT H(1) AND NOT H(0)));
end hex_to_7_seg_arch;