--Test del sommatore dei tre prodotti
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestSomTreProd is
end TestSomTreProd;

Architecture TSTP of TestSomTreProd  is
--inizializzazione dei segnali
--ingressi
signal ia,ib,ic: std_logic_vector(15 downto 0);--ingressi della simulazione
signal icin,ucout:std_logic;
signal us:std_logic_vector(16 downto 0);--risultato della simulazione
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='0';--segnale di clear 


--componente da testare
--riceve in ingresso tre operandi a 16 bit
--cin, riporto in ingresso, che e' nullo;
--uscite:
--s vettore di 16 bit, e' il risultato della somma tra i tre numeri a 16 bit;
--cout, riporto in uscita
component Sommatore3Prod is
	port( 
		a,b,c: in std_logic_Vector(15 downto 0);
	     	cin: in std_logic;	
		clock,clear:in std_logic;
	 	s: out std_logic_Vector(16 downto 0);
	        cout: out std_logic);
	 
end component;



begin

--si scrive il process relativo al segnale di clock
clock:
process 
	begin
	wait for 50 ns;
	iclock <= not iclock;
	wait for 50 ns;
	iclock <= not iclock;
	wait for 50 ns;
	iclock <= not iclock;
	wait for 50 ns;
end process;

--process relativo al segnale di clear
clear:
process
	begin
	iclear<='1';
	wait for 30 ns;
	iclear<= '0';
	wait for 200 ns;
end process;

--process relativo agli ingressi
inputs:
process
	begin
	icin<='0';
	ia<="0000111111111000";
	ib<="1111111110000000";
	ic<="0000000000000000";
	wait for 30 ns;
	icin<='1';
	ia<="1111111111111111";
	ib<="1000000110011111";
	ic<="0111111111111100";
	wait for 30 ns;
	icin<='0';
	ia<="0000111111111000";
	ib<="1111111110000000";
	ic<="0000000000000000";
	wait for 30 ns;
end process;

circuito : Sommatore3Prod port map(ia,ib,ic,icin,iclock,iclear,us,ucout);



end TSTP;