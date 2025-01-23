; PROCEDURE PER OPERAZIONI

; Procedura - operationSum
   ; Procedura che esegue la somma di due operandi 16 bit unsigned passati tramite stack
   
   ; - Parametri -
   ; Operando 1 = Passato tramite lo stack e salvato in cx
   ; Operando 2 = Passato tramite lo stack e salvato in bx
   ; Risultato = Salvato nella variabile "result_string"  
   
   ; - Ritorno -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile
  
operationSum proc
   ; Salvataggio dati
      pop di                          ; Salvo indirizzo di ritorno in di
      pop bx                          ; Salvo il secondo operando in bx
      pop cx                          ; Salvo il primo operando in cx   
   ; Somma
      add bx , cx                     ; Faccio la somma (Risultato in bx)
   ; Conversione 
      mov ax , bx                     ; Salvo risultato in ax
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di                         ; Ripristino indirizzo di ritorno
      ret                               
operationSum endp 
