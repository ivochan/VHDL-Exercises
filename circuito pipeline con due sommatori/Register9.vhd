--Registro a 9 Flip Flop 
--e' realizzato in forma compatta
--si include la libreria
library IEEE;
--si include il modulo di interesse della libreria
use IEEE.std_logic_1164.all;
--componente usato per immagazzinare le nove cifre con cui lavorera' il sommatore
--in particolare salvera' il risultato che si genera' dal carry select ad otto bit.
--Si ha la necessita' di avere un registro a nove bit perche',dalla somma tra due operandi
--ad otto cifre, potrebbe generarsi, come risultato, un numero a nove cifre.

Entity Register9 is 
--ingressi:
--d vettore da 9 celle,clock,clear;
--uscite:
--q vettore di uscita da 9 celle;
	port(d : in std_logic_vector(8 downto 0);
		 clock,clear: in std_logic;
		 q : out std_logic_vector(8 downto 0)
	);
end Register9;

Architecture MyRegistro of Register9 is

	begin
	process(clock,clear)
			begin
			if clear = '1' then
				  q <= "000000000";
			elsif clock'event and clock = '1' then
						q <= d;
			end if;
	end process;
end MyRegistro;



