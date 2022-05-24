--file di testing per il CarrySelect ad 8 bit con almeno dieci coppie di operanti

--definizione dell'entita' astratta
Entity TestCarrySelect8 is
--entity astratta e percio' vuota
end TestCarrySelect8;

--definizione dell'architettura
Architecture SimCS8b of TestCarrySelect8 is
--si richiama il componente da utilizzare
component CarrySelect8 is
--si elencano le porte definite per questo componente nell'ordine gia' utilizzato
	port(
		a,b : in bit_Vector(7 downto 0);
		cin : in bit;
		s : out bit_Vector(7 downto 0);
		cout : out bit
		);
end component;

--parte dichiarativa

--si definiscono i segnali che si vogliono usare per l'utilizzo del componente
--la loro associazione verra' effettuata seguendo l'ordine con cui verranno definiti
--ingressi
signal ia,ib: bit_Vector(7 downto 0);
signal icin : bit;
--uscite
signal os: bit_Vector(7 downto 0);
signal ocout: bit;

--parte descrittiva
--e' introdotta dal begin

begin

--implementazione del circuito denominato tale(nella dichiarazione del componente)

circuito : CarrySelect8 
	--default:assegnazione posizionale
	port map(ia,ib,icin,os,ocout);
--questo blocco che inizia con il begin usera' l'end dell'architettura alla sua chiusura

	process
	--si instanzia il componente
	begin
	--il begin segue sempre il process

	--e' importante l'ordine con cui si scrivono gli statements
	--si devono assegnare dei valori che i segnali di ingresso devono assumere negli istanti di tempo considerati
	--gli ingressi sono vettori!
	
	--PRIMA COPPIA:inizializzazione a zero
	ia<="00000000";ib<="00000000";
	icin<='1';	--risultato= 0 0000 0001
	wait for 10 ns; 
	
	--SECONDA COPPIA:inizializzazione ad uno
	ia<="11111111";ib<="11111111";
	icin<='0';	--risultato 1 1111 1110
	wait for 15 ns; 

	--TERZA COPPIA
	ia<="00001111";
	icin<='1';	--risultato 1 0000 1111
	wait for 10 ns;

	--QUARTA COPPIA: bit alternati
	ia<="01010101";ib<="10101010";
	icin<='0';	--risultato 0 1111 1111
	wait for 15 ns; 
	
	--QUINTA COPPIA:
	icin<='1';	--risultato 1 0000 0000
	wait for 10 ns;
	
	--SESTA COPPIA
	ia<="10000001";ib<="00001000";
	icin<='0';	--risultato 0 1000 1001
	wait for 15 ns;

	--SETTIMA COPPIA
	ia<="00011000";ib<="00000111";
	icin<='1';	--risultato 0 0010 0000
	wait for 10 ns;
	
	--OTTAVA COPPIA
	ia<="01111111";ib<="00000000";
	icin<='1';	--risultato 0 1000 0000
	wait for 15 ns;
	
	--NONA COPPIA
	ia<="11101010";ib<="01110101";
	icin<='1';	--risultato 1 0110 0000
	wait for 10 ns;
	
	--DECIMA COPPIA
	ia<="00000001";ib<="00000001";
	icin<='1';	--risultato 0 0000 0011
	wait for 15 ns;

	--UNDICESIMA COPPIA
	ia<="10000000";ib<="10000000";
	icin<='0';	--risultato 1 0000 0000
	wait for 10 ns;
	
	
	--si conclude il processo
	end process;

--si conclude la simulazione
end SimCS8b;
