; PROCEDURA - getOperator
   ; Procedura che ottiene l'operazione da effettuare e la salva in una variabile
   
   ; - Parametri -
   ; Input completo utente = Scambiato tramite la variabile "op_input"
   ; Operatore = Salvato dalla procedura nella variabile "op"     
   
   ; - Return - 
   ; Ritorna quando termina l'operazione di get dell'operando
         
getOperator proc
   ; Inizializzazione
      mov op , 0
   ; Get                           
      lea si , op_input            ; Carico in si l'offset dell'input
      mov bl , int_lenght          ; Carico il numero di cifre del primo numero in bl                 
      xor bh , bh                  ; Pulisco bh
      add si , bx                  ; Aggiungo all'offset le cifre già scambiate 
      add si , 2                   ; Punto al valore corretto
      mov bx , [si]                ; Carico in bx il valore puntato (operatore)
      mov op , bl                  ; Salvo l'operatore nella variabile di scambio "op"
   ret     
getOperator endp
