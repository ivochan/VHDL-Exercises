--Codice del Carry Look Ahead a 4 bit


--definizione dell'entita'
Entity carrylookahead is
--elenco delle porte e specificazione del loro utilizzo
--ingressi:
--a vettore di 4 bit, b vettore di 4 bit;
--cin, riporto in ingresso al carry look ahead, di tipo bit (e' il riporto iniziale cin = g0 = a0 and b0);
--uscite:
--s vettore di 4 bit, e' il risultato della somma tra i due numeri a 4 bit a e b;
--cout, riporto in uscita dal carry look ahead, di tipo bit (e' il riporto finale c3, 
--		infatti in tutto i riporti sono cin -esterno-, c0, c1, c2, c3 da calcolare );

port( a,b: in bit_Vector(3 downto 0);
	  cin: in bit;		
	  s: out bit_Vector(3 downto 0);
	  cout: out bit);
	 
end carrylookahead;

--definizione dell'architettura

Architecture CarryLookAhead4bit of carrylookahead is
--parte dichiarativa

--inizializzazione dei segnali ausiliari:
--propagate p, vettore di 4 bit, da p0=(a0 xor b0) a p3=(a3 xor b3);
--generate g, vettore di 4 bit, da g0=(a0 and b0) a g3=(a3 and b3);
--carry c, vettore di 3 bit,essendo poi cout l'ultimo riporto da calcolare non mi serve un vettore di 4 celle ma di tre
--somma s, vettore di 4 bit, da s0 a s3;

signal p,g: bit_vector(3 downto 0);
signal c : bit_vector(3 downto 0);


--parte descrittiva
--e' introdotta dal begin
	begin
	
--descrizione delle funzioni che deve svolgere

--generate g = a and b
	g(0) <= a(0) and b(0);
	g(1) <= a(1) and b(1);
	g(2) <= a(2) and b(2);
	g(3) <= a(3) and b(3);
--propagate p = a xor b;
	p(0) <= a(0) xor b(0);
	p(1) <= a(1) xor b(1);
	p(2) <= a(2) xor b(2);
	p(3) <= a(3) xor b(3);

--carry  c(i-esimo) = (c(i-esimo-1) and p(i-esimo-1) or g(i-esimo-1)
	
	--c(0) = cin, perche' e' quello iniziale
	c(0) <= cin;

	--c(1) = (g(0) or (c(0) and p(0))) cioe' si calcola con tutti i segnali precendenti
	c(1) <= (g(0) or (c(0) and p(0)));

	--c(2)=(g(1) or(c(1) and p(1))
	c(2) <= (g(1) or((g(0) or (c(0) and p(0))) and p(1)));

	--c(3) = (g(2) or (c(2) and p(2)))
	c(3) <= (g(2) or ( (g(1) or((g(0) or (c(0) and p(0))) and p(1))) and p(2)));

	--c(4) = (g(3) or (c(3) and p(3))) ; cioe' cout
	cout <= (g(3) or ( (g(2) or ( (g(1) or((g(0) or (c(0) and p(0))) and p(1))) and p(2))) and p(3))) ;
	
--somma s(i-esima) = p(i-esimo) xor c(i-esimo-1)
	s(0) <= p(0) xor c(0);
	s(1) <= p(1) xor c(1);
	s(2) <= p(2) xor c(2);
	s(3) <= p(3) xor c(3);
	
	
end CarryLookAhead4bit;
