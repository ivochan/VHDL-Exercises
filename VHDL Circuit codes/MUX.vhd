--implementazione di un Multiplexer
--questo componente, tra i piu' ingressi ricevuti, in base al valore del selettore,
--ne instradera' uno soltanto verso l'uscita
entity Mux is
--elenco delle porte di ingresso e di uscita con specificazione del tipo
--di segnali che utilizzeranno, dove:
--a e b saranno gli ingressi, s il selettore e r il risultato
	port(a,b,s: in bit;
		r: out bit);
end Mux;

architecture MX of Mux is 
--il nome dell'architecture e' fittizio
	--parte dichiarativa di segnali ausiliari
	--parte descrittiva
	begin
	--si definisce la funzione s
	r <= ( a and (not s) ) or (b and s);
end MX;

	
