--Test Adder15
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test
Entity TestAdder15 is
end TestAdder15;

Architecture TA15 of TestAdder15 is
--inizializzazione dei segnali
--ingressi
signal p1,p2,p3,p4: std_logic_vector(14 downto 0);--ingressi della simulazione
signal prod:std_logic_vector(15 downto 0);--risultato della simulazione

--componente da testare
component Adder15 is
--riceve i prodotti parziali gia' resi a 15 bit
--e li somma tra di loro, dando in output
--il risultato effettivo del prodotto tra i due operandi
--iniziali ad otto bit
	port(
		 prodp1,prodp2,prodp3,prodp4: in std_logic_vector(14 downto 0);
		 prodtot: out std_logic_vector(15 downto 0)
	);
end component;

begin

inputs:
process
--questo componente e' predisposto a valorare con numeri che sono stati
--shiftati essendo un modulo interno del moltiplicatore
--quindi, sapendo che dal primo ripple carry che utilizza non si sarebbe generato riporto,ù
--l'adder15 non e' costruito per gestire questo caso
--si forniscono,come ingressi per il test, i numeri piu' alti, in calore logico, 
--che questo componente puo' ricevere

	begin
	p1<="000000111111111";
	p2<="000011111111100";
	p3<="001111111110000";
	p4<="111111111000000";
	wait for 60 ns;
end process;

--simulazione
ADD: Adder15 port map (p1,p2,p3,p4,prod);

end TA15;
