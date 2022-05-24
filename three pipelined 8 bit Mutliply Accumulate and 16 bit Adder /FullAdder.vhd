--Full Adder std_logic
--usa un componente Mux
--inclusione della libreria
library IEEE;
--inclusione del package di interesse
use IEEE.std_logic_1164.all;

--definizione dell'entita'
Entity FullAdder is
--elenco delle porte e specificazione del loro utilizzo
	port(
		a,b,cin: in std_logic;
	        cout,s:out std_logic);
		  
end FullAdder;

--definizione dell'architettura
Architecture FA of FullAdder is
--parte dichiarativa
--segnali ausiliari per il FA:propagate p
signal p:std_logic;
--si include il componente mux
--questo instradera' uno solo degli ingressi verso l'uscita, 
--scegliendo quello il cui valore posizionale, in nbn, corrisponde
--del selettore
component Mux is
--si specificano le porte che utlizza nell'ordine in cui
--sono state definite
	port(
		a,b,s: in std_logic;
        	r: out std_logic);
end component;
--parte descrittiva
begin
--si istanzia il componente che si e' incluso dandogli un nome
--ingressi:b e cin, uscita: cout, selettore: p
MX: Mux port map(b,cin,p,cout);
--p
p <= a xor b;
--somma s
s <= p xor cin;
--riporto in uscita cout

end FA;





