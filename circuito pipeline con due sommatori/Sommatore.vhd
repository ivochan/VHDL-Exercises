--Sommatore totale
--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity Sommatore is

	port( 
		 a,b,c: in std_logic_Vector(15 downto 0);
		   cin: in std_logic;	
		 clock,clear:in std_logic;
    	 s: out std_logic_Vector(15 downto 0);
		 cout: out std_logicù
		 );
	 
end Sommatore;

--definizione dell'architettura

Architecture MyS of Sommatore is

--segnali ausiliari per i registri
signal atemp,btemp,sabtemp1: std_logic_vector(15 downto 0);--somma tra a e b
signal ctemp1,ctemp2,sabtemp2,sfinale:std_logic_vector(15 downto 0);
signal coutemp1,coutemp2,coutfinale:std_logic;


--COMPONENTI UTILIZZATI

--si include il FullAdder che eseguira' le somme
component FullAdder is
	port(a,b,cin: in std_logic;
		cout,s:out std_logic);
end component;

--si include il Registro a 16 bit
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

--inclusione del Flip Flop
component FlipFlop is

	port(d,clock,clear: in std_logic;
			 q: out std_logic
	);
end component;


--inclusione del ripple carry a 16 bit
component RippleCarry16 is
	port( 
		 a,b: in std_logic_Vector(15 downto 0);
      	 cin: in std_logic;	
		 clock, clear: in std_logic;
     	 s: out std_logic_Vector(15 downto 0);
      	 cout: out std_logic
		);
	 
end component;


--INIZIO


begin
--operazioni dei registri

--SINCRONIZZAZIONE DEGLI INGRESSI

--PRIMO SOMMATORE 




--OPERAZIONI

--PRIMO SOMMATORE

Primo:CarrySelect8b port map(a,b,cin,clock,clear,sabtemp,coutemp1);

--assegnamento della somma tra a e b complessiva, come cifra in posizione 8,
--del riporto coutemp1: risultato a 9 bit
sabtemp1(0)<=sabtemp(0);
sabtemp1(1)<=sabtemp(1);
sabtemp1(2)<=sabtemp(2);
sabtemp1(3)<=sabtemp(3);
sabtemp1(4)<=sabtemp(4);
sabtemp1(5)<=sabtemp(5);
sabtemp1(6)<=sabtemp(6);
sabtemp1(7)<=sabtemp(7);
sabtemp1(8)<=coutemp1;


--secondo operando del secondo sommatore
ctemp(0)<=c(0);
ctemp(1)<=c(1);
ctemp(2)<=c(2);
ctemp(3)<=c(3);
ctemp(4)<=c(4);
ctemp(5)<=c(5);
ctemp(6)<=c(6);
ctemp(7)<=c(7);
ctemp(8)<=cintemp2;

--CRegister: passaggio di c nel registro a 9 bit
C2Register : Register9 port map(ctemp,clock,clear,ctemp2);--Operando C a 9 bit

--OPERAZIONI

--SECONDO SOMMATORE

Secondo:RippleCarry9bit port map(sabtemp1,ctemp2,'0',clock,clear,sfinale,coutemp2);

--SINCRONIZZAZIONE DELLE USCITE

--riporto finale
COUTFF : FlipFlop  port map(coutemp2,clock,clear,cout);
--somma finale
SFRegister : Register9 port map(sfinale,clock,clear,s);


end MyS;
