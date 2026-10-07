; PROCEDURE - operationSqrt
   ; Finds the square root of a number passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in BX
   
   ; - Return -
   ; Returns when the result has been converted to a printable string

operationSqrt proc
   ; Save data
      xor ax , ax
      pop di                          ; Save the return address in DI
      pop bx                          ; Save the first operand in BX
   ; Calculation
      mov cx , 1                      ; CX = 1 for successive odd-number subtractions
      sqrt_loop:
         sub bx, cx                   ; Subtract the current odd number
         jl done                      ; Exit the loop if BX < 0
         add cx, 2                    ; Advance to the next odd number
         inc ax                       ; Increment the square-root result
      jmp sqrt_loop                   ; Repeat
   done: 
   ; Conversion
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di
      ret 
operationSqrt endp
