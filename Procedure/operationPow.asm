; Procedura - operationPow
   ; Procedura che esegue l'elevazione a potenza con parametri passati in stack
   
   ; - Parametri - 
   ; Operando 1 = Passato tramite stack e salvato in ax
   ; Operando 2 = Passato tramite stack e salvato in cx
   
   ; - Return -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile

operationPow proc
   ; Salvataggio dati
      pop di                          ; Salvo indirizzo di ritorno in di
      pop bx                          ; Salvo il secondo operando (esponente) in cx
      pop ax                          ; Salvo il primo operando (base) in ax   
   ; Esponente
      dec cx                          ; Decremento l'esponente
      mov bx , op1                    ; Copio la base in bx
      mult_loop:                      ; Calcolo la potenza
         mul bx                       
         loop mult_loop
   ; Conversione
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di
      ret 
operationPow endp   
