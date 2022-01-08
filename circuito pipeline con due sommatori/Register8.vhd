--Registro ad 8 Flip Flop 
--e' realizzato in forma compatta, senza istanziare i flip flop ma
--scrivendo direttamente il process
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--componente usato per immagazzinare le otto cifre con cui lavorera' il sommatore
Entity Register8 is 
--ingressi:
--d vettore da 8 celle,clock,clear;
--uscite:
--q vettore di uscita da 8 celle;
	port(
		d : in std_logic_vector(7 downto 0);
		clock,clear: in std_logic;
		q : out std_logic_vector(7 downto 0)
	);
end Register8;

Architecture MyRegistro of Register8 is

	begin
	process(clock,clear)
			begin
			if clear = '1' then
				q <= "00000000";
			elsif clock'event and clock = '1' then
						q <= d;
			end if;
	end process;
end MyRegistro;



