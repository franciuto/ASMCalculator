# Assembly Calculator (emu8086)

## Description
This project implements an **Assembly calculator** using emu8086. The calculator can perform arithmetic and bitwise operations on 16-bit unsigned integers.

## Supported Operations
The calculator supports the following operations:

1. **Addition**
2. **Subtraction**
3. **Multiplication**
4. **Division**
5. **Exponentiation**
6. **Factorial**
7. **Bitwise AND**
8. **Bitwise OR**
9. **Square root**

## Technical Details
- **Supported numbers:** 16-bit unsigned integers (0–65,535).
- **Input:** The program uses the US keyboard layout.
  - If you are using a different layout, refer to a US keyboard layout chart or modify the operation selection code block.

## Requirements
- **emu8086:** An 8086 emulator required to run the Assembly code.
- **US keyboard layout** (or code modifications to accommodate a different layout).

## Usage Instructions
1. **Keyboard Layout Configuration:**
   - Make sure your keyboard layout is set to "US" to select operations correctly.
   - Alternatively, you can modify the `SCELTA OPERAZIONE` (operation selection) code block in the `ASMCalculator.asm` file to match your keyboard layout.

2. **Compilation and Execution:**
   - Open the `ASMCalculator.asm` file in emu8086.
   - Compile the source code.
   - Run the program directly in emu8086.

3. **Operation Selection:**
   - Follow the on-screen instructions to select the desired operation and enter the input numbers.

## Important Notes
- **Precision:**
  - Division uses integer arithmetic (decimal numbers are not supported).
  - The square root operation returns only the integer part.

- **Overflow:**
  - The program does not automatically handle overflow. Entering numbers that are too large may produce incorrect results.

## Customization
To change the program's behavior, you can:
- Modify the input mappings in the `SCELTA OPERAZIONE` code block to match your keyboard layout.
- Add new operations following the existing code style.

## License
This project is distributed under the MIT License. See the `LICENSE` file (if included) for more details.
