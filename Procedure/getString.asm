; PROCEDURE - getString
   ; Converts an integer to a string
   
   ; - Parameters -
   ; Integer = Passed through AX
   ; String output = Written through a variable whose address is passed in SI
   
   ; - Return -  
   ; Returns when the conversion is complete
  
getString proc
   mov bx , 10                      ; Store the divisor
   xor cx , cx                      ; Clear CX
   xor dx , dx                      ; Clear DX
      
   divisione:
      div bx                        ; Divide AX by 10
      push dx                       ; Push the remainder, which is the needed digit, onto the stack
      xor dx , dx                   ; Reset for the next operation
      inc cx                        ; Count all pushed digits
      or ax , ax                    ; Check whether the quotient is zero
      jz string_composer            ; If so, all digits have been pushed; compose the string
      jmp divisione                 ; Otherwise, keep dividing
         
   string_composer:            
      pop dx                        ; Pop from the stack into DX
      add dl , '0'                  ; Convert to ASCII
      mov [si] , dl                 ; Append to the string
      inc si                        ; Move to the next string byte
      loop string_composer          
      mov result, dx                ; Store the result in DX
   ret  
getString endp   
