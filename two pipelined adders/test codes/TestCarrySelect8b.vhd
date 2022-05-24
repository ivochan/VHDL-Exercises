--Test del Carry Select ad 8 bit denominato CarrySelect8b
--04-01-16

--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestCarrySelect8b is
end TestCarrySelect8b;

Architecture TCS8b of TestCarrySelect8b is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='0';--segnale di clock
signal iclear : std_logic :='1';--segnale di clear 
--segnali usati
signal ia,ib :std_logic_vector(7 downto 0);
signal us :std_logic_vector(8 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente CarrySelect8
component CarrySelect8b is

port(
	a,b : in std_logic_Vector(7 downto 0 );
	cin, clock, clear : in std_logic;
	  s : out std_logic_Vector(8 downto 0);
	cout: out std_logic
	);
end component;

begin
--si scrive il process relativo al segnale di clock
clock:
process 
	begin
	loop
		wait for 30 ns;
		iclock<= not iclock;
	end loop;
end process;

--si scrive il process relativo al segnale di clear
clear:
process 
	begin
	loop
		wait for 30 ns;
		iclear<= not iclear;
	end loop;
end process;

--si scrive il process relativo agli altri ingressi
inputs:
process
	begin
	icin<='0';
	ia<="00000000";
	ib<="00000001";
	wait for 30 ns;
	ia<="11111110";
	icin<='1';
	wait for 30 ns;
end process;

circuito: CarrySelect8b port map(ia,ib,icin,iclock,iclear,us,ucout);

end TCS8b;
