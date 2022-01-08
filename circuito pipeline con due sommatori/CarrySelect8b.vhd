--Carry Select a 8 bit std_logic

--si importa la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--Questo componente utilizza tre Carry Look Ahead a 4 bit e  5 mux

Entity CarrySelect8b is 
--ingressi A(0:7), B(0:7), cin, clock, clear
--uscite: cout, S(0:8)
	port(
		a,b : in std_logic_Vector(7 downto 0 );
		cin, clock, clear : in std_logic;
		  s : out std_logic_Vector(7 downto 0);
		cout: out std_logic
		);
end CarrySelect8b;
--stesura dell'architettura

Architecture CS8b of CarrySelect8b is

--parte dichiarativa

--MODIFICHE EFFETTUATE RISPETTO AL MODULO CS USATO NEL PRIMO PROGETTO
--bisogna modificare il codice tentendo conte dei segnali intermedi
--che si devono utilizzare per creare un tramite tra il registro associato
--ad A denominato atemp , il registro associato a B denominato btemp
--ed il registro associato ad S denominato stemp.
--Inoltre, serviranno due flip flop in cui salvare il risporto iniziale
--CIN ed il riporto finale COUT, i cui stati di uscita saranno
--denominati, rispettivamente, cintemp e coutemp.

--INCLUSIONE COMPONENTI

--inclusione del RippleCarry a 4 bit
component RippleCarry4b is

	port( a,b: in std_logic_Vector(3 downto 0);
     		 cin: in std_logic;	
    		  s: out std_logic_Vector(3 downto 0);
     		cout: out std_logic);

end component;

--inclusione del Mux 
component Mux is
--s selettore, r risultato
	port(a,b,s: in std_logic;
		 r: out std_logic
	);
end component;

--inclusione del registro ad 8 
component Register8 is

	port(d : in std_logic_vector(7 downto 0);
		 clock,clear: in std_logic;
		 q : out std_logic_vector(7 downto 0)
	);
end component;

--inclusione del Flip Flop
component FlipFlop is

	port(d,clock,clear: in std_logic;
			 q: out std_logic
	);
	
end component;

--inclusione del registro ad 9
component Register9 is
	port(d : in std_logic_vector(8 downto 0);
		clock,clear: in std_logic;
		 q : out std_logic_vector(8 downto 0)
	);
end component;


--IGRESSI
signal atemp,btemp : std_logic_vector(7 downto 0);
signal cintemp: std_logic;
--il ripoto in ingresso considerato pari a "0" e il riporto in ingresso
--considerato pari a "1" devono essere salvati in dei flip flop intermedi
--per poi essere mandati, rispettivamente, come ingressi del CLA0 e del CLA1.
signal inc0, inc1 : std_logic;


--SEGNALI AUSILIARI
--s0 per conservare la somma calcolata con il riporto (cioe' 1)
--e s1 quella senza riporto (cioe' 0)
--si e' la somma calcolata per i bit piu' significativi dal CLAI	
signal s0,s1,si : std_logic_Vector(3 downto 0);--SOMME PARZIALI


--ci primo riporto del CLAI che calcola la somma per i bit della parte
--meno significativa;
--c0 e' il riporto generato dal CLA0 che calcola la somma considerando il
--riporto in ingresso pari a "0";
--c1 e' il riporto generato dal CLA1 che calcola la somma considerando il
--riporto in ingresso pari a "1";
signal c0,c1,ci : std_logic;--RIPORTI IN USCITA

--parte descrittiva


begin


--operazioni dei registri

--SINCRONIZZAZIONE DEGLI INGRESSI

--ARegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--presi, inserendoli nel suo valore di uscita 
ARegister : Register8 port map(a,clock,clear,atemp);

--BRegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--presi, inserendoli nel suo valore di uscita 
BRegister : Register8 port map(b,clock,clear,btemp);

--CinFlipFlop e' il componente che immagazzina il valore del riporto iniziale cin, rendendolo
--disponibile come stato della sua uscita 
CinFlipFlop : FlipFlop port map(cin,clock,clear,cintemp);

--C0FF e' il componente che immagazzina il valore del riporto c0, che sarebbe il riporto
--dato in ingresso al CLA0, considerato pari a "0", rendendolo disponibile come stato della 
--sua uscita denominata inc0
C0FF : FlipFlop  port map('0',clock,clear,inc0);

--C1FF e' il componente che immagazzina il valore del riporto c1, che sarebbe il riporto
--dato in ingresso al CLA1, considerato pari a "1", rendendolo disponibile come stato della 
--sua uscita denominata inc1
C1FF : FlipFlop  port map('1',clock,clear,inc1);

--CALCOLI

--operazione dei Ripple Carry modificate tenendo conto dell'introduzione dei registri

--RCI "iniziale" somma di std_logic in posizione da 0 a 3, parte meno significativa:
--		riceve, come ingressi, il riporto iniziale cintemp, il vettore atemp da cui prende i
--		primi 4 bit e il vettore btemp, con cui fa la stessa cosa; il risultato verra'
--		scritto nelle prime quattro celle del vettore risultante stemp
RCI : RippleCarry4b  port map(atemp(3 downto 0),btemp(3 downto 0),cintemp,s(3 downto 0),ci);

--RC0  somma da  std_logic in posizione da 4 a 7
--		questo si suppone lavori con riporto in ingresso '0'
--		c0 e' il suo riporto in uscita,salva la somma in s0
RC0 : RippleCarry4b port map(atemp(7 downto 4),btemp(7 downto 4),inc0,s0,c0);

--RC1  somma da std_logic in posizione da 4 a 7
--		questo si suppone lavori con riporto in ingresso '1'
--		c1 e' il suo riporto in uscita,salva la somma in s1
RC1 : RippleCarry4b port map(atemp(7 downto 4),btemp(7 downto 4),inc1,s1,c1);

--operazioni dei Mux 

--il selettore di ogni mux sara' il riporto ci ottenuto dal primo ripple carry rci
--la scelta tra s1 e s0 verra' messa in stemp

M4 : Mux port map(s0(0),s1(0),ci,s(4));
M5 : Mux port map(s0(1),s1(1),ci,s(5));
M6 : Mux port map(s0(2),s1(2),ci,s(6));
M7 : Mux port map(s0(3),s1(3),ci,s(7));

--segue mux che calcola il riporto finale 
MC :Mux port map(c0,c1,ci,cout);


end CS8b;

