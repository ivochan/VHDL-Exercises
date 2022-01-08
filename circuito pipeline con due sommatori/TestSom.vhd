--Test SOMMATORE complessivo
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestSom is
end TestSom;

Architecture TS of TestSom is

--si inizializzano i valori che si vuole assumano i segnali
signal iclock : std_logic :='1';--segnale di clock
signal iclear : std_logic :='1';--segnale di clear 
--segnali usati
signal ia,ib,ic :std_logic_vector(15 downto 0);
signal us :std_logic_vector(15 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente CarrySelect8
component Sommatore is

	port( 
		a,b,c: in std_logic_Vector(15 downto 0);
     	 	cin: in std_logic;	
		clock,clear:in std_logic;
    		  s: out std_logic_Vector(15 downto 0);
    		  cout: out std_logic);
end component;

begin
--si scrive il process relativo al segnale di clock
clock:
process 
	begin
	loop
		iclock<='1';
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
--si useranno tre operandi ad 16 bit ed il riporto iniziale cin
--i calori attesi saranno cout, che e' il riporto finale
--e la somma s a 16 bit
process
	begin

--1)cout=, s=0 
	icin<='0';
	ia<="1000000000000000";
	ib<="0000000000000001";
	ic<="1010000000000000";
	wait for 10 ns;
--2)cout=, s=0  
	icin<='1';
	ia<="1111111000000000";
	ib<="0100000000000001";
	ic<="1110000000000000";
	wait for 10 ns;
--3)cout=, s=0  
	ia<="0000100000000000";
	ib<="1000000000000000";
	ic<="0000000000000001";
	wait for 10 ns;
--4)cout=, s=0  
	icin<='0';
	ia<="0111111111111111";
	ib<="0000000000000011";
	ic<="1100000000000000";
	wait for 10 ns;
--5)cout=, s=0  
	ia<="1000100000000001";
	ib<="0111000000000111";
	ic<="0010000000000001";
	wait for 10 ns;
--6)cout=, s=0  
	icin<='1';
	ia<="1000000000000000";
	ib<="0000000000000001";
	ic<="1000000000000001";
	wait for 10 ns;
--7)cout=, s=0  
	ia<="0000000000000001";
	ib<="0001000000000000";
	ic<="1111111111111111";
	wait for 10 ns;
--8)cout=, s=0  
	ia<="1000100000000001";
	ib<="0111000000000111";
	ic<="0010000000000001";
	wait for 10 ns;
--9)cout=1,s=0 
	icin<='0';
	ia<="1010101010101010";
	ib<="1010101010101010";
	ic<="0101010101010101";
	wait for 10 ns;
--10)cout=0,s=0 
	icin<='1';
	ia<="0000000000101010";
	ib<="0000000000101011";
	ic<="1100000000000000";
	wait for 10 ns;
end process;

circuito: Sommatore port map(ia,ib,ic,icin,iclock,iclear,us,ucout);

end TS;
