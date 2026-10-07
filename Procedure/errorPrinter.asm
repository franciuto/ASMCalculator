; PROCEDURE - errorPrinter
   ; Prints "ERROR!!" when called
   
   ; - Parameters -
   ; None
   
   ; - Return -
   ; Returns after printing
   
errorPrinter proc
   mov ah , 9h
   lea dx , error
   int 21h
   jmp rerun
   ret
errorPrinter
