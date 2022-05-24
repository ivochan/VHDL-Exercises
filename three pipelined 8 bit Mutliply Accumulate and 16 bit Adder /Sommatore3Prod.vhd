--Sommatore totale (SEQUENZIALE)
--si occupa di effettuare la somma tra i tre prodotti
--che si sono calcolati a partire dalle tre coppie
--di operandi ad otto bit dati in ingresso al circuito

--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity Sommatore3Prod is
--riceve in ingresso tre operandi a 16 bit
--cin, riporto in ingresso, che e' nullo;
--uscite:
--s vettore di 16 bit, e' il risultato della somma tra i tre numeri a 16 bit;
--cout, riporto in uscita

port( 
	a,b,c: in std_logic_Vector(15 downto 0);
     	cin: in std_logic;	
	clock,clear:in std_logic;
 	s: out std_logic_Vector(16 downto 0);
        cout: out std_logic);
	 
end Sommatore3Prod;

--definizione dell'architettura

Architecture MyS3P of Sommatore3Prod is

--segnali ausiliari per i registri
signal atemp,btemp,ctemp: std_logic_vector(15 downto 0);
signal ctemp1,ctemp2,sabtemp,sab: std_logic_vector(16 downto 0);
signal cintemp,coutemp,cotemp1: std_logic;


--COMPONENTI UTILIZZATI
component RippleCarry16 is
--ingressi:
--a vettore di 16 bit, b vettore di 16 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit;
--uscite:
--s vettore di 16 bit, e' il risultato della somma tra i due numeri a 16 bit, a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit;
port( 
	 a,b: in std_logic_Vector(15 downto 0);
      	 cin: in std_logic;	
	 clock, clear: in std_logic;
     	 s: out std_logic_Vector(16 downto 0);--risultato a 17 bit
    	 cout: out std_logic);
	 
end component;

--per memorizzare gli ingressi e la somma risultante
component Register16 is 
--ingressi:
--d vettore da 16 celle,clock,clear;
--uscite:
--q vettore di uscita da 16 celle;
	port(
		d : in std_logic_vector(15 downto 0);
		clock,clear: in std_logic;
		q : out std_logic_vector(15 downto 0)
	);
end component;

--inclusione registro a 17 bit
component Register17 is 
	port(
		id : in std_logic_vector(16 downto 0);
		clock,clear: in std_logic;
		uq : out std_logic_vector(16 downto 0)
	);
end component;

--per memorizzare il riporto iniziale ed il riporto in uscita cout
component FlipFlop is 
	port(d,clock,clear: in std_logic;
			 q: out std_logic
	);
end component;

--ripple carry che somma operandi a 17 bit
component RippleCarry17 is
	port( 
		a,b: in std_logic_Vector(16 downto 0);
	      	cin: in std_logic;	
		clock, clear: in std_logic;
	     	s: out std_logic_Vector(16 downto 0);
	        cout: out std_logic);
end component;

--INIZIO


begin
--operazioni dei registri
--SINCRONIZZAZIONE DEGLI INGRESSI a 16 bit

--ARegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--inserendoli nel suo valore di uscita 
ARegister : Register16 port map(a,clock,clear,atemp);

--BRegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--inserendoli nel suo valor di uscita 
BRegister : Register16 port map(b,clock,clear,btemp);

--CRegister e' il registro che immagazzina i valori del vettore a ricevuto in ingresso,
--inserendoli nel suo valor di uscita 
CRegister : Register16 port map(c,clock,clear,ctemp);

--riporto iniziale
FR: FlipFlop port map('0',clock,clear,cintemp);

--PRIMO SOMMATORE

SommaAB:RippleCarry16 port map(atemp,btemp,cintemp,clock,clear,sabtemp);

--la sua somma viene resa gia' internamente a 17 bit, anteponendo al
--risultato della somma tra a e b , il riporto che si e' generato

--SECONDO SOMMATORE

--sabtemp e' gia' stata resa a 17 bit e deve essere passata in un registro
--per essere sincronizzata
SABRegister: Register17 port map(sabtemp,clock,clear,sab);

--secondo operando del secondo sommatore: passaggio da 15 a 16 bit
ctemp1(0)<=ctemp(0);
ctemp1(1)<=ctemp(1);
ctemp1(2)<=ctemp(2);
ctemp1(3)<=ctemp(3);
ctemp1(4)<=ctemp(4);
ctemp1(5)<=ctemp(5);
ctemp1(6)<=ctemp(6);
ctemp1(7)<=ctemp(7);
ctemp1(8)<=ctemp(8);
ctemp1(9)<=ctemp(9);
ctemp1(10)<=ctemp(10);
ctemp1(11)<=ctemp(11);
ctemp1(12)<=ctemp(12);
ctemp1(13)<=ctemp(13);
ctemp1(14)<=ctemp(14);
ctemp1(15)<=ctemp(15);--sedicesimo bit
ctemp1(16)<='0';--cella vuota
--c viene reso, da 16 a 17 bit 

--CRegister: passaggio di ctemp nel registro a 16 bit
C2Register : Register17 port map(ctemp1,clock,clear,ctemp2);--Operando C a 16 bit

--SECONDO SOMMATORE: somma tra (A+B) + C

SommaSC:RippleCarry17 port map(sab,ctemp2,cintemp,clock,clear,s,cout);




end MyS3P;
