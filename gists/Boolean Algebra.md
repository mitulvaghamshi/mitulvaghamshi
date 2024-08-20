## Boolean Algebra

Boolean algebra and logic gates are fundamental concepts in digital electronics,
computer science, and mathematics.

### **Boolean Algebra:**

Boolean algebra is a mathematical system that deals with logical operations and
variables that can have only two values: TRUE (1) and FALSE (0). It was invented
by George Boole in the mid-19th century. Boolean algebra is used to simplify
complex digital circuits and design digital systems.

### **Boolean Variables:**

Boolean variables are represented by uppercase letters (A, B, C, etc.). They can
have only two values:

- TRUE (1)
- FALSE (0)

### **Boolean Operations:**

There are three basic Boolean operations:

AND (Conjunction): Represented by the symbol ∧ (or a dot {.} ) A ∧ B = 1 if both
A and B are 1, otherwise 0

- A = 1, B = 1, A ∧ B = 1
- A = 1, B = 0, A ∧ B = 0

OR (Disjunction): Represented by the symbol ∨ (or a plus sign +) A ∨ B = 1 if
either A or B (or both) are 1, otherwise 0

- A = 1, B = 1, A ∨ B = 1
- A = 1, B = 0, A ∨ B = 1
- A = 0, B = 1, A ∨ B = 1

NOT (Negation): Represented by the symbol ~ (or a bar over the variable) ~A = 1
if A is 0, otherwise 0

- A = 1, ~A = 0
- A = 0, ~A = 1

### **Logic Gates:**

Logic gates are electronic circuits that perform Boolean operations. They are
the building blocks of digital systems.

1. AND Gate: Input: A, B Output: A ∧ B
2. OR Gate: Input: A, B Output: A ∨ B
3. NOT Gate (Inverter): Input: A Output: ~A
4. NAND Gate: Input: A, B Output: ~(A ∧ B)
5. NOR Gate: Input: A, B Output: ~(A ∨ B)
6. XOR Gate (Exclusive OR): Input: A, B Output: A ⊕ B (1 if A and B are
   different, 0 if they are the same)

### **Properties of Boolean Algebra:**

- Commutative Property: A ∧ B = B ∧ A, A ∨ B = B ∨ A
- Associative Property: (A ∧ B) ∧ C = A ∧ (B ∧ C), (A ∨ B) ∨ C = A ∨ (B ∨ C)
- Distributive Property: A ∧ (B ∨ C) = (A ∧ B) ∨ (A ∧ C), A ∨ (B ∧ C) = (A ∨ B) ∧ (A ∨ C)
- Identity Property: A ∧ 1 = A, A ∨ 0 = A
- Inverse Property: A ∧ ~A = 0, A ∨ ~A = 1

### **Applications of Boolean Algebra and Logic Gates:**

- Digital Electronics
- Computer Science
- Cryptography
- Coding Theory
- Network Topology

## Boolean Operations:

### AND (Conjunction)

| A | B | A ∧ B |
| - | - | ----- |
| 0 | 0 | 0     |
| 0 | 1 | 0     |
| 1 | 0 | 0     |
| 1 | 1 | 1     |

### OR (Disjunction)

| A | B | A ∨ B |
| - | - | ----- |
| 0 | 0 | 0     |
| 0 | 1 | 1     |
| 1 | 0 | 1     |
| 1 | 1 | 1     |

### NOT (Negation)

| A | ~A |
| - | -- |
| 0 | 1  |
| 1 | 0  |

## Logic Gates:

### AND Gate

| A | B | A ∧ B |
| - | - | ----- |
| 0 | 0 | 0     |
| 0 | 1 | 0     |
| 1 | 0 | 0     |
| 1 | 1 | 1     |

### OR Gate

| A | B | A ∨ B |
| - | - | ----- |
| 0 | 0 | 0     |
| 0 | 1 | 1     |
| 1 | 0 | 1     |
| 1 | 1 | 1     |

### NOT Gate (Inverter)

| A | ~A |
| - | -- |
| 0 | 1  |
| 1 | 0  |

### NAND Gate

| A | B | A NAND B |
| - | - | -------- |
| 0 | 0 | 1        |
| 0 | 1 | 1        |
| 1 | 0 | 1        |
| 1 | 1 | 0        |

### NOR Gate

| A | B | A NOR B |
| - | - | ------- |
| 0 | 0 | 1       |
| 0 | 1 | 0       |
| 1 | 0 | 0       |
| 1 | 1 | 0       |

### XOR Gate (Exclusive OR)

| A | B | A ⊕ B |
| - | - | ----- |
| 0 | 0 | 0     |
| 0 | 1 | 1     |
| 1 | 0 | 1     |
| 1 | 1 | 0     |
