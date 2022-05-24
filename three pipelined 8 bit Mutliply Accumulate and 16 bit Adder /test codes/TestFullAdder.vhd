--File di simulazione per verificare il funzionamento del componente Full Adder
--inclusione della libreria
library IEEE;
--inclusione del package di interesse
use IEEE.std_logic_1164.all;
--entita'
Entity TestFullAdder is
--questo blocco rimane astratto ai fini della simulazione
end TestFullAdder;

Architecture SimFA of TestFullAdder is
--si richiama il componente da utilizzare
	component FullAdder is
--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
	port(
		a,b,cin: in std_logic;
	        cout,s:out std_logic);
		  
	end component;
--parte dichiarativa
--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
--la loro associazione verra' effettuata seguendo l'ordine con cui verranno definiti
	signal ia,ib,icin:std_logic; --ingressi
	signal ocout,os:std_logic; --uscite

--parte descrittiva

begin
--implementazione del circuito denominato tale
	circuito : FullAdder 
	--default:assegnazione posizionale
	--assegnazione non posizionale: SINISTRA, nome formale del componente; => DESTRA, nome attuale dell'architettura
	port map(ia,ib,icin,ocout,os);
--questo blocco che inizia con il begin usera' l'end dell'architettura alla sua chiusura

	process
	--si instanzia il componente
	begin
	--segue sempre il process

	--e' importante l'ordine con cui si scrivono gli statements
	--si devono assegnare dei valori che i segnali di ingresso devono assumere negli istanti di tempo considerati
	--t0 = 0 ns
	ia<='0';ib<='1';icin<='1';
	--si decide per quanto simulare con questi valori
	wait for 10 ns;
	--t1 = 10 - t0 = 10 ns
	--si definiscono nuovi valori solo per i segnali che si vogliono cambiare, 
	--non e' necessario riportare quelle che si vuole rimangano invariati
	icin<='0';
	wait for 30 ns; --tempo assoluto
	--t2 = 30 - t1?
	ib<='0';
	wait for 15 ns;
	--t3 = 
	icin<='1';
	--si conclude il processo
	end process;

--si conclude la simulazione
end SimFA;
