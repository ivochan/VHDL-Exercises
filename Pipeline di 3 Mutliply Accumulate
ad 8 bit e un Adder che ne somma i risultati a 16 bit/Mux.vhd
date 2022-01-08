--Multiplexer std_logic
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--questo componente, tra i piu' ingressi ricevuti, in base al valore del selettore,
--ne instradera' uno soltanto verso l'uscita

entity Mux is
--a e b saranno gli ingressi, s il selettore e r il risultato
	port(
		a,b,s: in std_logic;
        	r: out std_logic);
end Mux;

architecture MyMux of Mux is 
--parte dichiarativa di segnali ausiliari
--parte descrittiva
begin
--si definisce la funzione s
r <= ( a and (not s) ) or (b and s);
		
end MyMux;

	
