--FlipFlop std_logic
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--Questo componente lavora ad 1 bit.
--ingressi:
--input d,segnale di clock,segnale di clear;
--uscite:
--uscita q;
Entity FlipFlop is 
	
	port(d,clock,clear: in std_logic;
			 q: out std_logic
	);
	
end FlipFlop;

--definizione dell'architettura

Architecture MyFF of FlipFlop is
--esplicita il comportamento dell'unita' flip flop
	begin
	--sensitivity list: clock e clear
		process(clock,clear)
			begin
			--se si verifica che clear e' pari ad 1, 
			--lo stato di uscita del flip flop si azzera
				if clear = '1' then
					  q <= '0';
			--se invece si verifica che e' lo stato del clock
			--ad essere pari ad 1, allora lo stato di uscita assume lo stato
			--che e' stato ricevuto in ingresso
				elsif clock'event and clock = '1' then
										 q <= d; 
				end if; 
		end process;
end MyFF;		    
	
