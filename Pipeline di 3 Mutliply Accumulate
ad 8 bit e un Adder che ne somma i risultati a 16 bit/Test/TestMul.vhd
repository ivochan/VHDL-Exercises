--Test del Moltiplicatore
--si importa la libreria
library IEEE;
--si include il package che si vuole usare
use IEEE.std_logic_1164.all;

--descrizione della classe di test
Entity TestMul is
end TestMul;

Architecture TM of TestMul is

--segnali usati
signal ia,ib :std_logic_vector(7 downto 0);
signal up:std_logic_vector(15 downto 0);

--componente da testare
component MulBooth is
--porte coinvolte
	port(
		 a,b: in std_logic_vector(7 downto 0);--otto bit
		 p: out std_logic_vector(15 downto 0)--sedici bit
		);
		
end component;

begin
--gli ingressi del moltiplicatore avreanno tutti, come bit piu' significativo 
--in ingresso il valore '0', perche' nel circuito complessivo e' cos' che quesot verra' cambiato
inputs:
process
	begin
	ia<="00000000";
	ib<="00000001";
	wait for 30 ns;
	ia<="01111110";
	ib<="00000001";
	wait for 30 ns;
	ia<="00111001";
	ib<="00010000";
	wait for 30 ns;
	ia<="00000000";
	wait for 30 ns;
	ia<="01111111";
	ib<="01111111";
	wait for 30 ns;
	ia<="00000001";
	wait for 60 ns;
end process;

moltiplicatore: MulBooth port map(ia,ib,up);

end TM;
