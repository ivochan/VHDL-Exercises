--Test del modulo che calcola il complemento a due
--Il complemento a due viene effettuato negando ogni bit e 
--sommando uno al numero così ottenuto
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity TestC2 is
end TestC2;

--architettura
Architecture TC2 of TestC2 is
--inclusione del complemento a due
component Complemento2 is
	port( 
		a:in std_logic_vector(7 downto 0);
		r: out std_logic_vector	(7 downto 0)--8 bit
		);
end component;

--inizializzazione dei segnali
signal ia:std_logic_vector(7 downto 0);
signal ir:std_logic_vector(7 downto 0);
--simulaizone
begin

inputs:
process

	begin
	ia<="00000011";
	wait for 30 ns;
	ia<="00000001";
	wait for 60 ns;
end process;

--simulazione
c2 : Complemento2 port map (ia,ir);

end TC2;
