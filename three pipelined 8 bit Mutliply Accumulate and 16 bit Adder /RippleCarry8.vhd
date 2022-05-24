--Ripple Carry ad otto bit

--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity RippleCarry8 is

--ingressi:
--a vettore di 8 bit, b vettore di 8 bit;

--uscite:
--s vettore di 9 bit, e' il risultato della somma tra i due numeri a 8 bit a e b;
--cout, riporto in uscita dal ripple carry
	port( 
		a,b: in std_logic_Vector(7 downto 0);
		cin: in std_logic;
     		s: out std_logic_Vector(7 downto 0);
      		cout: out std_logic);
	 
end RippleCarry8;

--definizione dell'architettura

Architecture MyRC8 of RippleCarry8 is

--segnali ausiliari
signal c: std_logic_vector(6 downto 0);--mantiene memoria dei riporti

--si include il FullAdder che eseguira' le somme
component FullAdder is
--elenco delle porte e specificazione del loro utilizzo
	port(
		a,b,cin: in std_logic;
	        cout,s:out std_logic);
		  
end component;


begin

--Operazioni del RC


FA0: FullAdder port map(a(0),b(0),cin,c(0),s(0));

FA1: FullAdder port map(a(1),b(1),c(0),c(1),s(1));

FA2: FullAdder port map(a(2),b(2),c(1),c(2),s(2));

FA3: FullAdder port map(a(3),b(3),c(2),c(3),s(3));

FA4: FullAdder port map(a(4),b(4),c(3),c(4),s(4));

FA5: FullAdder port map(a(5),b(5),c(4),c(5),s(5));

FA6: FullAdder port map(a(6),b(6),c(5),c(6),s(6));

FA7: FullAdder port map(a(7),b(7),c(6),cout,s(7));


end MyRC8;
