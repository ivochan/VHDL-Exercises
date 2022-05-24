--file di testing utlizzato per verificare il funzionamento del Mux
Entity TestMux is
--questo blocco rimane astratto ai fini della simulazione
end TestMux;

Architecture SimMux of TestMux is
--si richiama il componente da utilizzare
	component Mux is
--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
	port(a,b,s:in bit;
		r:out bit);
	end component;
--parte dichiarativa
--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
--la loro associazione verra' effettuata seguendo l'ordine con cui verranno definiti
	signal ia,ib,cin:bit; --ingressi
	signal ur:bit; --uscita

--parte descrittiva

begin
--implementazione del circuito denominato tale
	circuito : Mux 
	--default:assegnazione posizionale
	--assegnazione non posizionale: SINISTRA, nome formale del componente; => DESTRA, nome attuale dell'architettura
	port map(ia,ib,cin,ur);
--questo blocco che inizia con il begin usera' l'end dell'architettura alla sua chiusura

	process
	--si instanzia il componente
	begin
	--segue sempre il process

	--e' importante l'ordine con cui si scrivono gli statements
	--si devono assegnare dei valori che i segnali di ingresso devono assumere negli istanti di tempo considerati
	--t0 = 0 ns
	ia<='0';ib<='1';cin<='1';
	--si decide per quanto simulare con questi valori
	wait for 10 ns;
	--t1 = 10 ns
	--si definiscono nuovi valori solo per i segnali che si vogliono cambiare, 
	--non e' necessario riportare quelle che si vuole rimangano invariati
	cin<='0';
	wait for 15 ns; --tempo assoluto
	--si conclude il processo
	end process;

--si conclude la simulazione
end SimMux;