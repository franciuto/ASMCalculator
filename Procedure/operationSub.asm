; Procedura - operationSub
   ; Procedura che esegue la sottrazione di due numeri 16 bit unsigned passati tramite stack
   
   ; - Parametri - 
   ; Operando 1 = Passato tramite lo stack e salvato in cx
   ; Operando 2 = Passato tramite lo stack e salvato in bx
   ; Risultato = Salvato nella variabile "result_string"
   
   ; - Return -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile

operationSub proc
   ; Salvataggio dati
      pop di                          ; Salvo indirizzo di ritorno in di
      pop cx                          ; Salvo il secondo operando in cx
      pop bx                          ; Salvo il primo operando in bx   
   ; Sottrazione
      sub bx , cx                     ; Faccio la sottrazione 
   ; Controllo signed
      jns valid_operation             ; Se l'operazione ha restituito un numero unsigned allora continua
      call errorPrinter               ; Altrimenti chiamo la procedura per scrivere errore ed eseguire nuovamente il programma 
   valid_operation:
   ; Conversione 
      mov ax , bx                     ; Salvo risultato in ax
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di                         ; Ripristino indirizzo di ritorno
      ret                                    
operationSub endp
