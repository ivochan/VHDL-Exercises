--Test Ripple Carry ad 8 bit
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestRippleCarry8 is
end TestRippleCarry8;

Architecture TRC8 of TestRippleCarry8 is


--segnali usati
signal ia,ib :std_logic_vector(7 downto 0);
signal us :std_logic_vector(7 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente 
component  RippleCarry8 is
--ingressi:
--a vettore di 8 bit, b vettore di 8 bit;
--uscite:
--s vettore di 9 bit, e' il risultato della somma tra i due numeri a 9 bit a e b;
--cout, riporto in uscita dal ripple carry
	port( 
		a,b: in std_logic_Vector(7 downto 0);
		cin: in std_logic;
     		s: out std_logic_Vector(7 downto 0);
      		cout: out std_logic);
end component;

--simulazione

begin


inputs:
process
	begin
	icin<='0';
	ia<="00000000";
	ib<="00000001";
	wait for 30 ns;
	ia<="11111000";
	icin<='1';
	wait for 30 ns;
	ia<="00110011";
	wait for 60 ns;
end process;

somma: RippleCarry8 port map(ia,ib,icin,us,ucout);

end TRC8;
