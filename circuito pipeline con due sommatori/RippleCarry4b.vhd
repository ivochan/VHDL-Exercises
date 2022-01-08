--Ripple Carry a 4 bit

--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity RippleCarry4b is

--ingressi:
--a vettore di 4 bit, b vettore di 4 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit (e' il riporto iniziale cin = g0 = a0 and b0);
--uscite:
--s vettore di 4 bit, e' il risultato della somma tra i due numeri a 4 bit a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit (e' il riporto finale c3, 
--		infatti in tutto i riporti sono cin -esterno-, c0, c1, c2, c3 da calcolare );

port( a,b: in std_logic_Vector(3 downto 0);
      cin: in std_logic;	
      s: out std_logic_Vector(3 downto 0);
      cout: out std_logic);
	 
end RippleCarry4b;

--definizione dell'architettura

Architecture MyRC of RippleCarry4b is

signal c: std_logic_vector(2 downto 0);

--si include il FullAdder che eseguira' le somme
component FullAdder is
	port(a,b,cin: in std_logic;
		cout,s:out std_logic);
end component;
--parte dichiarativa

--Operazioni del RC
begin

FA0: FullAdder port map(a(0),b(0),cin,c(0),s(0));

FA1: FullAdder port map(a(1),b(1),c(0),c(1),s(1));

FA2: FullAdder port map(a(2),b(2),c(1),c(2),s(2));

FA3: FullAdder port map(a(3),b(3),c(2),cout,s(3));



end MyRC;
