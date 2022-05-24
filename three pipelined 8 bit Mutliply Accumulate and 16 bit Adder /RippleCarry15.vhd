--Ripple Carry a 15 bit  
--non sequenziale( non sincronizza quindi non serve il clock)
--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity RippleCarry15 is

--ingressi:
--a vettore di 15 bit, b vettore di 15 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit;
--uscite:
--s vettore di 15 bit, e' il risultato della somma tra i due numeri a 15 bit, a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit;

port( 
	 a,b: in std_logic_Vector(14 downto 0);
      	 cin: in std_logic;	
     	 s: out std_logic_Vector(14 downto 0);--15 bit
         cout: out std_logic);
	 
end RippleCarry15;

--definizione dell'architettura

Architecture MyRC15 of RippleCarry15 is

--segnali ausiliari
signal c: std_logic_vector(14 downto 0);--mantiene memoria dei riporti

--si include il FullAdder che eseguira' le somme
component FullAdder is
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

FA7: FullAdder port map(a(7),b(7),c(6),c(7),s(7));

FA8: FullAdder port map(a(8),b(8),c(7),c(8),s(8));

FA9: FullAdder port map(a(9),b(9),c(8),c(9),s(9));

FA10: FullAdder port map(a(10),b(10),c(9),c(10),s(10));

FA11: FullAdder port map(a(11),b(11),c(10),c(11),s(11));

FA12: FullAdder port map(a(12),b(12),c(11),c(12),s(12));

FA13: FullAdder port map(a(13),b(13),c(12),c(13),s(13));

FA14: FullAdder port map(a(14),b(14),c(13),cout,s(14));



end MyRC15;
