# ASM Calculator - Comprehensive Test Plan

## Overview
This document provides comprehensive test cases for the ASMCalculator (emu8086) with different inputs to validate all operations.

**Supported Range**: 16-bit unsigned integers (0 - 65535)

## Test Instructions
1. Load `ASMCalculator.asm` in emu8086
2. Set keyboard layout to US (American)
3. Compile and run the program
4. Enter test cases in format: `number1operator number2` (e.g., `5+3`)
5. For unary operations (factorial, square root), second number is ignored

---

## 1. Addition Tests (+)

### Basic Addition
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Small numbers | `5+3` | `8` | Basic addition |
| With zero | `100+0` | `100` | Identity element |
| Same numbers | `25+25` | `50` | Double value |
| Large numbers | `30000+20000` | `50000` | Mid-range |
| Maximum safe | `32000+32000` | `64000` | Near limit |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Zero + zero | `0+0` | `0` | Minimum values |
| One + one | `1+1` | `2` | Minimum non-zero |
| Maximum value | `65535+0` | `65535` | Maximum 16-bit unsigned |
| Near overflow | `65000+535` | `65535` | Boundary test |

### Overflow Cases (May produce incorrect results)
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| Overflow test | `65535+1` | Wraps to `0` or incorrect | Exceeds 16-bit |
| Large overflow | `50000+20000` | Incorrect (70000 > 65535) | Well beyond limit |

---

## 2. Subtraction Tests (-)

### Basic Subtraction
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Simple | `10-5` | `5` | Basic subtraction |
| Large numbers | `1000-500` | `500` | Mid-range |
| To zero | `42-42` | `0` | Result is zero |
| From maximum | `65535-100` | `65435` | Large minuend |
| Small difference | `1000-999` | `1` | Near equal |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| From zero | `1-0` | `1` | Subtracting zero |
| Maximum - 1 | `65535-1` | `65534` | Near maximum |

### Error Cases (Negative Results)
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| Negative result | `5-10` | `ERROR!!` | Would be -5 |
| Zero minus | `0-1` | `ERROR!!` | Would be -1 |
| Large difference | `100-1000` | `ERROR!!` | Would be -900 |

---

## 3. Multiplication Tests (*)

### Basic Multiplication
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Small numbers | `5*3` | `15` | Basic multiplication |
| By one | `42*1` | `42` | Identity element |
| By zero | `100*0` | `0` | Zero property |
| Powers of 2 | `8*8` | `64` | Perfect square |
| Mid-range | `100*100` | `10000` | Larger values |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| 1 * 1 | `1*1` | `1` | Minimum non-zero |
| Large factor | `255*255` | `65025` | Near maximum |
| Maximum by 1 | `65535*1` | `65535` | Maximum value |

### Overflow Cases (May produce incorrect results)
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| Overflow | `256*256` | Incorrect (65536 > 65535) | Exceeds 16-bit |
| Large overflow | `1000*100` | Incorrect (100000 > 65535) | Well beyond limit |

---

## 4. Division Tests (/)

### Basic Division
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Simple | `10/2` | `5` | Even division |
| With remainder | `10/3` | `3` | Integer division only |
| Large numbers | `1000/10` | `100` | Mid-range |
| By one | `42/1` | `42` | Identity |
| Self-division | `100/100` | `1` | Same numbers |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Zero divided | `0/5` | `0` | Zero dividend |
| Maximum value | `65535/1` | `65535` | Large dividend |
| Large divisor | `100/100` | `1` | Equal values |

### Special Cases
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| Division by zero | `10/0` | May crash or error | Undefined operation |
| 1/2 | `1/2` | `0` | Result < 1 (integer division) |

**Note**: Division only returns integer part (no decimals/fractions)

---

## 5. Power Tests (^)

### Basic Power
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Small exponent | `2^3` | `8` | Basic power |
| To power of 1 | `10^1` | `10` | Identity |
| Squared | `5^2` | `25` | Square |
| Cubed | `3^3` | `27` | Cube |
| Larger power | `2^8` | `256` | Power of 2 |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Power of 0 | `5^0` | May be incorrect | Should be 1 |
| 1 to any power | `1^10` | `1` | One raised |
| 0 to power | `0^5` | `0` | Zero raised |
| 2^10 | `2^10` | `1024` | Large result |

### Overflow Cases
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| Large exponent | `10^5` | Incorrect (100000 > 65535) | Overflow |
| 2^16 | `2^16` | Incorrect (65536 > 65535) | Exact overflow point |
| 3^10 | `3^10` | Incorrect (59049 < 65535 OK) | Actually fits! |

---

## 6. Factorial Tests (!)

### Basic Factorial
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Small | `5!` or `5!0` | `120` | 5! = 120 |
| Very small | `3!` or `3!0` | `6` | 3! = 6 |
| Medium | `6!` or `6!0` | `720` | 6! = 720 |
| Larger | `7!` or `7!0` | `5040` | 7! = 5040 |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| 0 factorial | `0!` or `0!0` | `1` | By definition 0! = 1 |
| 1 factorial | `1!` or `1!0` | `1` | 1! = 1 |
| 2 factorial | `2!` or `2!0` | `2` | 2! = 2 |
| 8 factorial | `8!` or `8!0` | `40320` | 8! = 40320 |

### Overflow Cases
| Test Case | Input | Expected Behavior | Notes |
|-----------|-------|-------------------|-------|
| 9 factorial | `9!` or `9!0` | Incorrect (362880 > 65535) | Overflow |
| 10 factorial | `10!` or `10!0` | Incorrect (3628800 > 65535) | Large overflow |

**Note**: Maximum safe factorial is 8! = 40320

---

## 7. Bitwise AND Tests (&)

### Basic AND
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Simple | `12&10` | `8` | 1100 & 1010 = 1000 |
| All bits | `15&15` | `15` | Same value |
| With zero | `255&0` | `0` | Zero masks all |
| Powers of 2 | `8&4` | `0` | No common bits |
| Mask test | `255&15` | `15` | Lower nibble |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| 0 & 0 | `0&0` | `0` | Minimum |
| Max & Max | `65535&65535` | `65535` | All bits set |
| Alternating | `21845&43690` | `0` | 0x5555 & 0xAAAA |

### Practical Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Even check | `5&1` | `1` | Bit 0 check (odd) |
| Even check | `4&1` | `0` | Bit 0 check (even) |
| High byte mask | `65535&65280` | `65280` | Mask low byte |

---

## 8. Bitwise OR Tests (|)

### Basic OR
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Simple | `12|10` | `14` | 1100 | 1010 = 1110 |
| With zero | `42|0` | `42` | Identity |
| Powers of 2 | `8|4` | `12` | Combine bits |
| Nibbles | `15|240` | `255` | Lower | upper |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| 0 | 0 | `0|0` | `0` | Minimum |
| Max | Max | `65535|65535` | `65535` | All bits |
| Alternating | `21845|43690` | `65535` | 0x5555 | 0xAAAA = 0xFFFF |

### Practical Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Set bit | `4|1` | `5` | Set bit 0 |
| Combine bytes | `256|1` | `257` | High and low byte |

---

## 9. Square Root Tests (r)

### Basic Square Root
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Perfect square | `9r0` | `3` | √9 = 3 |
| Perfect square | `16r0` | `4` | √16 = 4 |
| Perfect square | `25r0` | `5` | √25 = 5 |
| Perfect square | `100r0` | `10` | √100 = 10 |
| Perfect square | `144r0` | `12` | √144 = 12 |

### Non-Perfect Squares (Integer Result)
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Rounds down | `10r0` | `3` | √10 ≈ 3.16, returns 3 |
| Rounds down | `15r0` | `3` | √15 ≈ 3.87, returns 3 |
| Rounds down | `99r0` | `9` | √99 ≈ 9.95, returns 9 |
| Rounds down | `101r0` | `10` | √101 ≈ 10.05, returns 10 |

### Edge Cases
| Test Case | Input | Expected Result | Notes |
|-----------|-------|----------------|-------|
| Zero | `0r0` | `0` | √0 = 0 |
| One | `1r0` | `1` | √1 = 1 |
| Large perfect | `256r0` | `16` | √256 = 16 |
| Maximum perfect | `65025r0` | `255` | √65025 = 255 (largest perfect square in range) |
| Near maximum | `65535r0` | `255` | √65535 ≈ 255.99 |

**Note**: Only returns integer part (no decimals)

---

## 10. Exit Test (x or X)

| Test Case | Input | Expected Behavior |
|-----------|-------|-------------------|
| Lowercase exit | `x` | Program displays "bye..." and halts |
| Uppercase exit | `X` | Program displays "bye..." and halts |

---

## Test Execution Checklist

### Pre-Test Setup
- [ ] emu8086 is installed and working
- [ ] Keyboard layout set to US (American)
- [ ] ASMCalculator.asm loaded in emu8086
- [ ] Program compiled successfully

### Testing Procedure
1. Run compiled program
2. Enter test case when prompted
3. Verify result matches expected output
4. If ERROR!! appears, verify it's expected for that case
5. Continue to next operation (program loops until exit)

### Operation Coverage
- [ ] Addition (+) - All test cases
- [ ] Subtraction (-) - All test cases including error cases
- [ ] Multiplication (*) - All test cases including overflow
- [ ] Division (/) - All test cases including by zero
- [ ] Power (^) - All test cases including overflow
- [ ] Factorial (!) - All test cases (max safe is 8!)
- [ ] Bitwise AND (&) - All test cases
- [ ] Bitwise OR (|) - All test cases
- [ ] Square Root (r) - All test cases
- [ ] Exit (x/X) - Both cases

### Known Limitations
1. **16-bit unsigned only**: Range 0-65535
2. **No decimal support**: Division and sqrt return integers only
3. **Overflow not handled**: Results > 65535 will be incorrect
4. **Negative results error**: Subtraction showing ERROR!! is correct behavior
5. **US keyboard layout required**: Or code modification needed

---

## Quick Test Suite (Smoke Test)

Run these 20 tests to quickly verify all operations work:

1. `5+3` → `8`
2. `10-5` → `5`
3. `5-10` → `ERROR!!`
4. `6*7` → `42`
5. `20/4` → `5`
6. `2^8` → `256`
7. `5!0` → `120`
8. `12&10` → `8`
9. `12|10` → `14`
10. `16r0` → `4`
11. `0+0` → `0`
12. `100-100` → `0`
13. `42*1` → `42`
14. `100/10` → `10`
15. `10^2` → `100`
16. `3!0` → `6`
17. `255&15` → `15`
18. `8|4` → `12`
19. `25r0` → `5`
20. `x` → Program exits

---

## Bug Report Template

If you find issues, document them as follows:

**Input**: [what you entered]
**Expected**: [what should happen]
**Actual**: [what actually happened]
**Operation**: [which operator]
**Notes**: [any additional context]

---

## Notes

- Always use US keyboard layout or modify the operation selection code block
- Results are displayed after each calculation
- Program loops until you enter 'x' or 'X' to exit
- The prompt counter [1], [2], [3]... tracks how many operations you've performed
- Second operand is ignored for unary operations (!, r)
