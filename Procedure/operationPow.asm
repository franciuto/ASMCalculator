; PROCEDURE - operationPow
   ; Raises a number to a power using parameters passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in AX
   ; Operand 2 = Passed on the stack and stored in CX
   
   ; - Return -
   ; Returns when the result has been converted to a printable string

operationPow proc
   ; Save data
      pop di                          ; Save the return address in DI
      pop bx                          ; Save the second operand (exponent) in CX
      pop ax                          ; Save the first operand (base) in AX
   ; Exponent
      dec cx                          ; Decrement the exponent
      mov bx , op1                    ; Copy the base to BX
      mult_loop:                      ; Calculate the power
         mul bx                       
         loop mult_loop
   ; Conversion
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di
      ret 
operationPow endp   
