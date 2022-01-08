--Registro a 16 Flip Flop di tipo std_logic
--e' realizzato in forma compatta, senza istanziare i flip flop ma
--scrivendo direttamente il process
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--componente usato per immagazzinare le otto cifre con cui lavorera' il sommatore
Entity Register16 is 
--ingressi:
--d vettore da 16 celle,clock,clear;
--uscite:
--q vettore di uscita da 16 celle;
	port(
		d : in std_logic_vector(15 downto 0);
		clock,clear: in std_logic;
		q : out std_logic_vector(15 downto 0)
	);
	
end Register16;

Architecture MyRegistro of Register16 is

	begin
	
	process(clock,clear)
			begin
				if clear = '1' then
					  q <= "0000000000000000";
					  
				elsif clock'event and clock = '1' 
					 then q <= d;
					 
				end if;
	end process;
	
end MyRegistro;





