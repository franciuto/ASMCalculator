; Procedura - operationSqrt
   ; Procedura che trova la radice quadrata di un numero in stack
   
   ; - Parametri - 
   ; Operando 1 = Passato tramite stack e salvato in bx
   
   ; - Return -
   ; Ritorna quando il risultato è stato convertito in stringa stampabile

operationSqrt proc
   ; Salvataggio dati
      xor ax , ax
      pop di                          ; Salvo indirizzo di ritorno in di
      pop bx                          ; Salvo il primo operando in bx  
   ; Calcolo
      mov cx , 1                      ; cx = 1 per sottrazioni dispari
      sqrt_loop:
         sub bx, cx                   ; Sottraggo 1 da ax
         jl done                      ; Se bx < 0 esco dal loop  
         add cx, 2                    ; Incremento al prossimo numero dispari
         inc ax                       ; Incremento risultato della radice quadrata
      jmp sqrt_loop                   ; Ripeto
   done: 
   ; Conversione
      lea si , result_string + 2      ; Carico l'indirizzo della variabile risultato
      call getString                  ; Converto da intero a stringa
   ; Ritorno
      push di
      ret 
operationSqrt endp
