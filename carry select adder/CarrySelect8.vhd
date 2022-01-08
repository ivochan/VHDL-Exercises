--Carry Select a 8 bit
--utilizza tre Carry Look Ahead a 4 bit e  5 mux

Entity CarrySelect8 is 
--ingressi A(0:7), B(0:7), cin
--uscite: cout, S(0:7)
	port(
		a,b : in bit_Vector(7 downto 0 );
		cin : in bit;
		s : out bit_Vector(7 downto 0);
		cout : out bit
		);
end CarrySelect8;

Architecture CS8b of CarrySelect8 is

--parte dichiarativa

--inizializzazione dei segnali ausiliari: 

--due vettori ausiliari: uno per conservare la somma calcolata
--con il riporto e l'altro senza riporto		
signal s0,s1 : bit_Vector(3 downto 0);
--riporto pari a zero c0, riporto pari a uno c1,
--primo riporto del CLA che calcola la somma per i bit della parte
--meno significativa cf, ci il riporto intermedio
signal c0,c1,ci : bit;

--inclusione dei componenti CarryLookAhead a 4 bit
component carrylookahead is
--elenco delle porte come nel componente originale 
port( a,b: in bit_Vector(3 downto 0 );
	  cin: in bit;		
	  s: out bit_Vector(3 downto 0 );
	  cout: out bit
	  );
end component;
--inclusione dei componenti del Mux a 2 bit
component Mux is
--elenco delle porte come nel componente originale 
--s selettore, r risultato
port(a,b,s: in bit;
		r: out bit
	);
end component;

--parte descrittiva
--e' introdotta dal begin
begin
	
--descrizione delle funzioni che deve svolgere

--operazione dei Carry Look Ahead

--CLAI "iniziale" somma di bin in posizione da 0 a 3, parte meno significativa:
--riceve, come ingressi, il riporto iniziale cin, il vettore a da cui prende i
--primi 4 bit e il vettore b, con cui fa la stessa cosa; il risultato verra'
--scritto nelle prime quattro celle del vettore risultante s
CLAI : carrylookahead  port map(a(3 downto 0 ),b(3 downto 0 ),cin,s(3 downto 0 ),ci);

--CLA0 somma da  bit in posizione da 4 a 7
--questo si suppone lavori con riporto in ingresso '0'
--c0 e' il suo riporto in uscita,salva la somma in s0
CLA0 : carrylookahead  port map(a(7 downto 4),b(7 downto 4),'0',s0,c0);

--CLA1 somma da bit in posizione da 4 a 7
--questo si suppone lavori con riporto in ingresso '1'
--c1 e' il suo riporto in uscita,salva la somma in s1
CLA1 : carrylookahead port map(a(7 downto 4),b(7 downto 4),'1',s1,c1);

--operazioni dei Mux a due bit
--il selettore di ogni mux sara' il riporto ci ottenuto dal primo carry look ahead CLAI
--la scelta tra s1 e s0 verra' messa in s

M4 : Mux port map(s0(0),s1(0),ci,s(4));
M5 : Mux port map(s0(1),s1(1),ci,s(5));
M6 : Mux port map(s0(2),s1(2),ci,s(6));
M7 : Mux port map(s0(3),s1(3),ci,s(7));
--segue mux che calcola il riporto finale cf
MC :Mux port map(c0,c1,ci,cout);

end CS8b;

