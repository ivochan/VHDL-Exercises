--Registro a 17 Flip Flop di tipo std_logic
--e' realizzato in forma compatta, senza istanziare i flip flop ma
--scrivendo direttamente il process
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--componente usato per immagazzinare le otto cifre con cui lavorera' il sommatore
Entity Register17 is 
--ingressi:
--id vettore da 17 celle,clock,clear;
--uscite:
--uq vettore di uscita da 17 celle;
	port(
		id : in std_logic_vector(16 downto 0);
		clock,clear: in std_logic;
		uq : out std_logic_vector(16 downto 0)
	);
	
end Register17;

Architecture MyRegistro of Register17 is
--inizio delle operazioni
begin
	
process(clock,clear)
	begin
		if clear = '1' then
			  uq <= "00000000000000000";
		
		elsif clock'event and clock = '1' 
				 then uq <= id;
					 
		end if;
	end process;
	
end MyRegistro;






