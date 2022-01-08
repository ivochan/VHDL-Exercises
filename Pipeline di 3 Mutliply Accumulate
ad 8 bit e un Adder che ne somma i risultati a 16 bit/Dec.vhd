--modulo che si occupa di decodificare le terne ricevute 
--secondo la tabella di CODIFICA DI BOOTH
--si include la libreria
library IEEE;
--si include il package di interesse della libreria
use IEEE.std_logic_1164.all;
--definizione dell'entita'
Entity Dec is
--riceve in ingresso tre bit e 
--restituisce un numero in base 
--ai valori stabiliti dalla tabella di Booth
	port(
		i: in std_logic_vector(2 downto 0);
		u: out std_logic_vector(2 downto 0)
	);
--l'uscita in pratica sara' il selettore del mux a cinque ingressi
end Dec;

--definizione del comportamento di questo componente
Architecture MyD of Dec is
--operazioni
--in base al valore del digit verra' mandato in output
--quello che sara' il valore del selettore dei mux a cinque ingressi
--l'uscita sara':
--"000", che comporta l'uscita a come "00000000";
--"001" che comporta l'uscita b come "moltiplicatore";
--"010" che comporta l'uscita c come "- moltiplicatore";
--"011" che comporta l'uscita d come "2 per moltiplicatore";
--"100" che comporta l'uscita e come "-2 per moltiplicatore";
	begin 
	
		with i select--e' il segnale di controllo
			--assegnamento
			u <=
			--scelta 	
			"000" when "000" | "111",  --prodotto parziale = 0, digit pari a 0
	
			"001" when "001" | "010",  --prodotto parziale = moltiplicatore, digit pari a 1
	
			"010" when "101" | "110",  --prodotto parziale = - moltiplicatore, digit pari a -1
	
			"011" when "011",  --prodotto parziale = due volte moltiplicatore, digit pari a 2
	
			"100" when "100",  --prodotto parziale = - due volte moltiplicatore, digit pari a -2

			"XXX" when others; --altri casi
		--fine blocco
end MyD;
	
