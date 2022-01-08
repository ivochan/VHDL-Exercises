--Test del componente utilizzato per lo shift verso sinistra
--di due posizioni
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;

Entity TShift2 is
end TShift2;

--architettura
Architecture TS2 of TShift2 is
--inclusione del componente da testare
component Shiftl2 is
--riceve in ingresso un numero a 9 bit
--restituendo in uscita un numero a 11 bit
--che presenta, nelle sua celle meno significative
--(quelle piu' a destra) degli zeri in piu'
--per occupare le caselle rimasta vuota dopo
--l'operazione di shifting

	port(
		i : in std_logic_vector(8 downto 0);--9 bit in ingresso
		u : out std_logic_vector(10 downto 0)--11 bit in uscita
		);
end component;

--si inizializzano i valori che si vuole assumano i segnali

--segnali usati
signal ia:std_logic_vector(8 downto 0);
signal uu :std_logic_vector(10 downto 0);
--avvio
begin
--si scrive il process relativo agli ingressi
inputs:
process
	begin
	ia<="111111111";
	wait for 30 ns;
	ia<="111111110";
	wait for 30 ns;
	ia<="000111000";
	wait for 60 ns;
end process;

--simulazione

shift: Shiftl2 port map(ia,uu);

end TS2;
