; PROCEDURE - operationSub
   ; Subtracts two 16-bit unsigned numbers passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in CX
   ; Operand 2 = Passed on the stack and stored in BX
   ; Result = Stored in the "result_string" variable
   
   ; - Return -
   ; Returns when the result has been converted to a printable string

operationSub proc
   ; Save data
      pop di                          ; Save the return address in DI
      pop cx                          ; Save the second operand in CX
      pop bx                          ; Save the first operand in BX
   ; Subtraction
      sub bx , cx                     ; Subtract the operands
   ; Signedness check
      jns valid_operation             ; Continue if the operation produced an unsigned number
      call errorPrinter               ; Otherwise print an error and run the program again
   valid_operation:
   ; Conversion
      mov ax , bx                     ; Save the result in AX
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di                         ; Restore the return address
      ret                                    
operationSub endp
