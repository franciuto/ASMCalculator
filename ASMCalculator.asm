; Francesco Fontanesi XX/XX/XX
; Consegna

.model SMALL
.stack 100h
.data
; Variabili
; Dati
   op_input              db          12, ?, 11 dup('$')       ; Limito l'input a (16 bit number) + (operator) + (16 bit number)
   input_counter         dw          0                        ; Variabile per contenere l'indice di input
   result                dw          0                        ; Variabile d'appoggio per conversioni
   op1                   dw          0                        ; Operando 1
   op2                   dw          0                        ; Operando 2
   op                    db          1, 1 dup(0)              ; Operazione da svolgere
   int_lenght            db          2, 1 dup(0)              ; Variabile per salvare la lunghezza del primo numero
   
; Stringhe
   welcome               db          'Calcolatrice - Operatori supportati +,-,*,/,^,!,&,|,r (sqrt) $'
   divider               db          10,13, '-----------------------------------------------------------$'  
   error                 db          10, 13, 'ERROR!!$'    
   counter_string        db          10, 13, 7 dup('$')       ; Variabile per salvare il counter input come variabile salvabile
   result_string         db          8, ?, 7 dup('$')         ; Variabile per salvare i risultati delle operazioni
   result_is             db          10, 13, '= $'            ; Variabile per stampare l'uguale 
   
      
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
rerun:                                 ; Punto di ingresso per eseguire nuovamente il programma dopo che un'operazione è terminata
; INIZIALIZZAZIONE VARIABILI 
   ; Inizializza result_string
   lea si, result_string+2             ; SI punta al terzo byte
   mov cx, 7                           ; Conta 7 byte
   init_loop:                        
       mov byte ptr [si], '$'          ; Imposta il byte corrente a '$'
       inc si                          ; Passa al byte successivo
       loop init_loop                  ; Ripeti fino a che CX = 0
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
   je case_sub
   cmp op , '*'
   je case_mul 
   cmp op , '/'
   je case_div
   cmp op , '^'
   je case_pow 
   cmp op , 'r'
   je case_sqrt
   cmp op , '!'
   je case_fact
   cmp op , '&'
   je case_and
   cmp op , 'x'
   je case_exit

   

; GESTIONE OPERAZIONI
   ; Somma
      case_sum:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationSum             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato  
         
   ; Sottrazione
      case_sub:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationSub             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato 
         
   ; Moltiplicazione
      case_mul:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationMul             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato
         
   ; Divisione
      case_div:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationDiv             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato
         
   ; Potenza
      case_pow:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationPow             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato
   
   ; Radice quadrata
      case_sqrt:
         push op1                      ; Push primo operando in stack
         call operationSqrt            ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato
   
   ; Fattoriale
      case_fact: 
         push op1                      ; Push primo operando in stack
         call operationFact            ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato 
  
   ; And
      case_and:
         push op1                      ; Push primo operando in stack
         push op2                      ; Push secondo operando in stack
         call operationAnd             ; Chiamata della procedura
         jmp print_res                 ; Al ritorno della procedura vado a stampare il risultato
         
                    
   ; Uscita dal programma
      case_exit:
         jmp fine 

   

   
   
; STAMPA RISULTATO
print_res:
   ; Stampa uguale
      mov ah , 9h 
      lea dx , result_is
      int 21h
   ; Stampa numero
      lea dx , result_string
      int 21h
jmp rerun                              ; Rerun per mettere la prossima operazione
                                       
           



; Procedure           
; ------------------------------------------------------------------------------------------------------------------------------------
 
 
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
   jmp rerun
   ret
errorPrinter endp 




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


; Procedura - operationAnd
   ; Procedura che esegue l'operazione and bitwise tra due numeri
   
   ; - Parametri - 
   ; 
   
operationAnd proc
     
operationAnd endp
fine:                                                                    
   hlt      
