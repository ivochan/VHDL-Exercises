--Test utlizzato per verificare il funzionamento del Mux
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity TestMux5i is
--questo blocco rimane astratto ai fini della simulazione
end TestMux5i;

Architecture TM5i of TestMux5i is
--si richiama il componente da utilizzare
component Mux5i9b is
	port(
		 a,b,c,d,e:in std_logic_vector(8 downto 0);
		 sel: in std_logic_vector(2 downto 0);
        	 ris: out std_logic_vector(8 downto 0)
         );	 
end component;

--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
signal ia,ib,ic,id,ie:std_logic_vector(8 downto 0); --ingressi
signal isel:std_logic_vector(2 downto 0);
signal uris:std_logic_vector(8 downto 0); --uscita

--simulazione
begin


	process

		begin
		--inizializzazione degli ingressi
		ia<="000000000";
		ib<="000000001";
		ic<="000000011";
		id<="000000111";
		ie<="000001111";
		--selettore
		isel<="010";
		wait for 30 ns;
		isel<="100";
		wait for 30 ns;
		isel<="110";
		wait for 60 ns;
	
	end process;

--implementazione del circuito
	circuito : Mux5i9b port map(ia,ib,ic,id,ie,isel,uris);

end TM5i;
