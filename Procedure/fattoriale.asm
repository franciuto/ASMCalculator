
;PROCEDURA - fattoriale - Sirocchi
   ; Procedura per eseguire il fattoriale 

    ; - Parametri -
    ; Operatore per eseguire il fattoriale 
    ; Output in stringa = Scambiato tramite una variabile il cui indirizzo e' passato in SI 

    ; - Return -
    ; La variabile ritorna quando termina la conversione
    
esegui_fattoriale proc
    mov ax, 1            ; Inizializza AX con 1 (fattoriale di 0 e' 1)
    mov cx, [bx]         ; Carica il valore dell'operando in CX (contatore)

fattoriale_loop:
    cmp cx, 0            ; Controlla se CX e' 0
    je fine_fattoriale   ; Se CX e' 0, termina il ciclo
        
    mul cx               ; moltiplica cx per ax 
    dec cx               ; Decrementa CX
    jmp fattoriale_loop  ; Ripeti il ciclo

fine_fattoriale:

    mov [si], ax 

endp




