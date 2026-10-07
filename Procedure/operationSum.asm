; OPERATION PROCEDURES

; PROCEDURE - operationSum
   ; Adds two 16-bit unsigned operands passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in CX
   ; Operand 2 = Passed on the stack and stored in BX
   ; Result = Stored in the "result_string" variable
   
   ; - Return -
   ; Returns when the result has been converted to a printable string
  
operationSum proc
   ; Save data
      pop di                          ; Save the return address in DI
      pop bx                          ; Save the second operand in BX
      pop cx                          ; Save the first operand in CX
   ; Addition
      add bx , cx                     ; Add the operands (result in BX)
   ; Conversion
      mov ax , bx                     ; Save the result in AX
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di                         ; Restore the return address
      ret                               
operationSum endp 
