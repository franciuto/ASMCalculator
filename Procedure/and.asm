; PROCEDURA - getString - Sirocchi e Shoaib
   ; Procedura per effettuare AND

   ; - Parametri -
      ; Numero intero = Passato tramite una variabile il cui offset e' passato in AX
      ; Secondo numero intero = passato tramite una variabile il cui offset e' passato in CX
      ; Output in stringa = Scambiato tramite una variabile il cui indirizzo e' passato in SI 

   ; - Return -
      ; La variabile ritorna quando termina l'operazione 

esegui_and proc
    ; Carica il valore di operando1 (da BX) in AX
		mov ax, [bx]           ; AX = BX (operando1)

    ; Carica il valore di operando2 (da CX) in BX
		mov cx, [di]           ; BX = di (operando2)

    ; Esegui l'operazione AND tra AX e BX
		and ax, cx             ; AX = AX AND BX

    ; Memorizza il risultato in [SI] (indirizzo di risultato)
		mov [si], ax           ; *SI = AX (salva il risultato in risultato)
	
	ret
esegui_and endp

