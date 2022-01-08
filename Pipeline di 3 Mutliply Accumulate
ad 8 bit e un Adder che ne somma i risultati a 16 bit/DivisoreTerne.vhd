--Divisore in terne
--Riceve un numero ad otto bit 
--e lo scompone in terne da passare
--al modulo Dec che attua la decodifica
--in codice di Booth
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity DivisoreTerne is
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

end DivisoreTerne;

--definizione dell'architettura
Architecture MyDT of DivisoreTerne is
--si include il componente Decodificatore
component Dec is
	port(
		i: in std_logic_vector(2 downto 0);
		u: out std_logic_vector(2 downto 0)
	);
end component;

--si istanziano 4 dec, ciascuno dei quali ricevera'
--la propria terna
--i segnali ausiliari saranno costituiti dai vettori 
--da tre celle che quindi gli verranno dati in ingresso
signal terna1, terna2, terna3, terna4 : std_logic_vector(2 downto 0);

--inizio delle operazioni
begin
--assegnamento dei vettori
--PRIMA TERNA
terna1(0)<='0';--aggiunta i(-1)
terna1(1)<=i(0);
terna1(2)<=i(1);

--SECONDA TERNA
--Nota: il primo bit della terna successiva e'
--l'ultimo bit della terna precedente
terna2(0)<=i(1);
terna2(1)<=i(2);
terna2(2)<=i(3);

--TERZA TERNA
terna3(0)<=i(3);
terna3(1)<=i(4);
terna3(2)<=i(5);

--QUARTA TERNA
terna4(0)<=i(5);
terna4(1)<=i(6);
terna4(2)<=i(7);

--si istanziano i codificatori secondo la tabella di Booth


--DEC1 per la prima terna
Dec1: Dec port map(terna1,sel1);

--DEC2 per la seconda terna
Dec2: Dec port map(terna2,sel2);

--DEC3 per la terza terna
Dec3: Dec port map(terna3,sel3);

--DEC4 per la quarta terna
Dec4: Dec port map(terna4,sel4);

end MyDT;

