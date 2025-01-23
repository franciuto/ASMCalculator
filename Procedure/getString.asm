; PROCEDURA - getString
   ; Procedura per la trasformazione di un'intero in una striinga
   
   ; - Parametri -
   ; Numero intero = Passato tramite AX
   ; Output in stringa = Scambiato tramite una variabile il cui indirizzo è passato in SI 
   
   ; - Return -  
   ; La variabile ritorna quando termina la conversione
  
getString proc
   mov bx , 10                      ; Salvo il divisore
   xor cx , cx                      ; Pulisco cx
   xor dx , dx                      ; Pulisco dx
      
   divisione:
      div bx                        ; Divisione tra ax e 10
      push dx                       ; Salvo il quoziente ossia la cifra che mi interessa sullo stack
      xor dx , dx                   ; Resetto per la prossima operazione
      inc cx                        ; Aumento per tenere conto di tutte le cifre pushate
      or ax , ax                    ; Controllo se il quoziente è zero
      jz string_composer            ; Se è zero tutte le cifre sono state pushate (vado alla composizione stringa)
      jmp divisione                 ; Altrimenti continuo a dividere
         
   string_composer:            
      pop dx                        ; Prelevo dallo stack salvando in dx (risalgo lo stack)
      add dl , '0'                  ; Converto in ascii
      mov [si] , dl                 ; Aggiungo in stringa
      inc si                        ; Passo al prossimo byte della stringa
      loop string_composer          
      mov result, dx                ; Salvo risultato in dx
   ret  
getString endp   
