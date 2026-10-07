; Francesco Fontanesi 01/24/2025 - ASSEMBLY CALCULATOR

; - Supported operations -
; The calculator can perform the following operations:
; 1) Addition
; 2) Subtraction
; 3) Multiplication
; 4) Division
; 5) Exponentiation
; 6) Factorial
; 7) Bitwise AND
; 8) Bitwise OR
; 9) Square root

; - Supported numbers -
; The program supports 16-bit unsigned integers (up to 65535).

; !! WARNING !!
; emu8086 uses a US keyboard layout for input, so you must change your keyboard layout
; or refer to a US layout to select operations. Alternatively, change the key mappings
; in the "OPERATION SELECTION" block.

.model SMALL
.stack 100h
.data
; Variables
; Data
   op_input              db          12, ?, 11 dup('$')       ; Limits input to (16-bit number) + (operator) + (16-bit number)
   input_counter         dw          0                        ; Stores the input index
   result                dw          0                        ; Temporary value used for conversions
   op1                   dw          0                        ; Operand 1
   op2                   dw          0                        ; Operand 2
   op                    db          1, 1 dup(0)              ; Operation to perform
   int_lenght            db          2, 1 dup(0)              ; Stores the length of the first number

; Strings
   welcome               db          'Calcolatrice - Operatori supportati +,-,*,/,^,!,&,|,r (sqrt) $'
   divider               db          10,13, '-----------------------------------------------------------$'  
   error                 db          10, 13, 'ERROR!!$'    
   counter_string        db          10, 13, 7 dup('$')       ; Stores the input counter as a printable string
   result_string         db          8, ?, 7 dup('$')         ; Stores operation results
   result_is             db          10, 13, '= $'            ; Prints the equals sign
   bye                   db          10, 13, 'bye...$'
   
      
.code
main proc
; Load the data segment
   mov ax , @data
   mov ds , ax
         
         
; INTRO
   ; Welcome
      mov ah , 9h
      lea dx , welcome
      int 21h
   ; Text Divider
      lea dx , divider
      int 21h 
      
      
rerun:                                 ; Entry point for running the program again after an operation completes
; VARIABLE INITIALIZATION
   ; Initialize result_string
   lea si, result_string+2             ; SI points to the third byte
   mov cx, 7                           ; Count 7 bytes
   init_loop:                        
       mov byte ptr [si], '$'          ; Set the current byte to '$'
       inc si                          ; Move to the next byte
       loop init_loop                  ; Repeat until CX = 0
; INPUT PROMPT
   ; Increment the prompt counter
      inc input_counter                ; Track the number of entered operations
      mov ax , input_counter           ; Move the counter to AX
      lea si , counter_string + 2      ; Store the address of the string + 2 in SI (for the procedure)
      mov result , 0                   ; Initialize result
      call getString                   ; Convert an integer to a string
   ; Print counter
      mov ah , 9h                   
      lea dx , counter_string 
      int 21h
   ; Print closing bracket
      mov ah , 2h
      mov dl , ']'
      int 21h
   ; Print space
      mov dl , ' '
      int 21h
        
        
; INPUT REQUEST
   ; Input
      mov ah , 0ah
      lea dx , op_input
      int 21h
        
        
; INPUT ANALYSIS
   ; Set up getInt
      lea si , op_input                ; Load the operand offset into SI (for the procedure)
      mov result , 0                   ; Reset result
   ; Call getInt for op1
      call getInt                      ; Get the first operand
      mov ax , result                  ; Save the procedure output in AX
      mov op1, ax                      ; Move the result to op1
   ; Call getOperator
      call getOperator                 ; Extract the operator
   ; Setup getInt
      dec si                           ; Decrement SI (debug)
      mov result , 0                   ; Reset result
   ; Call getInt for op2
      call getInt                      ; Get the second number
      mov ax , result                  ; Save the procedure output in AX
      mov op2, ax                      ; Move the result to op2
      
         
; OPERATION SELECTION
   cmp op , '+'
   je case_sum
   cmp op , '-'
   je case_sub
   cmp op , '*'
   je case_mul 
   cmp op , '/'
   je case_div
   cmp op , '^'
   je case_pow 
   cmp op , 'r'
   je case_sqrt
   cmp op , '!'
   je case_fact
   cmp op , '&'
   je case_and 
   cmp op , '|'
   je case_or
   cmp op , 'x'
   je case_exit
   cmp op , 'X'
   je case_exit

   

; OPERATION HANDLING
   ; Addition
      case_sum:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationSum             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
         
   ; Subtraction
      case_sub:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationSub             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
         
   ; Multiplication
      case_mul:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationMul             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
         
   ; Division
      case_div:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationDiv             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
         
   ; Exponentiation
      case_pow:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationPow             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
   
   ; Square root
      case_sqrt:
         push op1                      ; Push the first operand onto the stack
         call operationSqrt            ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
   
   ; Factorial
      case_fact: 
         push op1                      ; Push the first operand onto the stack
         call operationFact            ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
  
   ; And
      case_and:
         push op1                      ; Push the first operand onto the stack
         push op2                      ; Push the second operand onto the stack
         call operationAnd             ; Call the procedure
         jmp print_res                 ; Print the result after the procedure returns
   
   ; Or
      case_or:
         push op1 
         push op2
         call operationOr
         jmp print_res      
                    
   ; Exit the program
      case_exit: 
         mov ah , 9h
         lea dx , bye
         int 21h
         jmp fine  

   
; PRINT RESULT
print_res:
   ; Print equals sign
      mov ah , 9h 
      lea dx , result_is
      int 21h
   ; Print number
      lea dx , result_string
      int 21h
jmp rerun                              ; Run again for the next operation
                                       
           



; Procedures
; ------------------------------------------------------------------------------------------------------------------------------------
 
 
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
errorPrinter endp 




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


; PROCEDURE - operationDiv
   ; Divides two 16-bit unsigned numbers passed on the stack
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in AX
   ; Operand 2 = Passed on the stack and stored in BX
   
   ; - Return -
   ; Returns when the result has been converted to a printable string

operationDiv proc 
   ; Save data
      pop di                          ; Save the return address in DI
      pop bx                          ; Save the second operand in BX
      pop ax                          ; Save the first operand in AX
   ; Division
      div cx
   ; Convert the integer part
      lea si , result_string + 2      ; Load the result variable address
      call getString                  ; Convert the integer to a string
   ; Return
      push di
      ret 
operationDiv endp 


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


; PROCEDURE - operationAnd
   ; Performs a bitwise AND operation on two numbers
   
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in AX
   ; Operand 2 = Passed on the stack and stored in CX
   
   ; - Return - 
   ; Returns when conversion is complete
   
operationAnd proc
   ; Save data
   pop di                          ; Save the return address in DI
   pop cx                          ; Save the second operand in CX
   pop ax                          ; Save the first operand in AX
   ; Operation
   and ax , cx 
   ; Conversion
   lea si , result_string + 2
   call getString
   ; Return
   push di
   ret  
operationAnd endp


; PROCEDURE - operationOr
   ; Performs a bitwise OR operation on two numbers
  
   ; - Parameters -
   ; Operand 1 = Passed on the stack and stored in AX
   ; Operand 2 = Passed on the stack and stored in CX
   
   ; - Return - 
   ; Returns when conversion is complete
   
operationOr proc
   ; Save data
   pop di                          ; Save the return address in DI
   pop cx                          ; Save the second operand in CX
   pop ax                          ; Save the first operand in AX
   ; Operation
   or ax , cx
   ; Conversion
   lea si , result_string + 2
   call getString
   ; Return
   push di
   ret   
operationOr endp

; END
   fine:                                                                    
      hlt
