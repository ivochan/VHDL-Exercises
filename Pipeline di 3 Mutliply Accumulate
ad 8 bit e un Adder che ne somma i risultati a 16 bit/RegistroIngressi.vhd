--Registro che effettua il cambio
--dei bit piu' significativi degli ingressi ricevuti
--dal circuito da realizzare nel valore '0'

--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--entita'
Entity RegistroIngressi is
--REGISTRO DI CAMBIO BIT SIGNIFICATIVO
--riceve in ingresso un vettore di otto bit
--ne cambia il bit piu' significativo,
--quello in posizione 7 e salva tutto in 
--un vettore ad otto bit
	port(
		i: in std_logic_vector(7 downto 0);
		clock,clear: in std_logic;
		u: out std_logic_vector(7 downto 0)
	);
end RegistroIngressi;

--architettura
Architecture MyRI of RegistroIngressi is

--si assegna l'ingresso modificato
--nel vettore di uscita

begin
--inizio delle operazioni

u(7)<='0';  --si effettua il cambio del bit in posizione 7
u(6)<=i(6);
u(5)<=i(5);
u(4)<=i(4);
u(3)<=i(3);
u(2)<=i(2);
u(1)<=i(1);
u(0)<=i(0);


end MyRI;
