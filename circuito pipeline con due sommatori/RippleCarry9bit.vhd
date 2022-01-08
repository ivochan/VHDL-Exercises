--Ripple Carry a nove bit

--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity RippleCarry9bit is

--ingressi:
--a vettore di 9 bit, b vettore di 9 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit (e' il riporto iniziale cin = g0 = a0 and b0);
--uscite:
--s vettore di 9 bit, e' il risultato della somma tra i due numeri a 9 bit a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit (e' il riporto finale c3, 
--		infatti in tutto i riporti sono cin -esterno-, c0, c1, c2, c3 da calcolare );

port( 
	a,b: in std_logic_Vector(8 downto 0);
      	cin: in std_logic;	
	clock, clear: in std_logic;
     	 s: out std_logic_Vector(8 downto 0);
      	cout: out std_logic);
	 
end RippleCarry9bit;

--definizione dell'architettura

Architecture MyRC9 of RippleCarry9bit is

--ingressi: atemp,btemp,cintemp
--uscite: stemp,coutemp
signal atemp,btemp:std_logic_vector(8 downto 0);
signal cintemp:std_logic;
--segnali ausiliari
signal c: std_logic_vector(7 downto 0);--mantiene memoria dei riporti

--si include il FullAdder che eseguira' le somme
component FullAdder is
	port(a,b,cin: in std_logic;
		cout,s:out std_logic);
end component;

--si include il Register9
component Register9 is
	port(d : in std_logic_vector(8 downto 0);
		clock,clear: in std_logic;
		 q : out std_logic_vector(8 downto 0)
	);
end component;

--inclusione del Flip Flop
component FlipFlop is

	port(d,clock,clear: in std_logic;
			 q: out std_logic
	);
	
end component;

--operazioni dei registri
begin
--SINCRONIZZAZIONE DEGLI INGRESSI

--ARegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--presi, inserendoli nel suo valore di uscita 
ARegister : Register9 port map(a,clock,clear,atemp);

--BRegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--presi, inserendoli nel suo valore di uscita 
BRegister : Register9 port map(b,clock,clear,btemp);

--CinFlipFlop e' il componente che immagazzina il valore del riporto iniziale cin, rendendolo
--disponibile come stato della sua uscita 
CinFlipFlop : FlipFlop port map(cin,clock,clear,cintemp);
--parte dichiarativa

--Operazioni del RC


FA0: FullAdder port map(atemp(0),btemp(0),cintemp,c(0),s(0));

FA1: FullAdder port map(atemp(1),btemp(1),c(0),c(1),s(1));

FA2: FullAdder port map(atemp(2),btemp(2),c(1),c(2),s(2));

FA3: FullAdder port map(atemp(3),btemp(3),c(2),c(3),s(3));

FA4: FullAdder port map(atemp(4),btemp(4),c(3),c(4),s(4));

FA5: FullAdder port map(atemp(5),btemp(5),c(4),c(5),s(5));

FA6: FullAdder port map(atemp(6),btemp(6),c(5),c(6),s(6));

FA7: FullAdder port map(atemp(7),btemp(7),c(6),c(7),s(7));

FA8: FullAdder port map(atemp(8),btemp(8),c(7),cout,s(8));



end MyRC9;
