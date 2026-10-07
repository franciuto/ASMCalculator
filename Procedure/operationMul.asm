; PROCEDURE - operationMul
   ; Multiplies two 16-bit unsigned numbers passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in BX
   ; Operand 2 = Passed on the stack and stored in AX
   
   ; - Return -
   ; Returns when the result has been converted to a printable string

operationMul proc
   ; Save data
      pop di                          ; Save the return address in DI
      pop ax                          ; Save the second operand in AX
      pop bx                          ; Save the first operand in BX
   ; Multiplication
      mul bx                          ; Result in AX
   ; Conversion
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di                         ; Restore the return address
      ret
operationMul endp
