--modulo che esegue il Complemento a due di un numero ad otto bit
--Il complemento a due viene effettuato negando ogni bit e 
--sommando uno al numero così ottenuto
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity Complemento2 is
--riceve in ingresso un numero ad otto bit
--e restituisce il suo complemento a due
	port( 
		a:in std_logic_vector(7 downto 0);
		r: out std_logic_vector	(7 downto 0)--8 bit
		);
end Complemento2;

--architettura

Architecture C2 of Complemento2 is
--inclusione del componente

--inclusione del ripple carry ad otto bit
component RippleCarry8 is
	port( 
		a,b: in std_logic_Vector(7 downto 0);
		cin: in std_logic;
		s: out std_logic_Vector(7 downto 0);
		cout: out std_logic);
end component;

--segnali ausiliari
signal rneg: std_logic_vector(7 downto 0);--vettore che contiene il negato dell'ingresso

signal nshift: std_logic_vector(7 downto 0):="00000001";

--inizio delle operazioni
begin
--negato bit a bit

rneg(0)<=not a(0);
rneg(1)<=not a(1);
rneg(2)<=not a(2);
rneg(3)<=not a(3);
rneg(4)<=not a(4);
rneg(5)<=not a(5);
rneg(6)<=not a(6);
rneg(7)<=not a(7);

--si istanzia il componente
PiuUno: RippleCarry8 port map(rneg,nshift,'0',r);
--il riporto va scartato, quindi non predispongo l'uscita corrispondente

end C2;
