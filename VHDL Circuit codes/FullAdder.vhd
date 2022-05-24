--Full Adder 
--usa un componente Mux

--definizione dell'entita'
Entity FullAdder is
--elenco delle porte e specificazione del loro utilizzo
	port(a,b,cin: in bit;
		cout,s:out bit);
end FullAdder;

--definizione dell'architettura
Architecture FA of FullAdder is
--parte dichiarativa
	--segnali ausiliari per il FA:propagate p
	signal p:bit;
	--si include il componente mux
	--questo instradera' uno solo degli ingressi verso l'uscita, 
	--scegliendo quello il cui valore posizionale, in nbn, corrisponde
	--del selettore
	component Mux is
	--si specificano le porte che utlizza nell'ordine in cui
	--sono state definite
	port(a,b,s: in bit;
			r: out bit);
	end component;
--parte descrittiva
--e' introdotta dal begin
	begin
	--si istanzia il componente che si e' incluso dandogli un nome
	--ingressi:b e cin, uscita: cout, selettore: p
	MX: Mux port map(b,cin,p,cout);
	--propagate
	p <= a xor b;
	--somma s
	s <= p xor cin;
	--riporto in uscita cout

end FA;





