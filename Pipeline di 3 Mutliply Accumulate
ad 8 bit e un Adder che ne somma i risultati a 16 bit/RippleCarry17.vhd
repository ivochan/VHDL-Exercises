--Ripple Carry a 17 bit  

--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity RippleCarry17 is

--ingressi:
--a vettore di 17 bit, b vettore di 17 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit;
--uscite:
--s vettore di 17 bit, e' il risultato della somma tra i due numeri a 17 bit, a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit;

port( 
	a,b: in std_logic_Vector(16 downto 0);
      	cin: in std_logic;	
	clock, clear: in std_logic;
     	s: out std_logic_Vector(16 downto 0);
        cout: out std_logic);
	 
end RippleCarry17;

--definizione dell'architettura

Architecture MyRC17 of RippleCarry17 is

--ingressi: atemp,btemp,cintemp
--uscite: stemp,coutemp
signal atemp,btemp:std_logic_vector(16 downto 0);
signal stemp:std_logic_vector(16 downto 0);--da due numeri a 17 bit si ottiene somma a 17 bit perche' si tiene conto del riporto
signal cintemp:std_logic;
--segnali ausiliari
signal c: std_logic_vector(15 downto 0);--mantiene memoria dei riporti

--si include il FullAdder che eseguira' le somme
component FullAdder is
	port(
		a,b,cin: in std_logic;
		cout,s:out std_logic);
end component;

--si include il Register17
component  Register17 is 
	port(
		id : in std_logic_vector(16 downto 0);
		clock,clear: in std_logic;
		uq : out std_logic_vector(16 downto 0)
	);
end component;

--inclusione del Flip Flop
component FlipFlop is
	port(
		d,clock,clear: in std_logic;
		q: out std_logic
	);
	
end component;

--operazioni dei registri
begin
--SINCRONIZZAZIONE DEGLI INGRESSI

--ARegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--inserendoli nel suo valore di uscita 
ARegister : Register17 port map(a,clock,clear,atemp);

--SBRegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--inserendoli nel suo valor di uscita 
BRegister : Register17 port map(b,clock,clear,btemp);

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

FA8: FullAdder port map(atemp(8),btemp(8),c(7),c(8),s(8));

FA9: FullAdder port map(atemp(9),btemp(9),c(8),c(9),s(9));

FA10: FullAdder port map(atemp(10),btemp(10),c(9),c(10),s(10));

FA11: FullAdder port map(atemp(11),btemp(11),c(10),c(11),s(11));

FA12: FullAdder port map(atemp(12),btemp(12),c(11),c(12),s(12));

FA13: FullAdder port map(atemp(13),btemp(13),c(12),c(13),s(13));

FA14: FullAdder port map(atemp(14),btemp(14),c(13),c(14),s(14));

FA15: FullAdder port map(atemp(15),btemp(15),c(14),c(15),s(15));--sedicesimo bit

FA16: FullAdder port map(atemp(16),btemp(16),c(15),cout,s(16));--diciassettesimo bit


end MyRC17;
