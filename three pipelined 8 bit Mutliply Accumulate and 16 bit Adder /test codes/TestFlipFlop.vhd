--Test utlizzato per verificare il funzionamento del Flip Flop
--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;

--codice per la simulazione
Entity TestFlipFlop is
--questo blocco rimane astratto ai fini della simulazione
end TestFlipFlop;

Architecture SimFF of TestFlipFlop is
--si richiama il componente da utilizzare
	component FlipFlop is
		--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
		port(
			d,clock,clear: in std_logic;
			q: out std_logic
		);
		
	end component;
	
--parte dichiarativa

--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
--la loro associazione verra' effettuata seguendo l'ordine con cui verranno definiti
	signal id,iclear:std_logic; --ingressi
	signal iclock:std_logic:='0';--segnale di clock in ingresso
	signal uq:std_logic; --uscita

--parte descrittiva

begin
	--implementazione del circuito denominato tale
	circuito : FlipFlop port map(id,iclock,iclear,uq);
--process relativo al clock
clock:
	process
		begin
		wait for 50 ns;
		iclock<='0';
		wait for 50 ns;
		iclock<='1';
		wait for 50 ns;
		iclock<='0';
		wait for 50 ns;
		iclock<='1';
		wait for 50 ns;
	end process;

--process relativo al segnale di clear
clear:

	process
		begin
		--prima
		iclear<='1';
		wait for 50 ns;
		--seconda
		iclear<='0';
		wait for 100 ns;
	end process;

--process relativo agli inputs
inputs:
	process
		begin
		--prima
		id<='1';	
		wait for 50 ns;
		id<='0';	
		wait for 50 ns;
		id<='1';
		wait for 50 ns;
	end process;

--si conclude la simulazione
end SimFF;
