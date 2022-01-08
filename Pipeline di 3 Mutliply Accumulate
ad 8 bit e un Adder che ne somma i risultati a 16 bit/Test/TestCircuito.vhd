--Test del circuito
--si importa la libreria
library IEEE;
--si include il modulo di intresse della libreria
use  IEEE.std_logic_1164.all;
--entita' vuota
Entity TestCircuito is
end TestCircuito;
--definizione dell'architettura
Architecture TC of TestCircuito is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='1';--segnale di clear 

--segnali usati
signal ia,ifa,ib,ifb,ic,ifc :std_logic_vector(7 downto 0);
signal us :std_logic_vector(16 downto 0);
signal ucout : std_logic;

--si definisce il componente circuitale da testare
component CircuitoMulSum is
	port(
		a,fa,b,fb,c,fc: in std_logic_vector(7 downto 0);
		clock,clear:in std_logic;
		risultato: out std_logic_vector(16 downto 0);
		riporto: out std_logic
	);
end component;

--attivita'
begin
--si scrive il process relativo al segnale di clock
clock:
process 
	begin
	loop
		wait for 5 ns;
		iclock<= not iclock;
	end loop;
end process;

--si scrive il process relativo al segnale di clear
clear:
process 
	begin
		iclear<= '0';
		wait for 200 ns;
end process;

--si scrive il process relativo agli altri ingressi
inputs:
--si useranno tre operandi ad otto bit ed il riporto iniziale cin
--i valori attesi saranno cout, che e' il riporto finale
--e la somma s a nove bit
process
	begin
--1)
	 ia<="00000000";
	ifa<="00000010";
	 ib<="00000001";
	ifb<="10000011";
	 ic<="10100000";
	ifc<="11100000";
	wait for 10 ns;
--2)
	 ia<="11111110";
	ifa<="10000000";
	 ib<="00000001";
	ifb<="11111111";
     ic<="10100000";
	ifc<="01010101";
	wait for 10 ns;
--3)
	 ia<="10101010";
	ifa<="01010101";
	 ib<="10000000";
	ifb<="00000000";
	 ic<="00000001";
	ifc<="00001111";
	wait for 10 ns;
--4)
	 ia<="01111111";
	ifa<="11000000";
	 ib<="00000011";
	ifb<="00110011";
	 ic<="11000000";
	ifc<="11001100";
	wait for 10 ns;
--5)
	 ia<="10001001";
	ifa<="00000100";
	 ib<="01110111";
	ifb<="10000001";
	 ic<="00100001";
	ifc<="10101010";
	wait for 10 ns;
--6)
	 ia<="00100000";
	ifa<="00010010";
	 ib<="00001001";
	ifb<="10000001";
	 ic<="10100001";
	ifc<="11000000";
	wait for 10 ns;
--7)
	 ia<="01000000";
	ifa<="10000000";
	 ib<="00000000";
	ifb<="01111111";
	 ic<="11111111";
	ifc<="11111110";
	wait for 10 ns;
--8)
	 ia<="10001001";
	ifa<="01111110";
	 ib<="01110111";
	ifb<="00001111";
	 ic<="00000000";
	ifc<="00100001";
	wait for 10 ns;
--9)
	 ia<="10101010";
	ifa<="11111111";
	 ib<="10101010";
	ifb<="00001000"; 
	 ic<="01010101";
	ifc<="11111011";
	wait for 10 ns;
--10)
	 ia<="00101010";
	ifa<="00000011";
	 ib<="00101011";
	ifb<="10010010";
	 ic<="11010111";
	ifc<="01110110";
	wait for 10 ns;
	
end process;

circuito: CircuitoMulSum 
		port map(ia,ifa,ib,ifb,ic,ifc,iclock,iclear,us,ucout);

end TC;
