; Francesco Fontanesi XX/XX/XX
; Consegna

.model SMALL
.stack 100h
.data
; Variabili
; Dati
   op_input              db          12, ?, 11 dup('$')                  ; Limito l'input a (16 bit number) + (operator) + (16 bit number)
   input_counter         dw          0                                   ; Variabile per contenere l'indice di input
   result                dw          0                                   ; Variabile d'appoggio per conversioni
   op1                   dw          0                                   ; Operando 1
   op2                   dw          0                                   ; Operando 2
   op                    db          1, 1 dup(0)                         ; Operazione da svolgere
   int_lenght            db          2, 1 dup(0)                         ; Variabile per salvare la lunghezza del primo numero
   
; Stringhe
   welcome               db          'Calcolatrice - Operatori supportati +,-,*,/,^,!,&,|,...$'
   divider               db          10,13, '-----------------------------------------------------------$'  
   error                 db          10, 13, 'ERROR!!'    
   counter_string        db          10, 13, 5 dup('$')                  ; Variabile per salvare il counter input come variabile salvabile 
      
.code
main proc
; Caricamento data segment
   mov ax , @data
   mov ds , ax

; INTRO
   ; Welcome
      mov ah , 9h
      lea dx , welcome
      int 21h
   ; Text Divider
      lea dx , divider
      int 21h

; INPUT PROMPT
   ; Incremento prompt counter      
      inc input_counter                ; Incremento l'input counter per tenere traccia delle operazioni inserite
      mov ax , input_counter           ; Sposto in ax il counter
      lea si , counter_string + 2      ; Salvo l'indirizzo della stringa + 2 in SI (per la funzione)
      mov result , 0                   ; Inizializzo il result
      call getString                   ; Chiamo la procedura per la conversione da intero a stringa
   ; Stampa counter
      mov ah , 9h                   
      lea dx , counter_string 
      int 21h
   ; Stampa parentesi
      mov ah , 2h
      mov dl , ']'
      int 21h
   ; Stampa spazio 
      mov dl , ' '
      int 21h
 
; RICHIESTA INPUT
   ; Input
      mov ah , 0ah
      lea dx , op_input
      int 21h
      
; ANALISI INPUT
   ; Setup getInt                      
      lea si , op_input                ; Carico l'offset dell'operando in si (per la procedura)                                  
      mov result , 0                   ; Reset di result    
   ; Chiamata getInt per op1
      call getInt                      ; Chiamo la procedura per ottenere il primo operando
      mov ax , result                  ; Salvo l'output della procedura in ax
      mov op1, ax                      ; Sposto il risultato in op1
   ; Chiamata getOperator                
      call getOperator                 ; Chiamo la procedura per estrarre l'operatore
   ; Setup getInt
      dec si                           ; Decremento si (debug)
      mov result , 0                   ; Reset di result 
   ; Chiamata getInt per op2
      call getInt                      ; Chiamo la procedura per ottenere il secondo numero
      mov ax , result                  ; Salvo il risultato della procedura in ax
      mov op2, ax                      ; Sposto il risultato in op2
         
; SCELTA OPERAZIONE
   cmp op , '+'
   je case_sum
   cmp op , '-'
   je case_subtraction
   cmp op , '*'
   je case_operation
   cmp op , '/'
   je case_division






case_sum:
case_subtraction:
case_division:
case_power:
case_root:
case_factorial:
case_or:
case_and:    
                 
           



; Procedure           
; ------------------------------------------------------------------------------------------------------------------------------------
 
 
; PROCEDURA - getString
   ; Procedura per la trasformazione di un'intero in una striinga
   
   ; - Parametri -
   ; Numero intero = Passato tramite una variabile il cui offset è passato in AX
   ; Output in stringa = Scambiato tramite una variabile il cui indirizzo è passato in SI 
   
   ; - Return -  
   ; La variabile ritorna quando termina la conversione
  
getString proc
   mov bx , 10                      ; Salvo il divisore
   xor cx , cx
   xor dx , dx  
      
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
      inc si
      loop string_composer
      mov result, dx 
   ret  
getString endp   


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


; Procedura - errorPrinter
   ; Procedura che stampa "ERORR!!" se chiamata
   
   ; - Parametri -
   ; Nessuno
   
   ; - Return -
   ; Alla fine della stampa
   
errorPrinter proc
   mov ah , 9h
   lea dx , error
   int 21h
   ret
errorPrinter endp 


fine:
ret 
