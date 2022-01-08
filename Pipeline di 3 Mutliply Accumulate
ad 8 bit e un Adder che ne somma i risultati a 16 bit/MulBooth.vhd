--Moltiplicatore di Booth
--e' una composizione di vari moduli
--che si occupa di realizzare l'operazione
--di moltiplicazione tra due operandi ad otto bit
--utilizzando gli shiftleft per poi sommare i prodotti parziali

--Riepilogo:
--riceve due ingressi ad otto bit e restituisce il loro prodotto a 16 bit

--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--definizione del componente
Entity MulBooth is
--porte coinvolte
	port(
		 a,b: in std_logic_vector(7 downto 0);--otto bit
		 p: out std_logic_vector(15 downto 0)--sedici bit
		);
		
end MulBooth;
--definizione dell'architettura
Architecture MyMB of MulBooth is
--inclusione dei componenti:

--all'inizio verranno usati, su A:

component DivisoreTerne is
--riceve in ingresso un numero ad otto bit
--fornisce in uscita quattro flussi a tre bit ciascuno
--che saranno i selettori dei quattro mux usati nel circuito
	port(
		i: in std_logic_vector(7 downto 0);
		sel1: out std_logic_vector(2 downto 0);
		sel2: out std_logic_vector(2 downto 0);
		sel3: out std_logic_vector(2 downto 0);
		sel4: out std_logic_vector(2 downto 0)
	);
--scompone l'ingresso in terne da passare
--al modulo Dec 
end component;

--all'inizio verranno usati su B:

component Complemento2 is
--riceve in ingresso un numero ad otto bit
--e restituisce il suo complemento a due
	port( 
		a:in std_logic_vector(7 downto 0);
		r: out std_logic_vector(7 downto 0)--otto bit
		);
--r sara' a di segno negativo
end component;

--Mux a 5 ingressi
component Mux5i9b is

	port(
		a,b,c,d,e:in std_logic_vector(8 downto 0);
		sel: in std_logic_vector(2 downto 0);
         	ris: out std_logic_vector(8 downto 0)
         );
--si sceglie la seguente notazione:
--a come "00000000";
--b come "moltiplicatore";
--c come "- moltiplicatore";
--d come "2 per moltiplicatore";
--e come "-2 per moltiplicatore";			
end component;

--Si includono tutti i moduli di Shifting 
component Shiftl1 is
	port(
		i : in std_logic_vector(7 downto 0);
		u : out std_logic_vector(8 downto 0)
		);--da otto bit a nove
end component;

component Shiftl2 is
	port(
		i : in std_logic_vector(8 downto 0);--9 bit in ingresso
		u : out std_logic_vector(10 downto 0)--11 bit in uscita
		);
end component;

component Shiftl4 is
	port(
		i : in std_logic_vector(8 downto 0);--9 bit in ingresso
		u : out std_logic_vector(12 downto 0)--13 bit in uscita
		);
end component;

component Shiftl6 is
	port(
		i : in std_logic_vector(8 downto 0);--9 bit in ingresso
		u : out std_logic_vector(14 downto 0)--15 bit in uscita
		);
end component;

--sommatore dei prodotti parziali
component Adder15 is
--riceve i prodotti parziali gia' resi a 15 bit
--e li somma tra di loro, dando in output
--il risultato effettivo del prodotto tra i due operandi
--iniziali ad otto bit
	port(
		 prodp1,prodp2,prodp3,prodp4: in std_logic_vector(14 downto 0);
		 prodtot: out std_logic_vector(15 downto 0)
	);
end component;


--INIZIO DELLE OPERAZIONI 

--segnali ausiliari usati per i quattro MUX
--ingressi
signal ia,ib,ic,id,ie: std_logic_vector(8 downto 0);
signal ictemp: std_logic_vector(7 downto 0);
--selettori
signal usel1,usel2,usel3,usel4: std_logic_vector(2 downto 0);
--uscite, numeri a nove bit
signal uop1,uop2,uop3,uop4: std_logic_vector(8 downto 0);
--variabile ausiliarie per trasformare le uscite dei mux, dopo le operazioni
--che calcolo i prodotti parziali, a 15 bit: prodotti parziali
signal pp1,pp2,pp3,pp4: std_logic_vector(14 downto 0);
--variabili temporanee per salvare le uscite dei mux che devono essere shiftate(tre di quattro)
signal suop2:std_logic_vector(10 downto 0);
signal suop3:std_logic_vector(12 downto 0);


--fine inizializzazioni


begin --CALCOLI

--si ricavano i vari ingressi a nove bit, a partire da B, che ricevera' il mux1

--ia: "000000000"
ia<="000000000";

--ib: B stesso reso a nove bit
ib(8)<=b(7);
ib(7)<=b(7);
ib(6)<=b(6);
ib(5)<=b(5);
ib(4)<=b(4);
ib(3)<=b(3);
ib(2)<=b(2);
ib(1)<=b(1);
ib(0)<=b(0);

--ic: sara' B opposto in segno, si ottiene con il complemento a due
--rendendolo poi a nove bit
C2: Complemento2 port map(b,ictemp);
--trasformazione in nove bit
ic(8)<=ictemp(7);
ic(7)<=ictemp(7);
ic(6)<=ictemp(6);
ic(5)<=ictemp(5);
ic(4)<=ictemp(4);
ic(3)<=ictemp(3);
ic(2)<=ictemp(2);
ic(1)<=ictemp(1);
ic(0)<=ictemp(0);

--id: sara' B moltiplicato per due e reso a nove bit,
--si utilizza per farlo lo shift1 applicato sul complemento a due fatto su b,cioe' ictemp
B2: Shiftl1 port map(b,id);

--ie: sara' l'opposto di B moltiplicato per 2, sempre a nove bit
--lo ottengo shiftando di uno il valore di ic( che e' proprio -B)
Bmeno2: Shiftl1 port map(ictemp,ie);

--ora si devono costruire i selettori che riceveranno i quattro mux da istanziare
--questi sono le quattro uscite generate dai blocchetti Dec
--Si ottiene come segue:
DT: DivisoreTerne port map(a,usel1,usel2,usel3,usel4);

--Si istanziano i quattro mux
--per la prima terna
Mux1: Mux5i9b port map(ia,ib,ic,id,ie,usel1,uop1);
--per la seconda terna
Mux2: Mux5i9b port map(ia,ib,ic,id,ie,usel2,uop2);
--per la terza terna
Mux3: Mux5i9b port map(ia,ib,ic,id,ie,usel3,uop3);
--per la quarta terna
Mux4: Mux5i9b port map(ia,ib,ic,id,ie,usel4,uop4);

--ora bisogna trattare le uscite dei mux e renderle tutte a 15 bit
--Calcolo dei prodotti parziali

--PRIMO PRODOTTO: uscita di mux1
--il riempimento delle celle vuote fino a rendere upo1 a nove bit un numero
--a 15 bit verra' effettuato ricopiando il valore del suo bit piu' significativo
--in ciascuna di queste, in modo che:
--se questo sara' uno, vorra' dire che il numero ottenuto era negativo in segno
--e di conseguenza lo sara' anche il prodotto parziale che si sta generando
--se questo sara' zero, allora il numero era positivo in segno.
--il numero piu' significativo di uop1 e' quello in posizione 8
pp1(14)<=uop1(8);pp1(13)<=uop1(8);pp1(12)<=uop1(8);pp1(11)<=uop1(8);pp1(10)<=uop1(8);pp1(9)<=uop1(8);--riempimento delle celle vuote
pp1(8)<=uop1(8);pp1(7)<=uop1(7);pp1(6)<=uop1(6);pp1(5)<=uop1(5);pp1(4)<=uop1(4);
pp1(3)<=uop1(3);pp1(2)<=uop1(2);pp1(1)<=uop1(1);pp1(0)<=uop1(0);

--SECONDO PRDODOTTO: uscita mux2
SM2: Shiftl2 port map(uop2,suop2);--shifting
--da 11 a 15 bit
--lle celle vuote verranno riempite con suop2(10)
pp2(14)<=suop2(10);pp2(13)<=suop2(10);pp2(12)<=suop2(10);pp2(11)<=suop2(10);--riempimento delle celle vuote
pp2(10)<=suop2(10);pp2(9)<=suop2(9);pp2(8)<=suop2(8);pp2(7)<=suop2(7);pp2(6)<=suop2(6);pp2(5)<=suop2(5);
pp2(4)<=suop2(4);pp2(3)<=suop2(3);pp2(2)<=suop2(2);pp2(1)<=suop2(1);pp2(0)<=suop2(0);

--TERZO PRODOTTO: uscita mux3
SM3: Shiftl4 port map(uop3,suop3);--shifting
--da 13 a 15 bit
--le celle vuote verranno riempite con suop3(12)
pp3(14)<=suop3(12);pp3(13)<=suop3(12);--riempimento delle celle vuote
pp3(12)<=suop3(12);pp3(11)<=suop3(11);pp3(10)<=suop3(10);pp3(9)<=suop3(9);pp3(8)<=suop3(8);pp3(7)<=suop3(7);
pp3(6)<=suop3(6);pp3(5)<=suop3(5);pp3(4)<=suop3(4);pp3(3)<=suop3(3);pp3(2)<=suop3(2);pp3(1)<=suop3(1);pp3(0)<=suop3(0);

--QUARTO PRODOTTO
SM4: Shiftl6 port map(uop4,pp4);--shifting
--a 15 bit(non c'e' bisogno di spostarlo)

--DEBUGGIN
--p<=pp1; --per debugging

--RISULTATO
--si sommano i prodotti parziali: risultato a 16 bit
SommaProdottiParziali: Adder15 port map(pp1,pp2,pp3,pp4,p);


end MyMB;


