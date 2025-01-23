; Procedura - operationMul
   ; Procedura che esegue la moltiplicazione di due numeri unsigned 16 bit passati tramite stack
   
   ; - Parametri -
   ; Operando 1 = Passato tramite stack e salvato in bx
   ; Operando 2 = Passato tramite stack e salvato in ax
   
   ; - Return -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile

operationMul proc
   ; Salvataggio dati
      pop di                          ; Salvo indirizzo di ritorno in di
      pop ax                          ; Salvo il secondo operando in ax
      pop bx                          ; Salvo il primo operando in bx   
   ; Moltiplicazione
      mul bx                          ; Risultato in ax
   ; Conversione 
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di                         ; Ripristino indirizzo di ritorno
      ret
operationMul endp
