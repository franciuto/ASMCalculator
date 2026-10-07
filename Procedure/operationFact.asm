; PROCEDURE - operationFact
   ; Calculates the factorial of a number passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in CX
   
   ; - Return -
   ; Returns after the conversion is complete

operationFact proc
   ; Save data
      mov ax , 1
      pop di                          ; Save the return address in DI
      pop cx                          ; Save the first operand in CX
   ; Calculation
      fattoriale_loop:
          cmp cx, 0                   ; Check whether CX is 0
          je fine_fattoriale          ; If CX is 0, end the loop
              
          mul cx                      ; Multiply AX by CX
          dec cx                      ; Decrement CX
          jmp fattoriale_loop         ; Repeat the loop
   fine_fattoriale:
   ; Conversion
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di
      ret       
operationFact endp  
