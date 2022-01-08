--Sommatore usato per addizionare i prodotti parziali
--deve essere a 15 bit
--quindi i vari prodotti parziali dovranno essere 
--passati in dei vettori in modo da uniformarne
--la lunghezza 
--Il risultato ottenuto da questo sommatore sara'
--effettivamente, il prodotto che si genera tra due
--operandi a quattro bit
--questo risultato verra' poi riposto in un registro di 
--sedici bit, in modo che, quando dovra' essere 
--passato al sommatore che effettua la somma tra i tre 
--prodotti generati dalle tre coppie di operandi
--questo riceva i tre ingressi(PRODOTTI A SEDICI BIT)
--in maniera SINCRONIZZATA
--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente

Entity Adder15 is
--riceve i prodotti parziali gia' resi a 15 bit
--e li somma tra di loro, dando in output
--il risultato effettivo del prodotto tra i due operandi
--iniziali ad otto bit
	port(
		 prodp1,prodp2,prodp3,prodp4: in std_logic_vector(14 downto 0);
		 prodtot: out std_logic_vector(15 downto 0)
	);
	
end Adder15;

--definizione dell'architettura
Architecture MyA15 of Adder15 is
--variabili ausiliarie
signal s:std_logic_vector(14 downto 0);--contiene la somma quasi completa
signal cout: std_logic;--riporto generato dall'ultimo ripple carry
signal stemp1,stemp2: std_logic_vector(14 downto 0);--somme a 15 bit
signal riporto,riporto2,finalcout: std_logic;--riporto generato dal secondo ripple carry(ingresso dell'ultimo)

--inclusione del componente ripple carry
component RippleCarry15 is
	port( 
	 	a,b: in std_logic_Vector(14 downto 0);--operandi in ingresso
      	 	cin: in std_logic;--riporto iniziale in ingresso	
     		 s: out std_logic_Vector(14 downto 0);--15 bit
         	cout: out std_logic);
end component;

--si include il FullAdder
component FullAdder is 
	port (
		a,b,cin: in std_logic;
		cout,s:out std_logic);
end component;

--non c'e' riporto iniziale nei primi due ripple carry: cin='0'

--inizio delle oprazioni da effettuare
begin
--somma tra op1 e op2 operandi a 15 bit
Primo: RippleCarry15 port map(prodp1,prodp2,'0',stemp1,riporto2);
--somma tra op3 e op4 operandi a 15 bit


Secondo: RippleCarry15 port map(prodp3,prodp4,'0',stemp2,riporto);


--somma tra le due somme parziali stemp1 e stemp2
Ultimo: RippleCarry15 port map(stemp1,stemp2,'0',s,cout);

--calcolo del riporto complessivo
RiportoFinale: FullAdder port map(riporto,riporto2,cout,finalcout);

--dove s e' un numero a 15 bit e cout un bit

--si scrive l'uscita del blocco Adder15 che deve essere un numero a 16 bit 
--cosi' fatto: riporto e s =1+15= 16 bit
prodtot(15)<=finalcout;
prodtot(14)<=s(14);
prodtot(13)<=s(13);
prodtot(12)<=s(12);
prodtot(11)<=s(11);
prodtot(10)<=s(10);
prodtot(9)<=s(9);
prodtot(8)<=s(8);
prodtot(7)<=s(7);
prodtot(6)<=s(6);
prodtot(5)<=s(5);
prodtot(4)<=s(4);
prodtot(3)<=s(3);
prodtot(2)<=s(2);
prodtot(1)<=s(1);
prodtot(0)<=s(0);

--il risultato e' stato assegnato

end MyA15;
