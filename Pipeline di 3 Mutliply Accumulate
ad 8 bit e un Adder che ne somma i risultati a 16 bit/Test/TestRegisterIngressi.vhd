--Test del registro degli ingressi ad otto bit
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestRegisterIngressi is
end TestRegisterIngressi;

Architecture TRI of TestRegisterIngressi is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='0';--segnale di clear 
signal id,iq :std_logic_vector(7 downto 0);

--si richiama il componente RegistroIngressi da testare
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

begin

--si scrive il process relativo al segnale di clock
clock:
	process 
		begin
		wait for 50 ns;
		iclock <= not iclock;
		wait for 50 ns;
		iclock <= not iclock;
		wait for 50 ns;
		iclock <= not iclock;
		wait for 50 ns;
	end process;

--process relativo al segnale di clear
clear:
	process
		begin
		iclear<='1';
		wait for 30 ns;
		iclear<= '0';
		wait for 200 ns;
	end process;
	
--process relativo agli ingressi
inputs:
	process
		begin
		id<="00000000";
		wait for 30 ns;
		id<="11111111";
		wait for 30 ns;
		id<="10101001";
		wait for 30 ns;
		id<="10000000";
		wait for 30 ns;
	end process;

--simulazione
circuito : RegistroIngressi port map(id,iclock,iclear,iq);

end TRI;


