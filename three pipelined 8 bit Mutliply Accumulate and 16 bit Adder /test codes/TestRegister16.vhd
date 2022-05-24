--Test del registro a 16 bit

--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestRegister16 is
end TestRegister16;

Architecture TR16 of TestRegister16 is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='0';--segnale di clear 
signal id,iq :std_logic_vector(15 downto 0);

--si richiama il componente Register16
component Register16 is

port(
	d : in std_logic_vector(15 downto 0);
	clock,clear: in std_logic;
	q : out std_logic_vector(15 downto 0)
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
	id<="0000000000000000";
	wait for 30 ns;
	id<="1111111111111111";
	wait for 30 ns;
	id<="1111100000111111";
	wait for 90 ns;
end process;

circuito : Register16 port map(id,iclock,iclear,iq);

end TR16;


