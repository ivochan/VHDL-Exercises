--test del blocchetto Dec
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity TDec is
--questo blocco rimane astratto ai fini della simulazione
end TDec;

Architecture TD of TDec is
--si richiama il componente da utilizzare
component Dec is
--riceve in ingresso tre bit e 
--restituisce un numero in base 
--ai valori stabiliti dalla tabella di Booth
	port(
		i: in std_logic_vector(2 downto 0);
		u: out std_logic_vector(2 downto 0)
	);
--l'uscita in pratica sara' il selettore del mux a cinque ingressi
end component;

--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
signal ii:std_logic_vector(2 downto 0); --ingressi
signal uu:std_logic_vector(2 downto 0); --uscita


--simulazione
begin


	process

		begin
		--inizializzazione degli ingressi
		ii<="000";
		wait for 30 ns;
		ii<="011";
		wait for 30 ns;
		ii<="111";
		wait for 30 ns;
		ii<="100";
		wait for 60 ns;
	
	end process;

--implementazione del circuito
	circuito : Dec port map(ii,uu);

end TD;
