--Test SOMMATORE 
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestSommatore is
end TestSommatore;

Architecture TS of TestSommatore is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='1';--segnale di clear 
--segnali usati
signal ia,ib,ic :std_logic_vector(7 downto 0);
signal us :std_logic_vector(8 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente CarrySelect8
component Sommatore is

	port( 
		a,b,c: in std_logic_Vector(7 downto 0);
     	 	cin: in std_logic;	
		clock,clear:in std_logic;
    		  s: out std_logic_Vector(8 downto 0);
    		  cout: out std_logic);
end component;

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
		wait for 60 ns;
		iclear <= '1';
		wait for 1 ns;
		iclear<='0';
		wait for 90 ns;
end process;

--si scrive il process relativo agli altri ingressi
inputs:
--si useranno tre operandi ad otto bit ed il riporto iniziale cin
--i calori attesi saranno cout, che e' il riporto finale
--e la somma s a nove bit
process
	begin
--1)cout=0,s=0  1010 0001
	icin<='0';
	ia<="00000000";
	ib<="00000001";
	ic<="10100000";
	wait for 10 ns;
--2)cout=1,s=0  1010 0000
	icin<='1';
	ia<="11111110";
	ib<="00000001";
	ic<="10100000";
	wait for 10 ns;
--3)cout=1,s=0  1000 0000
	ib<="10000000";
	ic<="00000001";
	wait for 10 ns;
--4)cout=1,s=0  0100 0010
	icin<='0';
	ia<="01111111";
	ib<="00000011";
	ic<="11000000";
	wait for 10 ns;
--5)cout=1,s=0  0010 0001
	ia<="10001001";
	ib<="01110111";
	ic<="00100001";
	wait for 10 ns;
--6)cout=1,s=0  0010 0010
	icin<='1';
	wait for 10 ns;
--7)cout=1,s=0  1000 1001
	ib<="00000000";
	ic<="11111111";
	wait for 10 ns;
--8)cout=1,s=0  1000 1001
	ia<="10001001";
	ib<="01110111";
	ic<="00100001";
	wait for 10 ns;
--9)cout=1,s=0  1010 1001
	icin<='0';
	ia<="10101010";
	ib<="10101010";
	ic<="01010101";
	wait for 10 ns;
--10)cout=0,s=0  1010 1011
	icin<='1';
	ia<="00101010";
	ib<="00101011";
	wait for 10 ns;
end process;

circuito: Sommatore port map(ia,ib,ic,icin,iclock,iclear,us,ucout);

end TS;
