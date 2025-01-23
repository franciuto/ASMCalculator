;PROCEDURA - divisione - Sirocchi
   ; Procedura per eseguire la divisione  

   ; - Parametri -
      ; Primo operando sara' il dividendo 
      ; Secondo operando sara' il divisore   
      ; Output in stringa = Scambiato tramite una variabile il cui indirizzo e' passato in SI 

    ; - Return -
      ; La variabile ritorna quando termina l'operazione 

esegui_divisione proc
   
    mov ax, [bx]          ; AX = valore del dividendo
    mov cx, [di]          ; CX = valore del divisore (
   
    cmp cx, 0             ; Controlla se il divisore e' uguale a zero
    je divisione_impossibile  ; Salta se il divisore e' zero

    xor dx, dx            ; DX = 0 (necessario per la divisione a 16 bit)

    div cx                ; AX = quoziente, DX = resto

    mov [si], ax          ; Salva il quoziente in risultato (puntato da SI)
    jmp divisione_fine    ; Salta alla fine della divisione

divisione_impossibile:
    mov ah, 09h           ; Funzione per stampare una stringa
    lea dx, error         ; Carica l'indirizzo della stringa "error"
    int 21h               ; Chiama l'interrupt per stampare l'errore

divisione_fine:
    ret
esegui_divisione endp


