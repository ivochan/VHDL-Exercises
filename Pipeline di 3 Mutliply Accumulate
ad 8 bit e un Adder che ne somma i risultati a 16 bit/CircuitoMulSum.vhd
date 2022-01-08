--circuito complessivo pipeline
--costituito da tre moltiplicatore in parallelo
--i cui risultati vengono mandati ad un sommatore a tre ingressi
--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;

--definizione del componente
Entity CircuitoMulSum is
	port(
		a,fa,b,fb,c,fc: in std_logic_vector(7 downto 0);
		clock,clear:in std_logic;
		risultato: out std_logic_vector(16 downto 0);
		riporto: out std_logic
	);
end CircuitoMulSum;

--definizione dell'entita'
Architecture MyCMS of CircuitoMulSum is

--variabile ausiliarie per la sincronizzazione
--da ingressi circuito complessivo ad ingressi moltiplicatori
signal at,fat,bt,fbt,ct,fct:std_logic_vector(7 downto 0);
--uscite moltiplicatori 16 bit
signal pm1,pm2,pm3:std_logic_vector(15 downto 0);
--uscita sommatore tre prodotti
signal ris:std_logic_vector(16 downto 0);
--riporto somma tre prodotti
signal carry:std_logic;


--inclusione dei componenti

--flip flop
component FlipFlop is 
	port(
		d,clock,clear: in std_logic;
		q: out std_logic
	);
end component;

--registro speciale che si occupa di cambiare il bit 
--piu' significativo degli ingressi in '0', oltre che di
--sincronizzarli e passarli, a coppie, ai tre moltiplicatori di Booth
component RegistroIngressi is
--REGISTRO DI CAMBIO BIT SIGNIFICATIVO
--riceve in ingresso un vettore di otto bit
--ne cambia il bit piu' significativo,
--quello in posizione 7 e salva tutto in 
--un vettore ad otto bit
	port(
		i: in std_logic_vector(7 downto 0);
		clock,clear:in std_logic;
		u: out std_logic_vector(7 downto 0)
	);
end component;

--moltiplicatore di booth: si occupa di calcolare i prodotti tra le coppie
--se ne dovranno istanziare tre
component MulBooth is
--porte coinvolte
	port(
		 a,b: in std_logic_vector(7 downto 0);--otto bit
		 p: out std_logic_vector(15 downto 0)--sedici bit
		);
		
end component;

--modulo che si occupa di sommare i tre prodotti calcolati
component Sommatore3Prod is
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
	 
end component;

--registro a 17 bit
component Register17 is 
--ingressi:
--d vettore da 17 celle,clock,clear;
--uscite:
--q vettore di uscita da 17 celle;
	port(
		id : in std_logic_vector(16 downto 0);
		clock,clear: in std_logic;
		uq : out std_logic_vector(16 downto 0)
	);
end component;

--inizio delle operazioni
begin

--SINCRONIZZAZIONE DEGLI INGRESSI
ra: RegistroIngressi port map(a,clock,clear,at);
rfa: RegistroIngressi port map(fa,clock,clear,fat);
rb: RegistroIngressi port map(b,clock,clear,bt);
rfb: RegistroIngressi port map(fb,clock,clear,fbt);
rc: RegistroIngressi port map(c,clock,clear,ct);
rfc: RegistroIngressi port map(fc,clock,clear,fct);

--Calcolo dei prodotti
--Primo:
Mul1: MulBooth port map(at,fat,pm1);

--Secondo:
Mul2: MulBooth port map(bt,fbt,pm2);

--Terzo:
Mul3: MulBooth port map(ct,fct,pm3);


--Somma dei prodotti
SommaProdotti: Sommatore3Prod port map(pm1,pm2,pm3,'0',clock,clear,ris,carry);
--queso modulo sincronizza gli ingressi che riceve internamente a se stesso
--di sincronizzare le uscite invece se ne occupa il modulo corrente, CircuitoMulSum


--SINCRONIZZAZIONE DELLE USCITE

--riporto finale
COUTFF : FlipFlop  port map(carry,clock,clear,riporto);
--somma finale
SRegister : Register17 port map(ris,clock,clear,risultato);

end MyCMS;