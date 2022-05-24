--Multiplexer std_logic a cinque ingressi a nove bit
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--questo componente, tra i 5 ingressi ricevuti, in base al valore del selettore,
--ne instradera' uno soltanto verso l'uscita
--lavora con ingressi a 9 bit, restituendo, in uscita un risultato a nove bit

entity Mux5i9b is
	port(
		 a,b,c,d,e:in std_logic_vector(8 downto 0);
		 sel: in std_logic_vector(2 downto 0);
        	 ris: out std_logic_vector(8 downto 0)
         );
end Mux5i9b;

architecture MyMux of Mux5i9b is 
	--operazioni del mux a cinque ingressi
	--controlli sul valore del selettore a tre ingressi
	begin
		with sel select
			ris <=
				--sel=0
				a when "000",
				--sel=1
				b when "001",
				--sel=2
				c when "010",
				--sel=3
				d when "011",
				--sel=4
				e when "100",
			"XXXXXXXXX" when others;--altrimenti, per qualsiasi altro valore rimanente di sel (8 casi possibili)
		
		--fine blocco

	
--si sceglie la seguente notazione:
--a come "00000000";
--b come "moltiplicatore";
--c come "- moltiplicatore";
--d come "2 per moltiplicatore";
--e come "-2 per moltiplicatore";			
end MyMux;

	
