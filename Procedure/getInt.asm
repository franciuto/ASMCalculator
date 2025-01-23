; PROCEDURA - getInt
   ; Procedura per la trasformazione di soli numeri contenuti in una stringa in un'intero unsigned massimo 16 bit
   
   ; - Parametri -
   ; Stringa da trasformare = Salvata in una variabile il cui offset è passato in SI
   ; Numero intero trasformato = Salvato nella variabile 'result' 
   
   ; - Return -
   ; La procedura ritorna quando il valore analizzato non è più un numero
   ; Se il valore è minore di '0'
   ; Se il valore è maggiore di '0' ma non minore di '9'
   
getInt proc
   add si , 2                      ; Incremento SI di 2 per andare al primo valore utile della variabile
   mov int_lenght , 0              ; Inizializzazione variabile lunghezza operatore1   
   
   analisi:
      cmp [si] , '0'               ; Faccio un controllo tra il contenuto dell'offset (numero da analizzare) e il codice ascii dello 0
      jae is_above0                ; Se il valore è maggiore uguale a '0' allora passo ad un'altro controllo
      ret                          ; Se il valore non è maggiore di 0 allora non è sicuramente un numero (return)
   
   is_above0:
      cmp [si] , '9'               ; Se il valore è anche minore di '9' allora è indubbiamente un numero
      jbe is_number                ; Il valore è un numero, salto al codice successivo
      ret                          ; Se il valore è maggiore di 0 ma non minore di 9 allora non è sicuramente un numero (return)
      
   is_number:
      inc int_lenght               ; Tengo traccia di quanti numeri sono stati convertiti  
      mov bx , 10                  ; Muovi il divisore
      xor ah , ah                  ; Pulisco ah
      mov al , [si]                ; Sposta in ax il contenuto della variabile (Numero da convertire)
      sub al , '0'                 ; Converti in decimale 
      mov cx , ax                  ; Sposta il numero corrente in CX
      mov ax , result              ; Carico il risultato definitivo in AX
      mul bx                       ; ax = ax * 10 (sposta a sinistra le cifre)
      add ax , cx                  ; Somma il nuovo numero come unità
      mov result , ax              ; Salva il nuovo risultato
      inc si                       ; Passa al prossimo carattere
      jmp analisi                  ; Quando il carattere attuale è stato convertito si procede con l'analisi stringa
getInt endp
