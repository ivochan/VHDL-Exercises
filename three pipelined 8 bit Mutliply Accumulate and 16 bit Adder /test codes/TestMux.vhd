--Test utlizzato per verificare il funzionamento del Mux
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity TestMux is
--questo blocco rimane astratto ai fini della simulazione
end TestMux;

Architecture SimMux of TestMux is
--si richiama il componente da utilizzare
component Mux is
--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
	port(
		a,b,s:in std_logic;
		 r:out std_logic);			 
end component;
	
--parte dichiarativa
--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
signal ia,ib,cin:std_logic; --ingressi
signal ur:std_logic; --uscita

--parte descrittiva

begin
--implementazione del circuito denominato tale
	circuito : Mux port map(ia,ib,cin,ur);

	process
	--si instanzia il componente
		begin
		--inizializzazione degli ingressi
		ia<='0';ib<='1';cin<='1';
		--si decide per quanto simulare con questi valori
		wait for 10 ns;
		--si definiscono nuovi valori solo per i segnali che si vogliono cambiare. 
		cin<='0';
		wait for 15 ns;
		
	end process;

--si conclude la simulazione
end SimMux;
