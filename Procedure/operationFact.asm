; Procedura - operationFact
   ; Procedura che calcola il fattoriale di un numero passato tramite stack
   
   ; - Parametri - 
   ; Operando 1 = Passato tramite stack e salvato in cx
   
   ; - Return -
   ; La procedura ritorna al termine della conversione 

operationFact proc
   ; Salvataggio dati
      mov ax , 1
      pop di                          ; Salvo indirizzo di ritorno in di
      pop cx                          ; Salvo il primo operando in cx  
   ; Calcolo
      fattoriale_loop:
          cmp cx, 0                   ; Controlla se CX e' 0
          je fine_fattoriale          ; Se CX e' 0, termina il ciclo
              
          mul cx                      ; Moltiplica cx per ax 
          dec cx                      ; Decrementa CX
          jmp fattoriale_loop         ; Ripeti il ciclo
   fine_fattoriale:
   ; Conversione
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di
      ret       
operationFact endp  
