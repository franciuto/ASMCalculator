; PROCEDURE - getOperator
   ; Retrieves the operator and stores it in a variable
   
   ; - Parameters -
   ; Complete user input = Passed through the "op_input" variable
   ; Operator = Stored by the procedure in the "op" variable
   
   ; - Return - 
   ; Returns when operator retrieval is complete
         
getOperator proc
   ; Initialization
      mov op , 0
   ; Get                           
      lea si , op_input            ; Load the input offset into SI
      mov bl , int_lenght          ; Load the number of digits in the first number into BL
      xor bh , bh                  ; Clear BH
      add si , bx                  ; Advance past the digits already read
      add si , 2                   ; Point to the correct value
      mov bx , [si]                ; Load the pointed-to value (operator) into BX
      mov op , bl                  ; Store the operator in the "op" variable
   ret     
getOperator endp
