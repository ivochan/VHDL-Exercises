--Test Divisore in terne
--Riceve un numero ad otto bit 
--e lo scompone in terne da passare
--al modulo Dec che attua la decodifica
--in codice di Booth
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity TestDivisore is
end TestDivisore;

--definizione dell'architettura
Architecture MyDT of TestDivisore is

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
end component;
--segnali ausiliari
signal ingresso: std_logic_vector(7 downto 0);
signal s1,s2,s3,s4: std_logic_vector(2 downto 0);--uscite

--simulazione
begin


	process

		begin
		--inizializzazione degli ingressi
		ingresso<="00000000";
		wait for 30 ns;
		ingresso<="01110000";
		wait for 30 ns;
		ingresso<="11110111";
		wait for 30 ns;
		ingresso<="10001000";
		wait for 60 ns;
	
	end process;

--implementazione del circuito
	div : DivisoreTerne port map(ingresso,s1,s2,s3,s4);

end MyDT;

