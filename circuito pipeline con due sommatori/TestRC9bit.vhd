--test ripple carry a nove bit
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestRC9bit is
end TestRC9bit;

Architecture TRC9b of TestRC9bit is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='0';--segnale di clear 
--segnali usati
signal ia,ib :std_logic_vector(8 downto 0);
signal us :std_logic_vector(8 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente CarrySelect8
component RippleCarry9bit is

	port( 	
		a,b: in std_logic_Vector(8 downto 0);
		cin: in std_logic;	
		clock,clear: in std_logic;
		s: out std_logic_Vector(8 downto 0);
		cout: out std_logic);
	 
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
		wait for 60 ns;
		iclear<='1';
		wait for 100 ns;
		iclear<='0';
		wait for 200 ns;
end process;

--si scrive il process relativo agli altri ingressi
inputs:
process
	begin
	icin<='0';
	ia<="000000000";
	ib<="000000001";
	wait for 30 ns;
	ia<="111111110";
	icin<='1';
	wait for 30 ns;
	ia<="001110000";
	wait for 60 ns;
end process;

circuito: RippleCarry9bit port map(ia,ib,icin,iclock,iclear,us,ucout);

end TRC9b;
