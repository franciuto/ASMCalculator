; Procedura - operationDiv
   ; Procedura che esegue la divisione di due numeri unsigned 16 bit passati tramite stack
   
   ; - Parametri - 
   ; Operando 1 = Passato tramite stack e salvato in ax
   ; Operando 2 = Passato tramite stack e salvato in bx
   
   ; - Return -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile

operationDiv proc 
   ; Salvataggio dati
      pop di                          ; Salvo indirizzo di ritorno in di
      pop bx                          ; Salvo il secondo operando in bx
      pop ax                          ; Salvo il primo operando in ax   
   ; Divisione 
      div cx
   ; Conversione parte intera
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di
      ret 
operationDiv endp 
