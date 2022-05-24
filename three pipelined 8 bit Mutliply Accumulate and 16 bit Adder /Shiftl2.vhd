--modulo che si occupa di fare lo shift
--verso sinistra, di due posizioni
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--MOLTIPLICAZIONE PER 4
--Da 9 bit a 11 bit
Entity Shiftl2 is
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

end Shiftl2;

--definizione del funzionamento del componente
Architecture MyS2 of Shiftl2 is
	--operazioni: da nove bit ad undici bit
	begin
	
	u(10)<=i(8);
	u(9)<=i(7);
	u(8)<=i(6);
	u(7)<=i(5);
	u(6)<=i(4);
	u(5)<=i(3);
	u(4)<=i(2);
	u(3)<=i(1);
	u(2)<=i(0);
	u(1)<='0';
	u(0)<='0';
	
end MyS2;
