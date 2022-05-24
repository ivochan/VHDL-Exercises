--modulo che si occupa di fare lo shift
--verso sinistra, di una sola posizione
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--MOLTIPLICAZIONE PER 2
--Da 8 bit a 9 bit
Entity Shiftl1 is
--riceve in ingresso un numero ad otto bit
--restituendo in uscita un numero a nove bit
--che presenta, nella sua cella meno significativa
--(quella piu' a destra) uno zero in piu'
--per occupare la casella rimasta vuota dopo
--l'operazione di shifting

	port(
		i : in std_logic_vector(7 downto 0);
		u : out std_logic_vector(8 downto 0)
		);

end Shiftl1;

--definizione del funzionamento del componente
Architecture MyS1 of Shiftl1 is
	--operazioni: da otto bit a nove bit
	begin
	
	u(8)<=i(7);
	u(7)<=i(6);
	u(6)<=i(5);
	u(5)<=i(4);
	u(4)<=i(3);
	u(3)<=i(2);
	u(2)<=i(1);
	u(1)<=i(0);
	u(0)<='0';

end MyS1;
