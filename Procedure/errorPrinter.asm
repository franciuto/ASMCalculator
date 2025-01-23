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
errorPrinter