; PROCEDURE - getInt
   ; Converts digits in a string to a 16-bit unsigned integer
   
   ; - Parameters -
   ; Source string = Stored in a variable whose offset is passed in SI
   ; Converted integer = Stored in the 'result' variable
   
   ; - Return -
   ; Returns when the current value is not a digit:
   ; when it is lower than '0', or higher than '9'.
   

getInt proc
   add si , 2                      ; Advance SI by 2 to the variable's first useful value
   mov int_lenght , 0              ; Initialize the first operand length variable
   
   analisi:
      cmp [si] , '0'               ; Compare the current character with the ASCII code for 0
      jae is_above0                ; If it is greater than or equal to '0', perform another check
      ret                          ; Otherwise, it is not a number; return
   
   is_above0:
      cmp [si] , '9'               ; If it is also lower than or equal to '9', it is a digit
      jbe is_number                ; The value is a number; continue
      ret                          ; Otherwise, it is not a number; return
      
   is_number:
      inc int_lenght               ; Track how many digits have been converted
      mov bx , 10                  ; Set the multiplier
      xor ah , ah                  ; Clear AH
      mov al , [si]                ; Move the character to AX for conversion
      sub al , '0'                 ; Convert to decimal
      mov cx , ax                  ; Move the current number to CX
      mov ax , result              ; Load the accumulated result into AX
      mul bx                       ; AX = AX * 10 (shift digits left)
      add ax , cx                  ; Add the new digit as the units value
      mov result , ax              ; Store the new result
      inc si                       ; Move to the next character
      jmp analisi                  ; Analyze the next character
getInt endp
