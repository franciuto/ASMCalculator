;PROCEDURA - moltiplicazione - Sirocchi
   ; Procedura per eseguire la moltiplicazione  

   ; - Parametri -
   ; Primo operando sara' il moltiplicando
   ; Secondo operando sara' il moltiplicatore   
   ; Output in stringa = Scambiato tramite una variabile il cui indirizzo e' passato in SI 

   ; - Return -
   ; La variabile ritorna quando termina l'operazione 


esegui_moltiplicazione proc
    mov ax, [bx]          ; AX = valore del primo operando (moltiplicando)
    mov cx, [di]          ; CX = valore del secondo operando (moltiplicatore)

    mul cx                ; Moltiplica AX per CX, il risultato viene memorizzato in AX (parte bassa)

    mov [si], ax          ; Salva il risultato (parte bassa) in risultato
    jmp moltiplicazione_fine    ; Salta alla fine della moltiplicazione

moltiplicazione_fine:
    ret
esegui_moltiplicazione endp

