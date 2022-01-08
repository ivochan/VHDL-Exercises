--modulo che si occupa di fare lo shift
--verso sinistra, di quattro posizioni
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--MOLTIPLICAZIONE 
--Da 9 bit a 13 bit
Entity Shiftl4 is
--riceve in ingresso un numero a 9 bit
--restituendo in uscita un numero a 13 bit
--che presenta, nelle sua celle meno significative
--(quelle piu' a destra) degli zeri in piu'
--per occupare le caselle rimasta vuota dopo
--l'operazione di shifting

	port(
		i : in std_logic_vector(8 downto 0);--9 bit in ingresso
		u : out std_logic_vector(12 downto 0)--13 bit in uscita
		);

end Shiftl4;

--definizione del funzionamento del componente
Architecture MyS4 of Shiftl4 is
	--operazioni: da nove bit a tredici bit
	begin
	
	u(12)<=i(8);
	u(11)<=i(7);
	u(10)<=i(6);
	u(9)<=i(5);
	u(8)<=i(4);
	u(7)<=i(3);
	u(6)<=i(2);
	u(5)<=i(1);
	u(4)<=i(0);
	u(3)<='0';
	u(2)<='0';
	u(1)<='0';
	u(0)<='0';
	
end MyS4;
