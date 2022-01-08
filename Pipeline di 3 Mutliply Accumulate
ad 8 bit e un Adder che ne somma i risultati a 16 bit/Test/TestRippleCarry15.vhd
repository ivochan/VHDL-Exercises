--Test Ripple Carry a 15 bit
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test

Entity TestRippleCarry15 is
end TestRippleCarry15;

Architecture TRC15 of TestRippleCarry15 is


--segnali usati
signal ia,ib :std_logic_vector(14 downto 0);
signal us :std_logic_vector(14 downto 0);
signal icin,ucout : std_logic;

--si definisce il componente 
component RippleCarry15 is
--ingressi:
--a vettore di 15 bit, b vettore di 15 bit;
--cin, riporto in ingresso al ripple carry, di tipo bit;
--uscite:
--s vettore di 16 bit, e' il risultato della somma tra i due numeri a 15 bit, a e b;
--cout, riporto in uscita dal ripple carry, di tipo bit;

port( 
	 a,b: in std_logic_Vector(14 downto 0);
      	 cin: in std_logic;	
     	 s: out std_logic_Vector(14 downto 0);--15 bit
         cout: out std_logic);
	 
	 
end component;

--simulazione

begin


inputs:
process
	begin
	icin<='0';
	ia<="000000000000000";
	ib<="000000000000001";
	wait for 30 ns;
	ia<="111111110000000";
	icin<='1';
	wait for 30 ns;
	ia<="001110000110000";
	wait for 60 ns;
end process;

circuito: RippleCarry15 port map(ia,ib,icin,us,ucout);

end TRC15;
