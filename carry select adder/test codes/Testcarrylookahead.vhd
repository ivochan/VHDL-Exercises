--file di testing per il funzionamento del Carry Look Ahead a 4 bit strutturato in maniera esplicita

--definizione dell'entita' astratta
Entity Testcarrylookahead is
--entity astratta e percio' vuota
end Testcarrylookahead;

--definizione dell'architettura
Architecture Simcla of Testcarrylookahead is

--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
--la loro associazione verra' effettuata seguendo l'ordine con cui verranno definiti
--ingressi
signal a,b: bit_Vector(3 downto 0);
signal cin : bit;
--uscite
signal s: bit_Vector(3 downto 0);
signal cout: bit;

--si richiama il componente da utilizzare
component carrylookahead is

--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
	port( a,b: in bit_Vector(3 downto 0);
		cin: in bit;		
		s: out bit_Vector(3 downto 0);
		cout: out bit); 
end component;
--parte dichiarativa



--parte descrittiva
--e' introdotta dal begin

begin

--implementazione del circuito denominato tale(nella dichiarazione del componente)
	
--questo blocco che inizia con il begin usera' l'end dell'architettura alla sua chiusura

	process
	--si instanzia il componente
	begin
	--il begin segue sempre il process

	--e' importante l'ordine con cui si scrivono gli statements
	--si devono assegnare dei valori che i segnali di ingresso devono assumere negli istanti di tempo considerati
	--gli ingressi sono vettori!
	--ASSEGNAZIONE
	
	--PRIMA COPPIA
	a<="0101";b<="1010";cin<='1';
	--t0 = 0 ns
	--si decide per quanto simulare con questi valori
	wait for 10 ns;
	--t1 = 10 - t0 = 10 ns
	--si definiscono nuovi valori solo per i segnali che si vogliono cambiare, 
	--non e' necessario riportare quelle che si vuole rimangano invariati
	
	--SECONDA COPPIA	
	a<="1000";b<="0001";
	cin<='1';
	wait for 15 ns;

	--TERZA COPPIA
	a<="1001";
	cin<='0';
	--se non specifico il tempo anche qui non considera questa coppia
	--percio'
	wait for 30 ns;

	--si conclude il processo
	end process;

	simulazione : carrylookahead 
	--default:assegnazione posizionale
	port map(a,b,cin,s,cout);

--si conclude la simulazione
--si chiude con "end seguito dal nome dato all'architettura
end Simcla;
